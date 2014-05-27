/* ControlConfiguration
 * Author: leobrizolara
 * Creation date: 19/05/14

    A responsabilidade desta máquina é manter as configurações de um controle: 
        - manter mapeamento entre teclas e sinais
        - manter nome das teclas
        - manter perfis de controles
        - manter configurações
 */
MACHINE
    ControlConfiguration(profilesLimit)

SEES KeyType, SignalType, ProfileIdentifierType, IdentifierType, KeysToSignalsType, KeysToIdentifierType

CONSTRAINTS
    profilesLimit : NAT1

VARIABLES
    keysToSignal
  , keysToIdentifier
  , profileSignals
  , profileNames
  , currentProfile
INVARIANT
    keysToSignal : KEYS_TO_SIGNALS
    & keysToIdentifier : KEYS_TO_IDENTIFIERS
    & profileSignals : PROFILE_IDENTIFIER +-> KEYS_TO_SIGNALS
    & profileNames : PROFILE_IDENTIFIER +-> KEYS_TO_IDENTIFIERS
    & currentProfile : PROFILE_IDENTIFIER
INITIALISATION
    keysToSignal := KEYS * { nullSignal }
    || keysToIdentifier := KEYS * { nullIdentifier }
    || profileSignals := {}
    || profileNames := {}
    || currentProfile := nullProfileIdentifier

OPERATIONS

signal <-- getKeySignal ( key ) =
   PRE
       key : KEYS
   THEN
       signal := keysToSignal ( key )
   END;
ident <-- getKeyIdentifier ( key ) =
   PRE
       key : KEYS
   THEN
       ident := keysToIdentifier ( key )
   END;
   
signal, ident <-- getKeySignalAndId ( key ) =
   PRE
       key : KEYS
   THEN
       signal := keysToSignal(key)
       ||
       ident := keysToIdentifier ( key )
   END;

setKeySignal(key, signal) =
   PRE
       signal : SIGNALS & key : KEYS
   THEN
       keysToSignal := keysToSignal <+ { key |-> signal }
   END;

recorded <-- setKeyIdentifier ( key , ident ) =
   PRE
       key : KEYS & ident : CMD_IDENTIFIER
   THEN
       IF ident /: ran ( keysToIdentifier ) or ident = nullIdentifier
       THEN
           keysToIdentifier := keysToIdentifier <+ { key |-> ident } 
           ||
           recorded := TRUE
       ELSE
           recorded := FALSE
       END
   END;

keysToSignalsOut , keysToIdentifiersOut <-- getConfigurations =
   keysToSignalsOut , keysToIdentifiersOut := keysToSignal , keysToIdentifier;

setConfigurations ( keysToSign , keysToIds ) =
   PRE keysToSign : KEYS_TO_SIGNALS & keysToIds : KEYS_TO_IDENTIFIERS 
       /** Todos os identificadores são iguais, exceto aqueles que correspondem a nullIdentifier*/
       & ! ( key1 , key2 ) . ( key1 : KEYS & key2 : KEYS & key1 /= key2 
               => keysToIds ( key1 ) /= keysToIds ( key2 ) or keysToIds ( key1 ) = nullIdentifier )
   THEN
       keysToSignal , keysToIdentifier := keysToSign , keysToIds
   END;

success <-- saveProfile ( ident ) =
   PRE
       ident : PROFILE_IDENTIFIER
   THEN
       IF ( card ( profileSignals ) < profilesLimit or ( ident : dom ( profileSignals ) & ident : dom ( profileNames ) ) )
       THEN
           profileSignals := profileSignals <+ { ident |-> keysToSignal } ||
           profileNames := profileNames <+ { ident |-> keysToIdentifier } ||
           currentProfile := ident ||
           success := TRUE
       ELSE
           success := FALSE
       END
   END
   ;

success <-- loadProfile ( profileIdent ) =
   PRE
       profileIdent : PROFILE_IDENTIFIER
   THEN
       IF ( profileIdent : dom ( profileSignals ) )
       THEN
           keysToSignal := profileSignals ( profileIdent ) ||
           keysToIdentifier := profileNames ( profileIdent ) ||
           currentProfile := profileIdent ||
           success := TRUE
       ELSE
           success := FALSE
       END
   END;

profileName <-- getCurrentProfile =
    profileName := currentProfile

END
