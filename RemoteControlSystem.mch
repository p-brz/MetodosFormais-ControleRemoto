/* RemoteControlSystem
 * Author: leobrizolara
 * Creation date: 07/05/14
 
 TODO:
     - Criar operação para atualizar interface com usuario (updateInterface)
     - definir numero de teclas em parametro (?)
     
     - lidar com defaultProfile
 */
MACHINE RemoteControlSystem

SEES TemperatureType, SignalType, KeyType, IdentifierType, ProfileIdentifierType, KeysToSignalsType, KeysToIdentifierType
    
CONSTANTS 
          /** identificadores para as teclas de aumentar e diminuir temperatura*/
          saveProfilesLimit
    
PROPERTIES 
          /** consequencia da anterior, conjunto deve ser maior ou igual a 3*/
            /*& card(KEYS) >= 3*/
            /*& defaultProfile : PROFILE_IDENTIFIER
            & defaultProfile /= nullProfileIdentifier*/
            saveProfilesLimit :NAT1 
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
          /**signalSended representa um sinal que foi/será enviado*/ 
          , signalSended
    
INVARIANT currentTemperature : ALLOWED_TEMPS 
          & currentTemperature <= maxTemperature 
          & currentTemperature >= minTemperature
          & nameOut : CMD_IDENTIFIER
          & signalSended : SIGNALS
          & keyMap  : KEYS_TO_SIGNALS      
          & nullSignal /: ran(keyMap)
          & keyName : KEYS_TO_IDENTIFIERS
          & nullIdentifier /: ran(keyName)
          
          & currentProfileIdent : PROFILE_IDENTIFIER
          & savedProfilesSignals : 
                  PROFILE_IDENTIFIER +-> KEYS_TO_SIGNALS
          & savedProfilesNames : 
                  PROFILE_IDENTIFIER +-> KEYS_TO_IDENTIFIERS
          & dom(savedProfilesSignals) = dom(savedProfilesNames)
          & card(savedProfilesSignals) <= saveProfilesLimit 
          /** nullIdentifier não está contido em nenhum profile*/
          & !profIdent.(profIdent : dom(savedProfilesNames) =>
                         (nullIdentifier /: ran(savedProfilesNames(profIdent)))
                        )       
          & !profIdent.(profIdent : dom(savedProfilesSignals) =>
                         (nullSignal /: ran(savedProfilesSignals(profIdent)))
                        )                   
    
INITIALISATION  ANY temp WHERE temp : TEMPERATURES 
                              & temp>=minTemperature 
                              & temp <= maxTemperature
                THEN
                    currentTemperature := temp
                END
                || keyMap := {}
                || keyName := {}
                || signalSended := nullSignal
                || nameOut := nullIdentifier
                || currentProfileIdent := defaultProfile
                /** salva o perfil inicial*/
                /*|| savedProfilesSignals := 
                    {defaultProfile |-> SPECIAL_KEYS * {nullSignal}} 
                || savedProfilesNames   := 
                    {defaultProfile |-> (SPECIAL_KEYS * {nullIdentifier}) }*/
                || savedProfilesSignals := {} 
                || savedProfilesNames   := {}
                
OPERATIONS
  
temp <-- showCurrentTemperature = temp := currentTemperature;

