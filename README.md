# faustsimplesynth
A simple sawtooth wave synthesizer implemented in Faust

## Requirements
- [Faust toolchain](https://github.com/grame-cncm/faust)

## How to compile to lv2?
```
cd src/
faust2lv2 faustsimplesynth.dsp
```

## Pros & Cons

### Pros
- short and concise [source code](https://github.com/osamc-lv2-workshop/faustsimplesynth/blob/master/src/faustsimplesynth.dsp) focused on DSP

### Cons
- MIDI note onsets are not [sample-accurate](https://github.com/grame-cncm/faust/blob/7e2256b255444d0e9c2a3db49b91cf31156d8379/architecture/lv2.cpp#L1688)
- Clicks if a note cuts of a prior note. [simplesynth](https://github.com/osamc-lv2-workshop/simplesynth)'s implementation seems to be superior.
