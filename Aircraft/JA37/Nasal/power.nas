input = {
    dcBatt1:      "ja37/elec/dc-bus-battery-1-volt",
    dcBatt2:      "ja37/elec/dc-bus-battery-2-volt",
    dcBatt3:      "ja37/elec/dc-bus-battery-3-volt",
    dcMain:       "ja37/elec/dc-bus-main-volt",
    dcSecond:     "ja37/elec/dc-bus-secondary-volt",
    acMain:       "ja37/elec/ac-bus-main-volt",
    acSecond:     "ja37/elec/ac-bus-secondary-volt",
    
    dcMainNorm:   "ja37/elec/dc-bus-main-norm",
    dcSecondNorm: "ja37/elec/dc-bus-secondary-norm",
    dcBatt2Norm:  "ja37/elec/dc-bus-battery-2-norm",
    
    dcBatt1Bool:      "ja37/elec/dc-bus-battery-1-bool",
    dcBatt2Bool:      "ja37/elec/dc-bus-battery-2-bool",
    dcBatt3Bool:      "ja37/elec/dc-bus-battery-3-bool",
    dcMainBool:       "ja37/elec/dc-bus-main-bool",
    dcSecondBool:     "ja37/elec/dc-bus-secondary-bool",
    acMainBool:       "ja37/elec/ac-bus-main-bool",
    acSecondBool:     "ja37/elec/ac-bus-secondary-bool",
    
    hyd1Bool:         "systems/hydraulics/system1/pressure",
    hyd2MainBool:     "systems/hydraulics/system2/pressure-main",
    hyd2ResBool:      "systems/hydraulics/system2/pressure-reserve",
    hyd2Bool:         "systems/hydraulics/system2/pressure",
};

# setup property nodes for the loop
foreach(var name; keys(input)) {
    input[name] = props.globals.getNode(input[name], 1);
}