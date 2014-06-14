/* ProfileIdentifierType
 * Author: leobrizolara
 * Creation date: 19/05/14
 */
MACHINE
    ProfileIdentifierType
SETS PROFILE_IDENTIFIER
CONSTANTS nullProfileIdentifier, defaultProfile
PROPERTIES nullProfileIdentifier : PROFILE_IDENTIFIER &
           defaultProfile : PROFILE_IDENTIFIER &
           nullProfileIdentifier /= nullProfileIdentifier
    
END