signalWasSent <-- pressKey(key) =
    PRE key : KEYS
    THEN
        IF key = incKey THEN /** Aumenta temperatura, se possivel*/
            IF currentTemperature + 1 <= maxTemperature 
                &  currentTemperature + 1 : ALLOWED_TEMPS
            THEN
                /** Se possivel, algum sinal será enviado*/
                ANY sign WHERE sign : SIGNALS THEN
                    IF sign /= nullSignal 
                    THEN        
                        currentTemperature := currentTemperature + 1
                        ||
                        signalSended := sign
                        ||
                        IF key : dom(keyName) THEN
                            nameOut := keyName(key)
                        ELSE
                            nameOut := nullIdentifier
                        END
                        ||    
                        signalWasSent := TRUE
                    ELSE
                        signalWasSent := FALSE
                    END
                END
            ELSE
                signalWasSent := FALSE
            END
        ELSIF key = decKey THEN /** Diminui temperatura, se possivel*/
            IF currentTemperature - 1 >= minTemperature 
                &  currentTemperature - 1 : ALLOWED_TEMPS 
            THEN
                /** Se possivel, algum sinal será enviado*/
                ANY sign WHERE sign : SIGNALS THEN
                    IF sign /= nullSignal 
                    THEN
                        currentTemperature := currentTemperature - 1
                        ||
                        signalSended := sign
                        ||
                        IF key : dom(keyName) THEN
                            nameOut := keyName(key)
                        ELSE
                            nameOut := nullIdentifier
                        END
                        ||    
                        signalWasSent := TRUE
                    ELSE
                        signalWasSent := FALSE
                    END
                END
            ELSE
                signalWasSent := FALSE
            END
        ELSIF key : SPECIAL_KEYS & key : dom(keyMap) THEN
            /** Não garante que o sinal poderá ser enviado*/
            CHOICE
                signalSended := keyMap(key)
                ||
                IF key : dom(keyName) THEN
                    nameOut := keyName(key)
                ELSE
                    nameOut := nullIdentifier
                END
                ||    
                signalWasSent := TRUE
            OR
                signalWasSent := FALSE
            END
        ELSE
            signalWasSent := FALSE
        END      
    END;

/** recebe sinal e grava mapeamento entre tecla e sinal
*/
recorded <-- recordKeySignal( key) =
    PRE key : KEYS
    THEN
        IF key : SPECIAL_KEYS THEN
            ANY sign WHERE sign : SIGNALS
            THEN
                IF sign /= nullSignal
                THEN
                    keyMap(key) := sign
                    ||
                    recorded := TRUE
                ELSE
                    recorded := FALSE
                END
            END
        ELSE
            recorded := FALSE
        END
    END;
    
/*clearKeySignal(key) =
    PRE key : KEYS
    THEN
        IF key : dom(keyMap) THEN 
            keyMap := keyMap - {key |-> keyMap(key)}
        END
    END;*/
    
clearKeySignal(key) =
    PRE key : KEYS
    THEN
        IF key : dom(keyMap) THEN 
            /*keyMap(key) := nullSignal*/
            keyMap := {key} <<|keyMap
        END
    END;
    
    
recorded <-- recordKeyIdentifier(key, ident) =
    PRE key : KEYS & ident : CMD_IDENTIFIER
    THEN
	    IF ident /= nullIdentifier 
	        & ident /: ran(keyName)
	    THEN
            keyName(key) := ident
	        ||
    	    recorded := TRUE
        ELSE
            recorded := FALSE
        END
    END;
    
clearKeyIdentifier(key) =
    PRE key : KEYS
    THEN
	    IF key : dom(keyName) 
	    THEN
            /*keyName := keyName - {key |-> keyName(key)}*/
            keyName := {key} <<| keyName
        END
    END;
    
ident <-- showKeyIdentifier(key) =
    PRE key : KEYS
    THEN
        IF key : dom(keyName) THEN
            ident:= keyName(key)
        ELSE
            ident := nullIdentifier
        END
    END;

success <-- saveCurrentProfile(ident) =
    PRE ident : PROFILE_IDENTIFIER 
        & nullIdentifier /: ran(keyName)
    THEN
        IF ident /= nullProfileIdentifier &
            ident /= defaultProfile &
            (card(savedProfilesSignals) < saveProfilesLimit or 
                (ident : dom(savedProfilesSignals) 
                    & ident : dom(savedProfilesNames)
                )
            ) 
        THEN
            savedProfilesSignals(ident) := keyMap
            || 
            savedProfilesNames(ident) := keyName
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
        IF profileIdent /= nullProfileIdentifier 
            & (profileIdent : dom(savedProfilesSignals)) 
        THEN
            IF profileIdent /= defaultProfile THEN
                keyMap  := savedProfilesSignals(profileIdent)
                ||
                keyName := savedProfilesNames(profileIdent)
            ELSE
                keyMap  := {}
                ||
                keyName := {}
            END
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


