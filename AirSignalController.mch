/* AirSignalController
 * Author: leobrizolara
 * Creation date: 26/05/14

Máquina responsável por enviar e receber os sinais infravermelho do ar-condicionado.

 */
MACHINE
    AirSignalController

SEES SignalType, TemperatureType

VARIABLES signalOut
    
INVARIANT signalOut : SIGNALS

INITIALISATION signalOut := nullSignal

OPERATIONS
    
sendTemperatureSignal(temp) =
    PRE temp : TEMPERATURES
    THEN
        signalOut :: SIGNALS        
    END;

signal <-- receiveTemperatureSignal(temp)=
    PRE temp : TEMPERATURES THEN
        ANY sign WHERE sign : SIGNALS
        THEN
            signal := sign
        END
    END;

signal <-- receiveSignal =
    ANY sign WHERE sign : SIGNALS
    THEN
        signal := sign
    END;
    
sendSignal(signal) =
    PRE signal : SIGNALS THEN
        signalOut := signal      
    END

END
