\# Moore Model (VHDL)



\## Overview

This project implements a \*\*Moore Finite State Machine (FSM)\*\* in VHDL. The FSM consists of four states (`S0`, `S1`, `S2`, `S3`) and transitions between states according to the input signal `x\_in`. The output `y\_out\[1:0]` depends only on the current state, following the Moore machine model.



The design was verified through simulation using a dedicated VHDL testbench.



\---



\## State Diagram



| Current State | x\_in = 0 | x\_in = 1 | Output (`y\_out`) |

|--------------|----------|----------|------------------|

| S0 | S1 | S0 | 00 |

| S1 | S3 | S2 | 01 |

| S2 | S3 | S2 | 10 |

| S3 | S0 | S3 | 11 |



\---



\## Design Description



\### Inputs

\- `clock` : System clock

\- `reset` : Active-low asynchronous reset

\- `x\_in` : State transition input



\### Outputs

\- `y\_out\[1:0]` : Current state encoding



\### State Encoding



| State | Binary |

|---------|---------|

| S0 | 00 |

| S1 | 01 |

| S2 | 10 |

| S3 | 11 |



\---



\## VHDL Implementation Features



\- Moore FSM architecture

\- Four-state machine

\- Active-low asynchronous reset

\- State transitions synchronized to the rising edge of `clock`

\- Output generated directly from current state



\---



\## Simulation Results



Simulation verified the following behaviors:



\- Reset initializes the FSM to `S0`

\- State transitions occur correctly according to `x\_in`

\- Output reflects the current state encoding

\- FSM operation remains stable after multiple reset assertions



\### RTL Schematic



The synthesized RTL schematic shows:



\- State register implementing the FSM

\- State transition logic driven by `x\_in`

\- Output decoding logic generating `y\_out\[1:0]`



\### Timing Waveform Verification



The waveform confirms:



\- Proper reset behavior

\- Correct state transitions on clock edges

\- Output updates corresponding to the active state

\- Stable operation throughout the simulation interval



\---



\## Files



| File | Description |

|--------|------------|

| `Moore\_Model\_vhdl.vhd` | Moore FSM implementation |

| `Moore\_Model\_vhdl\_tb.vhd` | Testbench for simulation |

| `README.md` | Project documentation |



\---



\## Conclusion



The Moore FSM was successfully implemented in VHDL and verified through simulation. The design correctly performs state transitions based on `x\_in`, generates outputs solely from the current state, and properly handles asynchronous reset conditions.



