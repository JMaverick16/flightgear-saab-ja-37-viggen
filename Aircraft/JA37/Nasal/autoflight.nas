# Viggen Autoflight
# Copyright (c) 2019 Joshua Davidson (Octal450)

var canEngage = props.globals.getNode("/fdm/jsbsim/autoflight/can-engage");
var canEngageWow = props.globals.getNode("/fdm/jsbsim/autoflight/can-engage-wow");
var mode = props.globals.getNode("/fdm/jsbsim/autoflight/mode"); # 0 GSA, 1 STICK, 2 ATT, 3 ALT
var athr = props.globals.getNode("/fdm/jsbsim/autoflight/athr"); # 0 OFF, 1 ON
var highAlpha = props.globals.getNode("/fdm/jsbsim/autoflight/high-alpha"); # 0 OFF, 1 ON
var apSoftWarn = props.globals.getNode("/ja37/avionics/autopilot-soft-warn");
var apDowngradeMW = props.globals.getNode("/fdm/jsbsim/systems/indicators/master-warning/ap-downgrade");
var wow = props.globals.getNode("/fdm/jsbsim/position/wow");
var tempModeExpired = props.globals.getNode("/fdm/jsbsim/autoflight/temp-mode-expired-out");

var System = {
	engageMode: func(m) {
		if (canEngage.getBoolValue()) {
			me.downgradeCheck(m);
			mode.setValue(m);
		}
	},
	downgradeCheck: func(m) {
		if (m < mode.getValue() and !apDowngradeMW.getBoolValue()) {
			apSoftWarn.setBoolValue(1);
		}
	},
	athrToggle: func() {
		if (canEngageWow.getBoolValue()) {
			highAlpha.setBoolValue(0);
			athr.setBoolValue(!athr.getBoolValue());
		}
	},
	highAlphaToggle: func() {
		if (canEngageWow.getBoolValue() and athr.getBoolValue()) {
			highAlpha.setBoolValue(!highAlpha.getBoolValue());
		}
	},
};

setlistener("/fdm/jsbsim/autoflight/can-engage-out", func {
	if (!canEngage.getBoolValue() and mode.getValue() != 0) {
		System.downgradeCheck(0);
		mode.setValue(0); # GSA
	} else if (canEngage.getBoolValue() and wow.getBoolValue() and mode.getValue() != 1) {
		System.downgradeCheck(1); # Theoretically, it would always be an upgrade, but lets do this just in case
		mode.setValue(1); # STICK
	}
}, 0, 0);

setlistener("/fdm/jsbsim/autoflight/can-engage-wow-out", func {
	if (!canEngageWow.getBoolValue() and athr.getBoolValue() != 0) {
		athr.setBoolValue(0); # OFF
	}
}, 0, 0);

setlistener("/fdm/jsbsim/autoflight/temp-mode-expired-out", func {
	if (tempModeExpired.getBoolValue() and mode.getValue() > 1) {
		System.engageMode(1);
	}
}, 0, 0);
