/* RemoteControlSystem
 * Author: leobrizolara
 * Creation date: 07/05/14
 */
MACHINE RemoteControlSystem

SEES TemperatureType, SignalType, KeyType, IdentifierType, ProfileIdentifierType, 
    KeysToIdentifierType, KeysToSignalsType
    
INCLUDES AirSignalController   
  
  
CONSTANTS maxTemperature, minTemperature, 
          SPECIAL_KEYS, 
          /** teclas para aumentar e diminuir temperatura*/
          incKey, decKey,
          defaultProfile,
          saveProfilesLimit,
          ALLOWED_TEMPS
    
PROPERTIES 
            ALLOWED_TEMPS <: TEMPERATURES
            & card(ALLOWED_TEMPS) >= 2
            & maxTemperature = max(ALLOWED_TEMPS)
            & minTemperature = min(ALLOWED_TEMPS)
            & incKey : KEYS
            & decKey : KEYS
            & SPECIAL_KEYS = KEYS - {incKey,decKey}
          /** teclas para aumentar e diminuir devem ser diferentes*/
            & incKey /= decKey
          /** consequencia da anterior, conjunto deve ser maior ou igual a 3*/
            & card(KEYS) >= 3
            & defaultProfile : PROFILE_IDENTIFIER
            & saveProfilesLimit :NAT1 
            & saveProfilesLimit <= card(PROFILE_IDENTIFIER)
    
VARIABLES currentTemperature
          , keyMap
          , keyName
          /**nameOut representa um canal de saída para exibir a ultima 
          tecla que foi pressionada*/ 
          , nameOut
          , savedProfilesSignals
          , savedProfilesNames
          , currentProfileIdent
    
INVARIANT currentTemperature : TEMPERATURES 
          & currentTemperature <= maxTemperature 
          & currentTemperature >= minTemperature
          & signalOut : SIGNALS
          & nameOut : CMD_IDENTIFIER
          & keyMap : KEYS_TO_SIGNALS 
          & keyName : KEYS_TO_IDENTIFIERS
          /** em keyName só pode haver repeticoes de identificador para o nullIdentifier */
          & !(key1,key2).(key1 : KEYS & key2 : KEYS & key1 /= key2 
                             => keyName(key1) /= keyName(key2) or keyName(key1) = nullIdentifier)
          & savedProfilesSignals : PROFILE_IDENTIFIER +-> KEYS_TO_SIGNALS
          & savedProfilesNames : PROFILE_IDENTIFIER +-> KEYS_TO_IDENTIFIERS
          & dom(savedProfilesSignals) = dom(savedProfilesNames)
          & currentProfileIdent : PROFILE_IDENTIFIER
          /** só pode haver repeticoes de identificador para o nullIdentifier */
          & !keysToIds.(keysToIds :KEYS_TO_IDENTIFIERS  & keysToIds : ran(savedProfilesNames) =>
                          (!(key1,key2).(key1 : dom(keysToIds) & key2 : dom(keysToIds) & key1 /= key2
                             => keysToIds(key1) /= keysToIds(key2) or keysToIds(key1) = nullIdentifier)
                          )
                        )
          & card(savedProfilesSignals) <= saveProfilesLimit 
          & card(savedProfilesNames) = card(savedProfilesSignals)                      
    
INITIALISATION  ANY temp WHERE temp : TEMPERATURES 
                              & temp>=minTemperature 
                              & temp <= maxTemperature
                THEN
                    currentTemperature := temp
                END
                || keyMap := KEYS * {nullSignal}
                || keyName := KEYS * {nullIdentifier}
                || nameOut := nullIdentifier
                || currentProfileIdent := defaultProfile
                /** salva o perfil inicial*/
                || savedProfilesSignals := {defaultProfile |-> KEYS * {nullSignal}}
                || savedProfilesNames   := {defaultProfile |-> KEYS * {nullIdentifier}}
                
OPERATIONS
    
result <-- increaseTemperature =
    IF currentTemperature + 1 <= maxTemperature 
        &  currentTemperature + 1 : TEMPERATURES 
    THEN
        currentTemperature := currentTemperature + 1
        ||
        sendTemperatureSignal(currentTemperature + 1)
        ||
        nameOut := keyName(incKey)
        ||
        result := TRUE
    ELSE
        result := FALSE
    END;
    
result <-- decreaseTemperature =
    IF currentTemperature - 1 >= minTemperature 
        &  currentTemperature - 1 : TEMPERATURES 
    THEN
        currentTemperature := currentTemperature - 1
        ||
        sendTemperatureSignal(currentTemperature - 1)
        ||
        nameOut := keyName(decKey)
        ||
        result := TRUE
    ELSE
        result := FALSE
    END;

temp <-- showCurrentTemperature = temp := currentTemperature;

/** Esta função corresponde a ação que o sistema deveria realizar ao ser pressionada uma tecla.*/
pressSpecialKey(key) =
    PRE key : SPECIAL_KEYS
    THEN
        sendSignal(keyMap(key))
        ||
        nameOut := keyName(key)
    END;
    
recordSignal(signal, key) =
    PRE signal : SIGNALS & key : SPECIAL_KEYS
    THEN
        keyMap := keyMap <+ {key |-> signal}
    END;
    
recorded <-- recordKeyIdentifier(key, ident) =
    PRE key : KEYS & ident : CMD_IDENTIFIER
    THEN
	    IF ident /: ran(keyName) or ident = nullIdentifier THEN
            keyName := keyName <+ {key |-> ident}
	    ||
	    recorded := TRUE
        ELSE
            recorded := FALSE
        END
    END;
    
ident <-- showKeyIdentifier(key) =
    PRE key : KEYS
    THEN
        ident:= keyName(key)
    END;

keysToSignals, keysToIdentifiers <-- exportConfigurations =
            keysToSignals, keysToIdentifiers :=  keyMap, keyName;
    
importConfigurations(keysToSignals, keysToIds) =
    PRE keysToSignals : KEYS_TO_SIGNALS & keysToIds : KEYS_TO_IDENTIFIERS
          /** só pode haver repeticoes de identificador para o nullIdentifier */
          & !(key1,key2).(key1 : KEYS & key2 : KEYS & key1 /= key2 
                             => keysToIds(key1) /= keysToIds(key2) or keysToIds(key1) = nullIdentifier)
    THEN
        keyMap, keyName := keysToSignals, keysToIds       
    END;

success <-- saveCurrentProfile(ident) =
    PRE ident : PROFILE_IDENTIFIER
    THEN
        IF(card(savedProfilesSignals) < saveProfilesLimit or 
                (ident : dom(savedProfilesSignals) & ident : dom(savedProfilesNames))) 
        THEN
            savedProfilesSignals := savedProfilesSignals <+ {ident |-> keyMap}
            || 
            savedProfilesNames := savedProfilesNames <+ {ident |-> keyName}
            ||
            currentProfileIdent := ident
            ||
            success := TRUE
        ELSE
            success := FALSE
        END
    END;
    
success <-- loadProfileToCurrent(profileIdent) =
    PRE profileIdent : PROFILE_IDENTIFIER
    THEN
        IF(profileIdent : dom(savedProfilesSignals)) THEN
            keyMap  := savedProfilesSignals(profileIdent)
            ||
            keyName := savedProfilesNames(profileIdent)
            ||
            currentProfileIdent := profileIdent
            ||
success := TRUE
        ELSE
    	    success := FALSE
        END   
    END;
    
currentProfileName <-- showCurrentProfileIdentification =
        currentProfileName := currentProfileIdent

END


