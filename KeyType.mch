/* KeyType
 * Author: leobrizolara
 * Creation date: 19/05/14
 */
MACHINE
    KeyType
SETS KEYS
CONSTANTS SPECIAL_KEYS, 
          /** teclas para aumentar e diminuir temperatura*/
          incKey, decKey, keysCount, nullKey
PROPERTIES 
            SPECIAL_KEYS <: KEYS
            & incKey : KEYS & decKey : KEYS
            /*& incIdent : CMD_IDENTIFIER & decIdent : CMD_IDENTIFIER
            & incIdent /= nullIdentifier & decIdent /= nullIdentifier
            & incIdent /= decIdent*/
            & incKey /: SPECIAL_KEYS & decKey /: SPECIAL_KEYS
            & keysCount : NAT1
            & card(SPECIAL_KEYS) = keysCount 
          /** teclas para aumentar e diminuir devem ser diferentes*/
            & incKey /= decKey
            & nullKey : KEYS
            
OPERATIONS

result <-- isASpecialKey(key)=
    PRE key : KEYS THEN
        IF key : SPECIAL_KEYS THEN
            result := TRUE
        ELSE
            result := FALSE
        END
    END
    
END
