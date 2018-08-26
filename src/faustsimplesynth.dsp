// faustsimplesynth - a simple sawtooth wave synthesizer implemented in Faust
// Copyright (C) 2018 Daniel Appelt

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

declare name "faustsimplesynth";
declare version "0.1.0";
declare author "Daniel Appelt";
declare license "GPL3";
declare copyright "Copyright (C) 2018 Daniel Appelt";
// Declaring nvoices takes care of creating a synth plugin / app
declare nvoices "1";

import("stdfaust.lib");

// MIDI note input (by naming convention)
midigate = button("gate [hidden]");
midifreq = hslider("freq [unit:Hz][hidden]", 440, 20, 20000, 1);
midigain = hslider("gain [hidden]", 0.5, 0, 1, 0.001);

// ADSR amp envelope
a = hslider("h:Env/[0]Attack [unit: s][scale:log][style:knob]", 0.1, 0.001, 2, 0.001);
d = hslider("h:Env/[1]Decay [unit: s][scale:log][style:knob]", 0.3, 0.001, 2, 0.001);
s = hslider("h:Env/[2]Sustain [style:knob]", 0.8, 0, 1, 0.01);
r = hslider("h:Env/[2]Release [unit: s][scale:log][style:knob]", 2.0, 0.001, 4, 0.001);

// Volume always sets the maximum loudness
amp_vol = hslider("h:Amplifier/[0]Volume [style:knob]", 0.5, 0, 1, 0.01);
// Velocity determines how much of the volume will be affected by MIDI note velocity.
// 0 = no effect, 1 = max velocity leads to max volume, -1 = min velocity leads to max volume
amp_vel = hslider("h:Amplifier/[1]Velocity [style:knob]", 0, -1, 1, 0.01);
amp_mod = (midigain * amp_vel + (amp_vel < 0) + 1 - abs(amp_vel)) * en.adsr(a, d, s, r, midigate);

process = midifreq : os.sawtooth * amp_mod * amp_vol;
