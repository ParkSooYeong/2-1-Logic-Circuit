# Tri-State Based 2:1 Multiplexer Design and Verification

## 1. Overview

This project implements a 2-to-1 multiplexer using tri-state buffer primitives.  
The design was verified through RTL simulation and analyzed using the synthesized netlist.

The objective of this work was to:

- Understand tri-state buffer behavior
- Implement a multiplexer using enable-controlled buffers
- Verify functional correctness through waveform analysis
- Confirm structural consistency between RTL and netlist


## 2. Design Concept

The multiplexer is constructed using two tri-state buffers connected to a shared output bus.

- One buffer passes input **A** when `select = 1`
- The other buffer passes input **B** when `select = 0`
- The output node is driven by only one buffer at a time

Because both buffers share the same output line, the output behaves as a tri-state net.  
When one buffer is enabled, the other remains in high-impedance (Z) state.

Functional behavior:

- If `select = 1` → Output follows **A**
- If `select = 0` → Output follows **B**

This implementation demonstrates a structural approach to MUX design using bus control.


## 3. Netlist Analysis

After synthesis, the generated netlist shows:

- Two enable-controlled buffer blocks
- Shared output bus structure
- One enable driven by `select`
- The other enable driven by inverted `select`

Verification confirms:

- No simultaneous bus driving
- No combinational loops
- No unintended storage elements

The synthesized structure matches the intended tri-state architecture.


## 4. Simulation Verification

RTL simulation was performed in ModelSim.

Waveform analysis confirms:

- When `select = 0`, the output matches input **B**
- When `select = 1`, the output matches input **A**
- Output transitions are immediate (pure combinational behavior)
- No unknown (`X`) states appear
- No bus contention occurs

RTL simulation and netlist behavior are consistent.


## 5. Key Technical Points

### Tri-State Buffer Characteristics
- Output can be driven or set to high-impedance
- Multiple drivers can share a bus when properly controlled
- Enable signals must be mutually exclusive

### MUX Implementation Approaches
Two main approaches exist:

1. Behavioral modeling using logic expressions
2. Structural modeling using tri-state buffers

This project uses the structural tri-state method.


## 6. Verification Summary

The design has been validated through:

- Waveform inspection
- Structural netlist confirmation
- Enable signal consistency checking

All verification results confirm correct multiplexer operation.


## 7. Conclusion

The tri-state based 2:1 multiplexer was successfully implemented and verified.

This work reinforces:

- Understanding of enable-controlled buffer design
- Bus-sharing architecture principles
- Relationship between RTL and synthesized netlist
- Practical waveform-based functional validation

The design operates correctly and meets the intended specifications.
