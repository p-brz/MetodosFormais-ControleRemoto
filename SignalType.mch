/* SignalType
 * Author: leobrizolara
 * Creation date: 19/05/14
 */
MACHINE
    SignalType
SETS SIGNALS
CONSTANTS nullSignal
PROPERTIES nullSignal : SIGNALS
   
ABSTRACT_VARIABLES
    generatedSignals
   
INVARIANT generatedSignals <: SIGNALS
    
INITIALISATION generatedSignals := {}
   
OPERATIONS
    
sign <-- generateNewSignal =
    IF SIGNALS - (generatedSignals \/ {nullSignal}) /= {} THEN
        ANY signal 
        WHERE signal : SIGNALS 
            & signal /: generatedSignals & signal /= nullSignal
        THEN
            sign := signal
            ||
            generatedSignals := generatedSignals \/ {signal}
        END
    ELSE
        sign := nullSignal
    END

END
