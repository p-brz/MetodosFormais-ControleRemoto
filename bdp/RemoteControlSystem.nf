Normalised(
THEORY MagicNumberX IS
  MagicNumber(Machine(RemoteControlSystem))==(3.5)
END
&
THEORY UpperLevelX IS
  First_Level(Machine(RemoteControlSystem))==(Machine(RemoteControlSystem));
  Level(Machine(RemoteControlSystem))==(0)
END
&
THEORY LoadedStructureX IS
  Machine(RemoteControlSystem)
END
&
THEORY ListSeesX IS
  List_Sees(Machine(RemoteControlSystem))==(?)
END
&
THEORY ListUsesX IS
  List_Uses(Machine(RemoteControlSystem))==(?)
END
&
THEORY ListIncludesX IS
  Inherited_List_Includes(Machine(RemoteControlSystem))==(?);
  List_Includes(Machine(RemoteControlSystem))==(?)
END
&
THEORY ListPromotesX IS
  List_Promotes(Machine(RemoteControlSystem))==(?)
END
&
THEORY ListExtendsX IS
  List_Extends(Machine(RemoteControlSystem))==(?)
END
&
THEORY ListVariablesX IS
  External_Context_List_Variables(Machine(RemoteControlSystem))==(?);
  Context_List_Variables(Machine(RemoteControlSystem))==(?);
  Abstract_List_Variables(Machine(RemoteControlSystem))==(?);
  Local_List_Variables(Machine(RemoteControlSystem))==(currentProfileIdent,savedProfilesNames,savedProfilesSignals,nameOut,signalOut,keyName,keyMap,currentTemperature);
  List_Variables(Machine(RemoteControlSystem))==(currentProfileIdent,savedProfilesNames,savedProfilesSignals,nameOut,signalOut,keyName,keyMap,currentTemperature);
  External_List_Variables(Machine(RemoteControlSystem))==(currentProfileIdent,savedProfilesNames,savedProfilesSignals,nameOut,signalOut,keyName,keyMap,currentTemperature)
END
&
THEORY ListVisibleVariablesX IS
  Inherited_List_VisibleVariables(Machine(RemoteControlSystem))==(?);
  Abstract_List_VisibleVariables(Machine(RemoteControlSystem))==(?);
  External_List_VisibleVariables(Machine(RemoteControlSystem))==(?);
  Expanded_List_VisibleVariables(Machine(RemoteControlSystem))==(?);
  List_VisibleVariables(Machine(RemoteControlSystem))==(?);
  Internal_List_VisibleVariables(Machine(RemoteControlSystem))==(?)
END
&
THEORY ListInvariantX IS
  Gluing_Seen_List_Invariant(Machine(RemoteControlSystem))==(btrue);
  Gluing_List_Invariant(Machine(RemoteControlSystem))==(btrue);
  Expanded_List_Invariant(Machine(RemoteControlSystem))==(btrue);
  Abstract_List_Invariant(Machine(RemoteControlSystem))==(btrue);
  Context_List_Invariant(Machine(RemoteControlSystem))==(btrue);
  List_Invariant(Machine(RemoteControlSystem))==(currentTemperature: TEMPERATURE & currentTemperature<=maxTemperature & currentTemperature>=minTemperature & signalOut: SIGNAL & nameOut: IDENTIFIER & keyMap: KEYS_TO_SIGNALS & keyName: KEYS_TO_IDENTIFIERS & !(key1,key2).(key1: CONTROL_KEYS & key2: CONTROL_KEYS & key1/=key2 => keyName(key1)/=keyName(key2) or keyName(key1) = nullIdentifier) & savedProfilesSignals: PROFILE_IDENTIFIER +-> KEYS_TO_SIGNALS & savedProfilesNames: PROFILE_IDENTIFIER +-> KEYS_TO_IDENTIFIERS & dom(savedProfilesSignals) = dom(savedProfilesNames) & currentProfileIdent: PROFILE_IDENTIFIER & !keysToIds.(keysToIds: KEYS_TO_IDENTIFIERS & keysToIds: ran(savedProfilesNames) => !(key1,key2).(key1: CONTROL_KEYS & key2: CONTROL_KEYS & key1/=key2 => keysToIds(key1)/=keysToIds(key2) or keysToIds(key1) = nullIdentifier)))
END
&
THEORY ListAssertionsX IS
  Expanded_List_Assertions(Machine(RemoteControlSystem))==(btrue);
  Abstract_List_Assertions(Machine(RemoteControlSystem))==(btrue);
  Context_List_Assertions(Machine(RemoteControlSystem))==(btrue);
  List_Assertions(Machine(RemoteControlSystem))==(btrue)
END
&
THEORY ListCoverageX IS
  List_Coverage(Machine(RemoteControlSystem))==(btrue)
END
&
THEORY ListExclusivityX IS
  List_Exclusivity(Machine(RemoteControlSystem))==(btrue)
END
&
THEORY ListInitialisationX IS
  Expanded_List_Initialisation(Machine(RemoteControlSystem))==(@temp.(temp: TEMPERATURE & temp>=minTemperature & temp<=maxTemperature ==> currentTemperature:=temp) || keyMap:=CONTROL_KEYS*{nullSignal} || keyName:=CONTROL_KEYS*{nullIdentifier} || @(signalOut$0).(signalOut$0: SIGNAL ==> signalOut:=signalOut$0) || @(nameOut$0).(nameOut$0: IDENTIFIER ==> nameOut:=nameOut$0) || currentProfileIdent:=defaultProfile || savedProfilesSignals:={defaultProfile|->CONTROL_KEYS*{nullSignal}} || savedProfilesNames:={defaultProfile|->CONTROL_KEYS*{nullIdentifier}});
  Context_List_Initialisation(Machine(RemoteControlSystem))==(skip);
  List_Initialisation(Machine(RemoteControlSystem))==(ANY temp WHERE temp: TEMPERATURE & temp>=minTemperature & temp<=maxTemperature THEN currentTemperature:=temp END || keyMap:=CONTROL_KEYS*{nullSignal} || keyName:=CONTROL_KEYS*{nullIdentifier} || signalOut:: SIGNAL || nameOut:: IDENTIFIER || currentProfileIdent:=defaultProfile || savedProfilesSignals:={defaultProfile|->CONTROL_KEYS*{nullSignal}} || savedProfilesNames:={defaultProfile|->CONTROL_KEYS*{nullIdentifier}})
END
&
THEORY ListParametersX IS
  List_Parameters(Machine(RemoteControlSystem))==(?)
END
&
THEORY ListInstanciatedParametersX END
&
THEORY ListConstraintsX IS
  List_Context_Constraints(Machine(RemoteControlSystem))==(btrue);
  List_Constraints(Machine(RemoteControlSystem))==(btrue)
END
&
THEORY ListOperationsX IS
  Internal_List_Operations(Machine(RemoteControlSystem))==(setTemperature,increaseTemperature,decreaseTemperature,showTemperature,pressSpecialKey,recordSignal,recordKeyIdentifier,showKeyIdentifier,exportConfigurations,importConfigurations,saveCurrentProfile,loadProfile,showCurrentProfileIdentification);
  List_Operations(Machine(RemoteControlSystem))==(setTemperature,increaseTemperature,decreaseTemperature,showTemperature,pressSpecialKey,recordSignal,recordKeyIdentifier,showKeyIdentifier,exportConfigurations,importConfigurations,saveCurrentProfile,loadProfile,showCurrentProfileIdentification)
END
&
THEORY ListInputX IS
  List_Input(Machine(RemoteControlSystem),setTemperature)==(temp);
  List_Input(Machine(RemoteControlSystem),increaseTemperature)==(?);
  List_Input(Machine(RemoteControlSystem),decreaseTemperature)==(?);
  List_Input(Machine(RemoteControlSystem),showTemperature)==(?);
  List_Input(Machine(RemoteControlSystem),pressSpecialKey)==(key);
  List_Input(Machine(RemoteControlSystem),recordSignal)==(signal,key);
  List_Input(Machine(RemoteControlSystem),recordKeyIdentifier)==(key,ident);
  List_Input(Machine(RemoteControlSystem),showKeyIdentifier)==(key);
  List_Input(Machine(RemoteControlSystem),exportConfigurations)==(?);
  List_Input(Machine(RemoteControlSystem),importConfigurations)==(keysToSignals,keysToIds);
  List_Input(Machine(RemoteControlSystem),saveCurrentProfile)==(ident);
  List_Input(Machine(RemoteControlSystem),loadProfile)==(profileIdent);
  List_Input(Machine(RemoteControlSystem),showCurrentProfileIdentification)==(?)
END
&
THEORY ListOutputX IS
  List_Output(Machine(RemoteControlSystem),setTemperature)==(?);
  List_Output(Machine(RemoteControlSystem),increaseTemperature)==(?);
  List_Output(Machine(RemoteControlSystem),decreaseTemperature)==(?);
  List_Output(Machine(RemoteControlSystem),showTemperature)==(temp);
  List_Output(Machine(RemoteControlSystem),pressSpecialKey)==(?);
  List_Output(Machine(RemoteControlSystem),recordSignal)==(?);
  List_Output(Machine(RemoteControlSystem),recordKeyIdentifier)==(recorded);
  List_Output(Machine(RemoteControlSystem),showKeyIdentifier)==(ident);
  List_Output(Machine(RemoteControlSystem),exportConfigurations)==(keysToSignals,keysToIdentifiers);
  List_Output(Machine(RemoteControlSystem),importConfigurations)==(?);
  List_Output(Machine(RemoteControlSystem),saveCurrentProfile)==(?);
  List_Output(Machine(RemoteControlSystem),loadProfile)==(success);
  List_Output(Machine(RemoteControlSystem),showCurrentProfileIdentification)==(currentProfileName)
END
&
THEORY ListHeaderX IS
  List_Header(Machine(RemoteControlSystem),setTemperature)==(setTemperature(temp));
  List_Header(Machine(RemoteControlSystem),increaseTemperature)==(increaseTemperature);
  List_Header(Machine(RemoteControlSystem),decreaseTemperature)==(decreaseTemperature);
  List_Header(Machine(RemoteControlSystem),showTemperature)==(temp <-- showTemperature);
  List_Header(Machine(RemoteControlSystem),pressSpecialKey)==(pressSpecialKey(key));
  List_Header(Machine(RemoteControlSystem),recordSignal)==(recordSignal(signal,key));
  List_Header(Machine(RemoteControlSystem),recordKeyIdentifier)==(recorded <-- recordKeyIdentifier(key,ident));
  List_Header(Machine(RemoteControlSystem),showKeyIdentifier)==(ident <-- showKeyIdentifier(key));
  List_Header(Machine(RemoteControlSystem),exportConfigurations)==(keysToSignals,keysToIdentifiers <-- exportConfigurations);
  List_Header(Machine(RemoteControlSystem),importConfigurations)==(importConfigurations(keysToSignals,keysToIds));
  List_Header(Machine(RemoteControlSystem),saveCurrentProfile)==(saveCurrentProfile(ident));
  List_Header(Machine(RemoteControlSystem),loadProfile)==(success <-- loadProfile(profileIdent));
  List_Header(Machine(RemoteControlSystem),showCurrentProfileIdentification)==(currentProfileName <-- showCurrentProfileIdentification)
END
&
THEORY ListOperationGuardX END
&
THEORY ListPreconditionX IS
  List_Precondition(Machine(RemoteControlSystem),setTemperature)==(temp: TEMPERATURE);
  List_Precondition(Machine(RemoteControlSystem),increaseTemperature)==(btrue);
  List_Precondition(Machine(RemoteControlSystem),decreaseTemperature)==(btrue);
  List_Precondition(Machine(RemoteControlSystem),showTemperature)==(btrue);
  List_Precondition(Machine(RemoteControlSystem),pressSpecialKey)==(key: SPECIAL_KEYS);
  List_Precondition(Machine(RemoteControlSystem),recordSignal)==(signal: SIGNAL & key: CONTROL_KEYS);
  List_Precondition(Machine(RemoteControlSystem),recordKeyIdentifier)==(key: CONTROL_KEYS & ident: IDENTIFIER);
  List_Precondition(Machine(RemoteControlSystem),showKeyIdentifier)==(key: CONTROL_KEYS);
  List_Precondition(Machine(RemoteControlSystem),exportConfigurations)==(btrue);
  List_Precondition(Machine(RemoteControlSystem),importConfigurations)==(keysToSignals: KEYS_TO_SIGNALS & keysToIds: KEYS_TO_IDENTIFIERS & !(key1,key2).(key1: CONTROL_KEYS & key2: CONTROL_KEYS & key1/=key2 => keysToIds(key1)/=keysToIds(key2) or keysToIds(key1) = nullIdentifier));
  List_Precondition(Machine(RemoteControlSystem),saveCurrentProfile)==(ident: PROFILE_IDENTIFIER);
  List_Precondition(Machine(RemoteControlSystem),loadProfile)==(profileIdent: PROFILE_IDENTIFIER);
  List_Precondition(Machine(RemoteControlSystem),showCurrentProfileIdentification)==(btrue)
END
&
THEORY ListSubstitutionX IS
  Expanded_List_Substitution(Machine(RemoteControlSystem),showCurrentProfileIdentification)==(btrue | currentProfileName:=currentProfileIdent);
  Expanded_List_Substitution(Machine(RemoteControlSystem),loadProfile)==(profileIdent: PROFILE_IDENTIFIER | profileIdent: dom(savedProfilesSignals) ==> keyMap,keyName,currentProfileIdent,success:=savedProfilesSignals(profileIdent),savedProfilesNames(profileIdent),profileIdent,TRUE [] not(profileIdent: dom(savedProfilesSignals)) ==> success:=FALSE);
  Expanded_List_Substitution(Machine(RemoteControlSystem),saveCurrentProfile)==(ident: PROFILE_IDENTIFIER | savedProfilesSignals,savedProfilesNames:=savedProfilesSignals<+{ident|->keyMap},savedProfilesNames<+{ident|->keyName});
  Expanded_List_Substitution(Machine(RemoteControlSystem),importConfigurations)==(keysToSignals: KEYS_TO_SIGNALS & keysToIds: KEYS_TO_IDENTIFIERS & !(key1,key2).(key1: CONTROL_KEYS & key2: CONTROL_KEYS & key1/=key2 => keysToIds(key1)/=keysToIds(key2) or keysToIds(key1) = nullIdentifier) | keyMap,keyName:=keysToSignals,keysToIds);
  Expanded_List_Substitution(Machine(RemoteControlSystem),exportConfigurations)==(btrue | keysToSignals,keysToIdentifiers:=keyMap,keyName);
  Expanded_List_Substitution(Machine(RemoteControlSystem),showKeyIdentifier)==(key: CONTROL_KEYS | ident:=keyName(key));
  Expanded_List_Substitution(Machine(RemoteControlSystem),recordKeyIdentifier)==(key: CONTROL_KEYS & ident: IDENTIFIER | ident/:ran(keyName) or ident = nullIdentifier ==> keyName,recorded:=keyName<+{key|->ident},TRUE [] not(ident/:ran(keyName) or ident = nullIdentifier) ==> recorded:=FALSE);
  Expanded_List_Substitution(Machine(RemoteControlSystem),recordSignal)==(signal: SIGNAL & key: CONTROL_KEYS | keyMap:=keyMap<+{key|->signal});
  Expanded_List_Substitution(Machine(RemoteControlSystem),pressSpecialKey)==(key: SPECIAL_KEYS | signalOut,nameOut:=keyMap(key),keyName(key));
  Expanded_List_Substitution(Machine(RemoteControlSystem),showTemperature)==(btrue | temp:=currentTemperature);
  Expanded_List_Substitution(Machine(RemoteControlSystem),decreaseTemperature)==(btrue | currentTemperature-1>=minTemperature & currentTemperature-1: TEMPERATURE ==> currentTemperature,signalOut,nameOut:=currentTemperature-1,keyMap(decKey),keyName(decKey) [] not(currentTemperature-1>=minTemperature & currentTemperature-1: TEMPERATURE) ==> skip);
  Expanded_List_Substitution(Machine(RemoteControlSystem),increaseTemperature)==(btrue | currentTemperature+1<=maxTemperature & currentTemperature+1: TEMPERATURE ==> currentTemperature,signalOut,nameOut:=currentTemperature+1,keyMap(incKey),keyName(incKey) [] not(currentTemperature+1<=maxTemperature & currentTemperature+1: TEMPERATURE) ==> skip);
  Expanded_List_Substitution(Machine(RemoteControlSystem),setTemperature)==(temp: TEMPERATURE | temp<=maxTemperature & temp>=minTemperature ==> currentTemperature,signalOut,nameOut:=temp,keyMap(setKey),keyName(setKey) [] not(temp<=maxTemperature & temp>=minTemperature) ==> skip);
  List_Substitution(Machine(RemoteControlSystem),setTemperature)==(IF temp<=maxTemperature & temp>=minTemperature THEN currentTemperature:=temp || signalOut:=keyMap(setKey) || nameOut:=keyName(setKey) END);
  List_Substitution(Machine(RemoteControlSystem),increaseTemperature)==(IF currentTemperature+1<=maxTemperature & currentTemperature+1: TEMPERATURE THEN currentTemperature:=currentTemperature+1 || signalOut:=keyMap(incKey) || nameOut:=keyName(incKey) END);
  List_Substitution(Machine(RemoteControlSystem),decreaseTemperature)==(IF currentTemperature-1>=minTemperature & currentTemperature-1: TEMPERATURE THEN currentTemperature:=currentTemperature-1 || signalOut:=keyMap(decKey) || nameOut:=keyName(decKey) END);
  List_Substitution(Machine(RemoteControlSystem),showTemperature)==(temp:=currentTemperature);
  List_Substitution(Machine(RemoteControlSystem),pressSpecialKey)==(signalOut:=keyMap(key) || nameOut:=keyName(key));
  List_Substitution(Machine(RemoteControlSystem),recordSignal)==(keyMap:=keyMap<+{key|->signal});
  List_Substitution(Machine(RemoteControlSystem),recordKeyIdentifier)==(IF ident/:ran(keyName) or ident = nullIdentifier THEN keyName:=keyName<+{key|->ident} || recorded:=TRUE ELSE recorded:=FALSE END);
  List_Substitution(Machine(RemoteControlSystem),showKeyIdentifier)==(ident:=keyName(key));
  List_Substitution(Machine(RemoteControlSystem),exportConfigurations)==(keysToSignals,keysToIdentifiers:=keyMap,keyName);
  List_Substitution(Machine(RemoteControlSystem),importConfigurations)==(keyMap,keyName:=keysToSignals,keysToIds);
  List_Substitution(Machine(RemoteControlSystem),saveCurrentProfile)==(savedProfilesSignals:=savedProfilesSignals<+{ident|->keyMap} || savedProfilesNames:=savedProfilesNames<+{ident|->keyName});
  List_Substitution(Machine(RemoteControlSystem),loadProfile)==(IF profileIdent: dom(savedProfilesSignals) THEN keyMap:=savedProfilesSignals(profileIdent) || keyName:=savedProfilesNames(profileIdent) || currentProfileIdent:=profileIdent || success:=TRUE ELSE success:=FALSE END);
  List_Substitution(Machine(RemoteControlSystem),showCurrentProfileIdentification)==(currentProfileName:=currentProfileIdent)
END
&
THEORY ListConstantsX IS
  List_Valuable_Constants(Machine(RemoteControlSystem))==(TEMPERATURE,maxTemperature,minTemperature,CONTROL_KEYS,SPECIAL_KEYS,KEYS_TO_SIGNALS,KEYS_TO_IDENTIFIERS,nullSignal,nullIdentifier,incKey,decKey,setKey,defaultProfile);
  Inherited_List_Constants(Machine(RemoteControlSystem))==(?);
  List_Constants(Machine(RemoteControlSystem))==(TEMPERATURE,maxTemperature,minTemperature,CONTROL_KEYS,SPECIAL_KEYS,KEYS_TO_SIGNALS,KEYS_TO_IDENTIFIERS,nullSignal,nullIdentifier,incKey,decKey,setKey,defaultProfile)
END
&
THEORY ListSetsX IS
  Set_Definition(Machine(RemoteControlSystem),SIGNAL)==(?);
  Context_List_Enumerated(Machine(RemoteControlSystem))==(?);
  Context_List_Defered(Machine(RemoteControlSystem))==(?);
  Context_List_Sets(Machine(RemoteControlSystem))==(?);
  List_Valuable_Sets(Machine(RemoteControlSystem))==(SIGNAL,KEY,IDENTIFIER,PROFILE_IDENTIFIER);
  Inherited_List_Enumerated(Machine(RemoteControlSystem))==(?);
  Inherited_List_Defered(Machine(RemoteControlSystem))==(?);
  Inherited_List_Sets(Machine(RemoteControlSystem))==(?);
  List_Enumerated(Machine(RemoteControlSystem))==(?);
  List_Defered(Machine(RemoteControlSystem))==(SIGNAL,KEY,IDENTIFIER,PROFILE_IDENTIFIER);
  List_Sets(Machine(RemoteControlSystem))==(SIGNAL,KEY,IDENTIFIER,PROFILE_IDENTIFIER);
  Set_Definition(Machine(RemoteControlSystem),KEY)==(?);
  Set_Definition(Machine(RemoteControlSystem),IDENTIFIER)==(?);
  Set_Definition(Machine(RemoteControlSystem),PROFILE_IDENTIFIER)==(?)
END
&
THEORY ListHiddenConstantsX IS
  Abstract_List_HiddenConstants(Machine(RemoteControlSystem))==(?);
  Expanded_List_HiddenConstants(Machine(RemoteControlSystem))==(?);
  List_HiddenConstants(Machine(RemoteControlSystem))==(?);
  External_List_HiddenConstants(Machine(RemoteControlSystem))==(?)
END
&
THEORY ListPropertiesX IS
  Abstract_List_Properties(Machine(RemoteControlSystem))==(btrue);
  Context_List_Properties(Machine(RemoteControlSystem))==(btrue);
  Inherited_List_Properties(Machine(RemoteControlSystem))==(btrue);
  List_Properties(Machine(RemoteControlSystem))==(TEMPERATURE <: INT & card(TEMPERATURE)>2 & maxTemperature = max(TEMPERATURE) & minTemperature = min(TEMPERATURE) & nullSignal: SIGNAL & CONTROL_KEYS <: KEY & nullIdentifier: IDENTIFIER & KEYS_TO_SIGNALS = CONTROL_KEYS --> SIGNAL & KEYS_TO_IDENTIFIERS = CONTROL_KEYS --> IDENTIFIER & incKey: CONTROL_KEYS & decKey: CONTROL_KEYS & setKey: CONTROL_KEYS & SPECIAL_KEYS = CONTROL_KEYS-{incKey,decKey,setKey} & incKey/=decKey & incKey/=setKey & decKey/=setKey & card(CONTROL_KEYS)>=3 & defaultProfile: PROFILE_IDENTIFIER & SIGNAL: FIN(INTEGER) & not(SIGNAL = {}) & KEY: FIN(INTEGER) & not(KEY = {}) & IDENTIFIER: FIN(INTEGER) & not(IDENTIFIER = {}) & PROFILE_IDENTIFIER: FIN(INTEGER) & not(PROFILE_IDENTIFIER = {}))
END
&
THEORY ListSeenInfoX END
&
THEORY ListANYVarX IS
  List_ANY_Var(Machine(RemoteControlSystem),?)==(Var(temp) == btype(INTEGER,?,?));
  List_ANY_Var(Machine(RemoteControlSystem),setTemperature)==(?);
  List_ANY_Var(Machine(RemoteControlSystem),increaseTemperature)==(?);
  List_ANY_Var(Machine(RemoteControlSystem),decreaseTemperature)==(?);
  List_ANY_Var(Machine(RemoteControlSystem),showTemperature)==(?);
  List_ANY_Var(Machine(RemoteControlSystem),pressSpecialKey)==(?);
  List_ANY_Var(Machine(RemoteControlSystem),recordSignal)==(?);
  List_ANY_Var(Machine(RemoteControlSystem),recordKeyIdentifier)==(?);
  List_ANY_Var(Machine(RemoteControlSystem),showKeyIdentifier)==(?);
  List_ANY_Var(Machine(RemoteControlSystem),exportConfigurations)==(?);
  List_ANY_Var(Machine(RemoteControlSystem),importConfigurations)==(?);
  List_ANY_Var(Machine(RemoteControlSystem),saveCurrentProfile)==(?);
  List_ANY_Var(Machine(RemoteControlSystem),loadProfile)==(?);
  List_ANY_Var(Machine(RemoteControlSystem),showCurrentProfileIdentification)==(?)
END
&
THEORY ListOfIdsX IS
  List_Of_Ids(Machine(RemoteControlSystem)) == (TEMPERATURE,maxTemperature,minTemperature,CONTROL_KEYS,SPECIAL_KEYS,KEYS_TO_SIGNALS,KEYS_TO_IDENTIFIERS,nullSignal,nullIdentifier,incKey,decKey,setKey,defaultProfile,SIGNAL,KEY,IDENTIFIER,PROFILE_IDENTIFIER | ? | currentProfileIdent,savedProfilesNames,savedProfilesSignals,nameOut,signalOut,keyName,keyMap,currentTemperature | ? | setTemperature,increaseTemperature,decreaseTemperature,showTemperature,pressSpecialKey,recordSignal,recordKeyIdentifier,showKeyIdentifier,exportConfigurations,importConfigurations,saveCurrentProfile,loadProfile,showCurrentProfileIdentification | ? | ? | ? | RemoteControlSystem);
  List_Of_HiddenCst_Ids(Machine(RemoteControlSystem)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(RemoteControlSystem)) == (TEMPERATURE,maxTemperature,minTemperature,CONTROL_KEYS,SPECIAL_KEYS,KEYS_TO_SIGNALS,KEYS_TO_IDENTIFIERS,nullSignal,nullIdentifier,incKey,decKey,setKey,defaultProfile);
  List_Of_VisibleVar_Ids(Machine(RemoteControlSystem)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(RemoteControlSystem)) == (?: ?)
END
&
THEORY SetsEnvX IS
  Sets(Machine(RemoteControlSystem)) == (Type(SIGNAL) == Cst(SetOf(atype(SIGNAL,"[SIGNAL","]SIGNAL")));Type(KEY) == Cst(SetOf(atype(KEY,"[KEY","]KEY")));Type(IDENTIFIER) == Cst(SetOf(atype(IDENTIFIER,"[IDENTIFIER","]IDENTIFIER")));Type(PROFILE_IDENTIFIER) == Cst(SetOf(atype(PROFILE_IDENTIFIER,"[PROFILE_IDENTIFIER","]PROFILE_IDENTIFIER"))))
END
&
THEORY ConstantsEnvX IS
  Constants(Machine(RemoteControlSystem)) == (Type(TEMPERATURE) == Cst(SetOf(btype(INTEGER,"[TEMPERATURE","]TEMPERATURE")));Type(maxTemperature) == Cst(btype(INTEGER,?,?));Type(minTemperature) == Cst(btype(INTEGER,?,?));Type(CONTROL_KEYS) == Cst(SetOf(atype(KEY,"[CONTROL_KEYS","]CONTROL_KEYS")));Type(SPECIAL_KEYS) == Cst(SetOf(atype(KEY,"[SPECIAL_KEYS","]SPECIAL_KEYS")));Type(KEYS_TO_SIGNALS) == Cst(SetOf(SetOf(atype(KEY,"[CONTROL_KEYS","]CONTROL_KEYS")*atype(SIGNAL,"[SIGNAL","]SIGNAL"))));Type(KEYS_TO_IDENTIFIERS) == Cst(SetOf(SetOf(atype(KEY,"[CONTROL_KEYS","]CONTROL_KEYS")*atype(IDENTIFIER,"[IDENTIFIER","]IDENTIFIER"))));Type(nullSignal) == Cst(atype(SIGNAL,?,?));Type(nullIdentifier) == Cst(atype(IDENTIFIER,?,?));Type(incKey) == Cst(atype(KEY,?,?));Type(decKey) == Cst(atype(KEY,?,?));Type(setKey) == Cst(atype(KEY,?,?));Type(defaultProfile) == Cst(atype(PROFILE_IDENTIFIER,?,?)))
END
&
THEORY VariablesEnvX IS
  Variables(Machine(RemoteControlSystem)) == (Type(currentProfileIdent) == Mvl(atype(PROFILE_IDENTIFIER,?,?));Type(savedProfilesNames) == Mvl(SetOf(atype(PROFILE_IDENTIFIER,?,?)*SetOf(atype(KEY,?,?)*atype(IDENTIFIER,?,?))));Type(savedProfilesSignals) == Mvl(SetOf(atype(PROFILE_IDENTIFIER,?,?)*SetOf(atype(KEY,?,?)*atype(SIGNAL,?,?))));Type(nameOut) == Mvl(atype(IDENTIFIER,?,?));Type(signalOut) == Mvl(atype(SIGNAL,?,?));Type(keyName) == Mvl(SetOf(atype(KEY,"[CONTROL_KEYS","]CONTROL_KEYS")*atype(IDENTIFIER,"[IDENTIFIER","]IDENTIFIER")));Type(keyMap) == Mvl(SetOf(atype(KEY,"[CONTROL_KEYS","]CONTROL_KEYS")*atype(SIGNAL,"[SIGNAL","]SIGNAL")));Type(currentTemperature) == Mvl(btype(INTEGER,?,?)))
END
&
THEORY OperationsEnvX IS
  Operations(Machine(RemoteControlSystem)) == (Type(showCurrentProfileIdentification) == Cst(atype(PROFILE_IDENTIFIER,?,?),No_type);Type(loadProfile) == Cst(btype(BOOL,?,?),atype(PROFILE_IDENTIFIER,?,?));Type(saveCurrentProfile) == Cst(No_type,atype(PROFILE_IDENTIFIER,?,?));Type(importConfigurations) == Cst(No_type,SetOf(atype(KEY,"[CONTROL_KEYS","]CONTROL_KEYS")*atype(SIGNAL,"[SIGNAL","]SIGNAL"))*SetOf(atype(KEY,"[CONTROL_KEYS","]CONTROL_KEYS")*atype(IDENTIFIER,"[IDENTIFIER","]IDENTIFIER")));Type(exportConfigurations) == Cst(SetOf(atype(KEY,"[CONTROL_KEYS","]CONTROL_KEYS")*atype(SIGNAL,"[SIGNAL","]SIGNAL"))*SetOf(atype(KEY,"[CONTROL_KEYS","]CONTROL_KEYS")*atype(IDENTIFIER,"[IDENTIFIER","]IDENTIFIER")),No_type);Type(showKeyIdentifier) == Cst(atype(IDENTIFIER,?,?),atype(KEY,?,?));Type(recordKeyIdentifier) == Cst(btype(BOOL,?,?),atype(KEY,?,?)*atype(IDENTIFIER,?,?));Type(recordSignal) == Cst(No_type,atype(SIGNAL,?,?)*atype(KEY,?,?));Type(pressSpecialKey) == Cst(No_type,atype(KEY,?,?));Type(showTemperature) == Cst(btype(INTEGER,?,?),No_type);Type(decreaseTemperature) == Cst(No_type,No_type);Type(increaseTemperature) == Cst(No_type,No_type);Type(setTemperature) == Cst(No_type,btype(INTEGER,?,?)));
  Observers(Machine(RemoteControlSystem)) == (Type(showCurrentProfileIdentification) == Cst(atype(PROFILE_IDENTIFIER,?,?),No_type);Type(exportConfigurations) == Cst(SetOf(atype(KEY,"[CONTROL_KEYS","]CONTROL_KEYS")*atype(SIGNAL,"[SIGNAL","]SIGNAL"))*SetOf(atype(KEY,"[CONTROL_KEYS","]CONTROL_KEYS")*atype(IDENTIFIER,"[IDENTIFIER","]IDENTIFIER")),No_type);Type(showKeyIdentifier) == Cst(atype(IDENTIFIER,?,?),atype(KEY,?,?));Type(showTemperature) == Cst(btype(INTEGER,?,?),No_type))
END
&
THEORY TCIntRdX IS
  predB0 == OK;
  extended_sees == KO;
  B0check_tab == KO;
  local_op == OK;
  abstract_constants_visible_in_values == KO;
  project_type == SOFTWARE_TYPE;
  event_b_deadlockfreeness == KO;
  variant_clause_mandatory == KO;
  event_b_coverage == KO;
  event_b_exclusivity == KO;
  genFeasibilityPO == KO
END
)
