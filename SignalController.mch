/* SignalController
 * Author: leobrizolara
 * Creation date: 19/05/14
 
     A responsabilidade desta máquina é controlar as operações relativas aos sinais do controle.
     Incluindo:
         - Emitir sinal
         - Ler sinal         
         - Gravar sinal
         
         
         
    Cada sinal será refinado para um conjunto de pulsos (1 e 
 */
MACHINE
    SignalController

SEES SignalType



OPERATIONS
    
signal <-- receiveSignal =
    ANY sign WHERE sign : SIGNALS
    THEN
        signal := sign
    END;
    
sendSignal(signal) =
    PRE signal : SIGNALS
    THEN
        skip
    END
    

END
