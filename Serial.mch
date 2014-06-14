/* Serial
 * Author: leobrizolara
 * Creation date: 04/06/14
 */
MACHINE
    Serial

SEES TemperatureType, IdentifierType, ProfileIdentifierType

OPERATIONS
printTemp(temperatureView) =
    PRE temperatureView : TEMPERATURES THEN
        skip
    END;

printKey(keyIdentifierView) =
    PRE keyIdentifierView : CMD_IDENTIFIER THEN
        skip
    END;
    
printProfile(profileIdentView )=
    PRE profileIdentView : PROFILE_IDENTIFIER THEN
        skip
    END
END
