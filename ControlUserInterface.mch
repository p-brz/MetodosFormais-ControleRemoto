/* ControlUserInterface
 * Author: leobrizolara
 * Creation date: 19/05/14
 
     A responsabilidade desta máquina é controlar a interface com o usuário:
         - exibir informações do controle
             - exibir tecla pressionada
             - exibir temperatura atual
             - exibir perfil atual             
         - obter teclas pressionadas pelo usuário ??
 */
MACHINE ControlUserInterface

SEES TemperatureType, IdentifierType, ProfileIdentifierType
    
VARIABLES temperatureView, keyIdentifierView, profileIdentView
    
INVARIANT temperatureView : TEMPERATURES &
            keyIdentifierView : CMD_IDENTIFIER &
            profileIdentView : PROFILE_IDENTIFIER

INITIALISATION temperatureView :: TEMPERATURES ||
            keyIdentifierView :: CMD_IDENTIFIER ||
            profileIdentView :: PROFILE_IDENTIFIER
    
OPERATIONS
    
showTemperature(temp) =
    PRE temp : TEMPERATURES
    THEN
        temperatureView := temp
    END;
showKey(keyId) =
    PRE keyId : CMD_IDENTIFIER
    THEN
        keyIdentifierView := keyId
    END;
showProfile(profileId) =
    PRE profileId : PROFILE_IDENTIFIER
    THEN
        profileIdentView := profileId
    END

    
END
