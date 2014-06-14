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
    
INITIALISATION currentTemp :: ALLOWED_TEMPS ||
               maxTemp := maxTemperature ||
               minTemp := minTemperature 
            
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
    
setTemperatures(temp, tempMin, tempMax) =
    PRE temp : TEMPERATURES  
        & tempMin : TEMPERATURES  
        & tempMax : TEMPERATURES 
        & tempMin <= temp & temp <= tempMax
    THEN
        currentTemp := temp
        ||
        maxTemp := tempMax
        ||
        minTemp := tempMin
    END


END
