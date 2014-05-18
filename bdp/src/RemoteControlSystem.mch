/* RemoteControlSystem
 * Author: leobrizolara
 * Creation date: 07/05/14
 */
MACHINE RemoteControlSystem

SETS SIGNAL ; KEY ; IDENTIFIER ; PROFILE_IDENTIFIER

CONCRETE_CONSTANTS TEMPERATURE , maxTemperature , minTemperature ,
          CONTROL_KEYS , SPECIAL_KEYS ,
          KEYS_TO_SIGNALS , KEYS_TO_IDENTIFIERS ,
          nullSignal , nullIdentifier ,
          /** teclas para aumentar, diminuir e definir temperatura*/
          incKey , decKey , setKey ,
          defaultProfile

PROPERTIES TEMPERATURE <: INT
            & card ( TEMPERATURE ) > 2
            & maxTemperature = max ( TEMPERATURE )
            & minTemperature = min ( TEMPERATURE )
            & nullSignal : SIGNAL
            & CONTROL_KEYS <: KEY
            & nullIdentifier : IDENTIFIER
            & KEYS_TO_SIGNALS     = CONTROL_KEYS --> SIGNAL
            & KEYS_TO_IDENTIFIERS = CONTROL_KEYS --> IDENTIFIER
            & incKey : CONTROL_KEYS
            & decKey : CONTROL_KEYS
            & setKey : CONTROL_KEYS
            & SPECIAL_KEYS = CONTROL_KEYS - { incKey , decKey , setKey }
          /** teclas para aumentar, diminuir e definir temperatura devem ser 
            diferentes*/
            & incKey /= decKey & incKey /= setKey & decKey /= setKey
          /** consequencia da anterior, conjunto deve ser maior ou igual a 3*/
            & card ( CONTROL_KEYS ) >= 3
            & defaultProfile : PROFILE_IDENTIFIER

ABSTRACT_VARIABLES currentTemperature ,
          keyMap ,
          keyName ,
          /**signalOut representa um canal de saída para o qual os sinais 
          do controle são enviados*/
          signalOut ,
          /**nameOut representa um canal de saída para exibir a ultima 
          tecla que foi pressionada*/
          nameOut
          , savedProfilesSignals
          , savedProfilesNames
          , currentProfileIdent

INVARIANT currentTemperature : TEMPERATURE
          & currentTemperature <= maxTemperature
          & currentTemperature >= minTemperature
          & signalOut : SIGNAL
          & nameOut : IDENTIFIER
          & keyMap : KEYS_TO_SIGNALS
          & keyName : KEYS_TO_IDENTIFIERS
          /** em keyName só pode haver repeticoes de identificador para o nullIdentifier */
          & ! ( key1 , key2 ) . ( key1 : CONTROL_KEYS & key2 : CONTROL_KEYS & key1 /= key2
                             => keyName ( key1 ) /= keyName ( key2 ) or keyName ( key1 ) = nullIdentifier )
          & savedProfilesSignals : PROFILE_IDENTIFIER +-> KEYS_TO_SIGNALS
          & savedProfilesNames : PROFILE_IDENTIFIER +-> KEYS_TO_IDENTIFIERS
          & dom ( savedProfilesSignals ) = dom ( savedProfilesNames )
          & currentProfileIdent : PROFILE_IDENTIFIER
          /** só pode haver repeticoes de identificador para o nullIdentifier */
          & ! keysToIds . ( keysToIds : KEYS_TO_IDENTIFIERS & keysToIds : ran ( savedProfilesNames ) =>
                          ( ! ( key1 , key2 ) . ( key1 : CONTROL_KEYS & key2 : CONTROL_KEYS & key1 /= key2
                             => keysToIds ( key1 ) /= keysToIds ( key2 ) or keysToIds ( key1 ) = nullIdentifier ) ) )

INITIALISATION  ANY temp WHERE temp : TEMPERATURE
                              & temp >= minTemperature
                              & temp <= maxTemperature
                THEN
                    currentTemperature := temp
                END
                || keyMap := CONTROL_KEYS * { nullSignal }
                || keyName := CONTROL_KEYS * { nullIdentifier }
                || signalOut :: SIGNAL
                || nameOut :: IDENTIFIER
                || currentProfileIdent := defaultProfile
                /** salva o perfil inicial*/
                || savedProfilesSignals := { defaultProfile |-> CONTROL_KEYS * { nullSignal } }
                || savedProfilesNames   := { defaultProfile |-> CONTROL_KEYS * { nullIdentifier }
}
OPERATIONS

setTemperature ( temp ) =
    PRE temp : TEMPERATURE
    THEN
        IF temp <= maxTemperature & temp >= minTemperature THEN
            currentTemperature := temp
            ||
            signalOut := keyMap ( setKey )
            ||
            nameOut := keyName ( setKey )
        END
    END ;

increaseTemperature =
    IF currentTemperature + 1 <= maxTemperature &  currentTemperature + 1 : TEMPERATURE
    THEN
        currentTemperature := currentTemperature + 1
        ||
        signalOut := keyMap ( incKey )
        ||
        nameOut := keyName ( incKey )
    END ;
    /*Ver se eh possivel chamar setTemperature*/
decreaseTemperature =
    IF currentTemperature - 1 >= minTemperature &  currentTemperature - 1 : TEMPERATURE
    THEN
        currentTemperature := currentTemperature - 1
        ||
        signalOut := keyMap ( decKey )
        ||
        nameOut := keyName ( decKey )
    END ;

temp <-- showTemperature = temp := currentTemperature ;

