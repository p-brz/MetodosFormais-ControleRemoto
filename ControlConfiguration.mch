/* ControlConfiguration
 * Author: leobrizolara
 * Creation date: 19/05/14

    A responsabilidade desta máquina é manter as configurações de um controle: 
        - manter mapeamento entre teclas e sinais
        - manter nome das teclas
        - manter perfis de controles
        - manter configurações
        
   TODO: remover profile
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
    & nullSignal /: ran(keysToSignal)
    & nullIdentifier /: ran(keysToIdentifier)
    
    & currentProfile : PROFILE_IDENTIFIER
    & profileSignals : PROFILE_IDENTIFIER +-> KEYS_TO_SIGNALS
    & profileNames : PROFILE_IDENTIFIER +-> KEYS_TO_IDENTIFIERS
    & dom(profileSignals) = dom(profileNames)
    & !profIdent.(profIdent : dom(profileNames) =>
                     (nullIdentifier /: ran(profileNames(profIdent)))
                   & (nullSignal    /: ran(profileSignals(profIdent)))
                 )  
    
INITIALISATION
    keysToSignal := {}
    || keysToIdentifier := {}
    || profileSignals := {}
    || profileNames := {}
    || currentProfile := nullProfileIdentifier

OPERATIONS

signal <-- getKeySignal ( key ) =
   PRE
       key : KEYS
   THEN
       IF key : dom(keysToSignal) THEN
           signal := keysToSignal ( key )
       ELSE
           signal := nullSignal
       END
   END;

changed <-- setKeySignal(key, signal) =
   PRE
       signal : SIGNALS & key : KEYS
   THEN
       IF signal /= nullSignal THEN
           /*keysToSignal := keysToSignal <+ { key |-> signal }*/
           keysToSignal(key) := signal
           ||
           changed := TRUE
       ELSE
           changed := FALSE
       END
   END;

removeKeySignal(key) =
   PRE
       key : KEYS
   THEN
       IF key : dom(keysToSignal) THEN
           keysToSignal:= {key} <<| keysToSignal
       END
   END;

   
ident <-- getKeyIdentifier ( key ) =
   PRE
       key : KEYS
   THEN
       IF key : dom(keysToIdentifier) THEN
           ident := keysToIdentifier ( key )
       ELSE
           ident := nullIdentifier
       END
   END;
   
recorded <-- setKeyIdentifier ( key , ident ) =
   PRE
       key : KEYS & ident : CMD_IDENTIFIER
   THEN
       IF ident /= nullIdentifier 
	            & ident /: ran(keysToIdentifier)
       THEN
           keysToIdentifier( key) := ident 
           ||
           recorded := TRUE
       ELSE
           recorded := FALSE
       END
   END;

removeKeyIdentifier(key) =
    PRE key : KEYS
    THEN
	    IF key : dom(keysToIdentifier) 
	    THEN
            keysToIdentifier := {key} <<| keysToIdentifier
        END
    END;

saveProfile ( ident ) =
   PRE
       ident : PROFILE_IDENTIFIER & 
       ident /= nullProfileIdentifier &
       (card ( profileSignals ) < profilesLimit 
           or ( ident : dom ( profileSignals ) 
                   & ident : dom ( profileNames ) 
              ) 
       )
   THEN
       profileSignals(ident) := keysToSignal ||
       profileNames(ident) := keysToIdentifier  ||
       currentProfile := ident
   END
   ;

/*loadProfile ( profileIdent ) =
   PRE
       profileIdent : PROFILE_IDENTIFIER &
       (profileIdent /= nullProfileIdentifier )
   THEN
       IF profileIdent : dom ( profileSignals ) THEN
           keysToSignal := profileSignals ( profileIdent ) ||
           keysToIdentifier := profileNames ( profileIdent ) ||
           currentProfile := profileIdent
       END
   END;*/
   
loaded <-- loadProfile ( profileIdent ) =
   PRE
       profileIdent : PROFILE_IDENTIFIER
   THEN
       IF profileIdent /= nullProfileIdentifier & 
           profileIdent : dom ( profileSignals )
       THEN
            IF profileIdent /= defaultProfile THEN
               keysToSignal := profileSignals ( profileIdent ) ||
               keysToIdentifier := profileNames ( profileIdent )
            ELSE
                keysToSignal := {}
                ||
                keysToIdentifier := {}
            END
            ||
            currentProfile := profileIdent
            ||
            loaded := TRUE
       ELSE
           loaded := FALSE
       END
   END; 
   
contains <-- containsProfile(profileIdent) =
   PRE
       profileIdent : PROFILE_IDENTIFIER
   THEN
       IF profileIdent /= nullProfileIdentifier  & 
           profileIdent : dom ( profileSignals ) 
       THEN
           contains := TRUE
       ELSE
           contains := FALSE
       END
   END;
   
count <-- profileCount =
    count := card(dom(profileSignals));

profileName <-- getCurrentProfile =
    profileName := currentProfile

END
