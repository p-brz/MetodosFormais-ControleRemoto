/* TemperatureType
 * Author: leobrizolara
 * Creation date: 19/05/14
 */
MACHINE
    TemperatureType

CONSTANTS TEMPERATURES,
          maxTemperature, minTemperature, 
          ALLOWED_TEMPS
          
PROPERTIES TEMPERATURES <: INT
            & card(TEMPERATURES) > 2
            & maxTemperature : TEMPERATURES & minTemperature : TEMPERATURES
            /** esta clausula faz com que o ProB não encontre constantes validas */
            & maxTemperature > minTemperature
            /*& maxTemperature =30 & minTemperature=16*/
            & ALLOWED_TEMPS = minTemperature .. maxTemperature
            & ALLOWED_TEMPS <: TEMPERATURES
            & card(ALLOWED_TEMPS) >= 2

END
