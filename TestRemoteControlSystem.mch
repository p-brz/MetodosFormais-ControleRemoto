/* TestRemoteControlSystem
 * Author: leobrizolara
 * Creation date: 27/05/14
 */
MACHINE
    TestRemoteControlSystem
                
OPERATIONS

bits <-- convertToBits(num) =
    PRE num : NAT THEN
        bits := %ii.(ii:1..16 | ii |-> (num /(2**(ii-1))) mod 2)
    END;

ii <-- maxInt =
	ii:= MAXINT
    

END
