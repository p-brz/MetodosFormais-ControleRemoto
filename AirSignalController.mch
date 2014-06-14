/* AirSignalController
 * Author: leobrizolara
 * Creation date: 26/05/14

Máquina responsável por enviar e receber os sinais de infravermelho específicos para o 
ar-condicionado.
    
TODO:
     - Rever modo de enviar sinais de modificar temperatura
         - possibilidade: manter "estado" do ar-condicionado (modo, temperatura, ...) relacionado a um (ou mais de um) sinal, que sera enviado pelo controle quando a temperatura for alterada
             - nesse caso, retirar mapeamento de teclas de temperatura para sinais (em keyMap)
    - rever o uso e significado de 'signalOut'
    
    - o tipo SIGNALS deverá representar o identificador de um sinal, pois:
        1) SIGNALS é utilizado para manipular sinais entre as máquinas e 
        2) (ver abaixo) cada sinal infravermelho corresponde, na verdade, a uma sequência de marcas e espaços (poderá ser refinado para um array de inteiros), o que dificultaria sua manipulação pelas máquinas
        - Dessa forma:
            A) essa máquina armazenará os verdadeiros sinais
            B) é preciso rever as operações definidas por ela
    
INFO: 
    (segundo dados pesquisados)
    - sinais de infravermelho consistem de conjuntos de 'spaces' e 'marks' alternados.
        - um 'space' corresponde a um período de tempo sem envio de sinal
        - uma 'mark' corresponde a um período de tempo com envio de sinal
    - diferentes protocolos interpretam e traduzem esses 'spaces' e 'marks' de forma diferente
    - representação 
        1) se 'spaces' e 'marks'tem tamanhos fixos eles podem ser representados como um conjunto de bits (talvez codificados em um numero) + a duracao de 'spaces' e 'marks'
        2) uma forma + generica é representar um sinal como uma sequencia de inteiros que determinam o tempo de duração de 'spaces' e 'marks'
            - nesse caso pode-se assumir que o primeiro valor corresponde a uma 'mark', já que todo o período anterior em que não há transmissão pode ser considerado um 'space' 
 */
MACHINE
    AirSignalController

SEES SignalType,TemperatureType

VARIABLES signalOut, allowedSignals
    
INVARIANT signalOut : SIGNALS
          & allowedSignals <: SIGNALS 
          & nullSignal /: allowedSignals

INITIALISATION signalOut := nullSignal
                || 
                ANY signals WHERE signals <: SIGNALS & nullSignal /: signals THEN
                    allowedSignals := signals
                END
                

OPERATIONS
    
sended <-- sendTemperatureSignal(temp) =
    PRE temp : TEMPERATURES
    THEN /** O sinal enviado por sendTemperature ainda sera definido**/
        ANY sign WHERE sign : SIGNALS
        THEN
            IF sign /= nullSignal THEN
                signalOut := sign
                ||
                sended := TRUE
            ELSE
                sended := FALSE
            END
        END       
    END;

/*
signal <-- receiveTemperatureSignal(temp)=
    PRE temp : TEMPERATURES THEN
        ANY sign WHERE sign : SIGNALS
        THEN
            signal := sign
        END
    END;*/

signal <-- receiveSignal =
    ANY sign WHERE sign : SIGNALS
    THEN
        signal := sign
        ||
        IF sign /= nullSignal THEN
            allowedSignals := allowedSignals \/ {sign}
        END
    END;
    
/**/
freeSignal(signal) =
    PRE signal : SIGNALS THEN
        IF signal : allowedSignals & signal /= nullSignal THEN
            allowedSignals := allowedSignals - {signal}
        END
    END;

result <-- isAValidSignal(sign) =
    PRE sign : SIGNALS THEN
        IF sign : allowedSignals THEN
            result := TRUE
        ELSE
            result := FALSE
        END
    END;

sendSignal(signal) =
    PRE signal : SIGNALS & signal : allowedSignals THEN
        signalOut := signal
    END
    


END
