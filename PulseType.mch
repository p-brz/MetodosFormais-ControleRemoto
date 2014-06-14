/* PulseType
 * Author: leobrizolara
 * Creation date: 04/06/14
 */
MACHINE
    PulseType

   
CONSTANTS
    PULSES,
    maxSignalPulses,
    defaultPulse
    
PROPERTIES
    PULSES <: NAT &
    defaultPulse : PULSES &
    maxSignalPulses : NAT1
    
END