/** Esta função corresponde a ação que o sistema deveria realizar ao ser pressionada uma tecla.*/
pressSpecialKey ( key ) =
    PRE key : SPECIAL_KEYS
    THEN
        signalOut := keyMap ( key )
        ||
        nameOut := keyName ( key )
    END ;

recordSignal ( signal , key ) =
    PRE signal : SIGNAL & key : CONTROL_KEYS
    THEN
        keyMap := keyMap <+ { key |-> signal }
    END ;

recorded <-- recordKeyIdentifier ( key , ident ) =
    PRE key : CONTROL_KEYS & ident : IDENTIFIER
    THEN
        IF ident /: ran ( keyName ) or ident = nullIdentifier THEN
            keyName := keyName <+ { key |-> ident }
            ||
            recorded := TRUE
        ELSE
            recorded := FALSE
        END
    END ;

ident <-- showKeyIdentifier ( key ) =
    PRE key : CONTROL_KEYS
    THEN
        ident := keyName ( key )
    END ;

/*controlConfigurations <-- exportConfigurations =
            controlConfigurations :=  %key.(key : CONTROL_KEYS  | (keyMap(key),keyName(key)));*/
keysToSignals , keysToIdentifiers <-- exportConfigurations =
            keysToSignals , keysToIdentifiers := keyMap , keyName ;

/*importConfigurations(ctrlConfigs) =
    PRE ctrlConfigs : POW(CONTROL_CONFIGURATION) 
	/ ** ctrlConfigs deve possuir todas as CONTROL_KEYS no domínio e deve ter tamanho mínimo, ou seja, sem repetições.* /	
	& dom(ctrlConfigs) = CONTROL_KEYS & card(ctrlConfigs) = card(CONTROL_KEYS)
	/ ** todos os identificadores de teclas diferentes são diferentes entre si, 
	exceto aqueles iguais a nullIdentifier* /
	& !(key1,key2,sign1,sign2,ident1,ident2)
	        .(key1 : CONTROL_KEYS & key2 : CONTROL_KEYS
	        & sign1 : SIGNAL & sign2 : SIGNAL & ident1 : IDENTIFIER & ident2 : IDENTIFIER
	        & (key1 |-> (sign1 |-> ident1)) : ctrlConfigs 
	        & (key2 |-> (sign2 |-> ident2)) : ctrlConfigs   
	        & key1 /= key2 
                               => ident1 /= ident2 or ident1 = nullIdentifier)
    THEN
	    keyMap:=keyMap <+ {key, sign | key : CONTROL_KEYS & sign : SIGNAL & 
                                    #ident.(ident : IDENTIFIER & (key|->(sign |-> ident)) : ctrlConfigs)}
    	||
    	keyName:=keyName <+ {key, ident | key : CONTROL_KEYS & ident : IDENTIFIER & 
                                    #sign.(sign : SIGNAL & (key|->(sign |-> ident)) : ctrlConfigs)}
    END;
*/
importConfigurations ( keysToSignals , keysToIds ) =
    PRE keysToSignals : KEYS_TO_SIGNALS & keysToIds : KEYS_TO_IDENTIFIERS
          /** só pode haver repeticoes de identificador para o nullIdentifier */
          & ! ( key1 , key2 ) . ( key1 : CONTROL_KEYS & key2 : CONTROL_KEYS & key1 /= key2
                             => keysToIds ( key1 ) /= keysToIds ( key2 ) or keysToIds ( key1 ) = nullIdentifier )
    THEN
        keyMap , keyName := keysToSignals , keysToIds
    END ;


/*
saveCurrentProfile(ident) =
    PRE ident : PROFILE_IDENTIFIER
    THEN
        savedProfiles := savedProfiles <+   
                     {ident |-> %key.(key : CONTROL_KEYS  | (keyMap(key),keyName(key)))}
    END;
*/
saveCurrentProfile ( ident ) =
    PRE ident : PROFILE_IDENTIFIER
    THEN
        savedProfilesSignals := savedProfilesSignals <+ { ident |-> keyMap }
        ||
        savedProfilesNames := savedProfilesNames <+ { ident |-> keyName }
    END ;
/*
success <-- loadProfile(profileIdent) =
    PRE profileIdent : PROFILE_IDENTIFIER
    THEN
        IF(profileIdent : dom(savedProfiles)) THEN
	       keyMap:=keyMap 
	            <+ {key, sign | key : CONTROL_KEYS & sign : SIGNAL 
	                   &  #ident.(ident : IDENTIFIER 
	                       & (key|->(sign |-> ident)) : savedProfiles(profileIdent))}
        	||
        	keyName:=keyName 
        	     <+ {key, ident | key : CONTROL_KEYS & ident : IDENTIFIER 
    	               & #sign.(sign : SIGNAL 
    	                   & (key|->(sign |-> ident)) : savedProfiles(profileIdent))}
    	    ||
    	    currentProfileIdent := profileIdent
    	    ||
    	    success := TRUE
        ELSE
    	    success := FALSE
        END   
    END;
   */
success <-- loadProfile ( profileIdent ) =
    PRE profileIdent : PROFILE_IDENTIFIER
    THEN
        IF ( profileIdent : dom ( savedProfilesSignals ) ) THEN
            keyMap  := savedProfilesSignals ( profileIdent )
            ||
            keyName := savedProfilesNames ( profileIdent )
            ||
            currentProfileIdent := profileIdent
            ||
success := TRUE
        ELSE
                success := FALSE
        END
    END ;
currentProfileName <-- showCurrentProfileIdentification =
        currentProfileName := currentProfileIdent

END
