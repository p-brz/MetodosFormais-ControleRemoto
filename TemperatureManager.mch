/* TemperatureManager
 * Author: leobrizolara
 * Creation date: 19/05/14
 
     A responsabilidade desta máquina é manter controle sobre a temperatura atual do ar-condicionado.
     Incluindo:     
         - Definir, aumentar e reduzir temperatura
 
 */
MACHINE TemperatureManager

SEES TemperatureType
    
VARIABLES currentTemp, minTemp, maxTemp
    
INVARIANT currentTemp : TEMPERATURES
          & minTemp : TEMPERATURES & maxTemp : TEMPERATURES 
          & minTemp <= maxTemp
          & currentTemp >= minTemp & currentTemp <= maxTemp
    
INITIALISATION currentTemp :: TEMPERATURES ||
               maxTemp := max(TEMPERATURES) ||
               minTemp := min(TEMPERATURES) 
            
OPERATIONS
    
temp <-- getMinTemperature =
    temp := minTemp;
temp <-- getMaxTemperature =
    temp := maxTemp;
temp <-- getCurrentTemperature =
    temp := currentTemp;
    
setMinTemperature(temp) =
    PRE temp : TEMPERATURES 
        & temp <= currentTemp & temp <= maxTemp 
    THEN
        minTemp := temp 
    END;
setMaxTemperature(temp) =
    PRE temp : TEMPERATURES 
        & temp >= currentTemp & temp >= minTemp 
    THEN
        maxTemp := temp 
    END;
setCurrentTemperature(temp) =
    PRE temp : TEMPERATURES 
        & temp <= maxTemp & temp >= minTemp 
    THEN
        currentTemp := temp 
    END;
    
setTemperatures(currentTemperature, minTemperature, maxTemperature) =
    PRE currentTemperature : TEMPERATURES  
        & minTemperature : TEMPERATURES  
        & maxTemperature : TEMPERATURES 
        & minTemperature <= currentTemperature 
        & currentTemperature <= maxTemperature
    THEN
        currentTemp := currentTemperature
        ||
        maxTemp := maxTemperature
        ||
        minTemp := minTemperature
    END


END
