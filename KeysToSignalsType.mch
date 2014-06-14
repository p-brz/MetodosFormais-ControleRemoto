/* KeysToSignalsType
 * Author: leobrizolara
 * Creation date: 20/05/14
 */
MACHINE
    KeysToSignalsType
SEES KeyType, SignalType
    
ABSTRACT_CONSTANTS KEYS_TO_SIGNALS
PROPERTIES  KEYS_TO_SIGNALS     = KEYS +-> SIGNALS

END
