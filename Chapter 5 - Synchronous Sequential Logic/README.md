\# Prob5\_52 VHDL



\## Overview



This project implements a four-state finite state machine (FSM) using VHDL.



The FSM consists of four states, `S0`, `S1`, `S2`, and `S3`, represented by a 2-bit state register. The state transitions are controlled by the input signal `x\_in` and occur on the rising edge of the clock.



An active-low asynchronous reset, `reset\_b`, initializes the state machine to `S0`.



The design is divided into two major parts:



\- A sequential state register

\- Combinational next-state and output logic



The synthesized circuit demonstrates how the VHDL FSM description is converted into registers and combinational logic.



\---



\## Theory



A Finite State Machine is a sequential logic circuit whose behavior is determined by its current state and input signals.



An FSM generally consists of three major components:



1\. \*\*State Register\*\*

&#x20;  - Stores the current state.

&#x20;  - Updates on the active clock edge.

&#x20;  - Provides the memory required for sequential operation.



2\. \*\*Next-State Logic\*\*

&#x20;  - Determines the state that will be loaded at the next clock edge.

&#x20;  - Uses the current state and input signals.



3\. \*\*Output Logic\*\*

&#x20;  - Generates the circuit output based on the current state and, depending on the FSM structure, the input signals.



The general FSM relationship is:



&#x20;   Next State = f(Current State, Input)

&#x20;   Output = g(Current State, Input)



This design uses an active-low asynchronous reset. When `reset\_b = 0`, the state register is immediately forced to `S0` without waiting for a clock edge.



\---



\## State Encoding



The four states are represented using a 2-bit state register.



| State | Encoding |

|-------|----------|

| `S0` | `00` |

| `S1` | `01` |

| `S2` | `10` |

| `S3` | `11` |



Two flip-flops are sufficient to represent the four possible states.



\---



\## State Transition Table



The FSM follows the state transition rules below.



| Current State | `x\_in = 0` | `x\_in = 1` |

|---------------|------------|------------|

| `S0` | `S0` | `S1` |

| `S1` | `S1` | `S2` |

| `S2` | `S2` | `S3` |

| `S3` | `S3` | `S0` |



When `x\_in = 0`, the FSM remains in its current state.



When `x\_in = 1`, the FSM advances through the sequence:



&#x20;   S0 → S1 → S2 → S3 → S0



This creates a four-state cyclic sequence controlled by the input signal.



\---



\## Output Logic



The output behavior is defined as follows.



| Current State | `x\_in = 0` | `x\_in = 1` |

|---------------|------------|------------|

| `S0` | 0 | 0 |

| `S1` | 0 | 0 |

| `S2` | 1 | 0 |

| `S3` | 1 | 1 |



Therefore:



&#x20;   S0 → y\_out = 0

&#x20;   S1 → y\_out = 0

&#x20;   S2 → y\_out = !x\_in

&#x20;   S3 → y\_out = 1



The output is state-dependent in `S0`, `S1`, and `S3`.



However, in `S2`, the output also depends on `x\_in`:



&#x20;   S2 + x\_in = 0 → y\_out = 1

&#x20;   S2 + x\_in = 1 → y\_out = 0



Therefore, the design does not behave as a pure Moore machine because the output can change according to the input while the FSM remains in `S2`.



\---



\## State Transition Diagram



The FSM can be summarized using the following transitions:



&#x20;   S0 -- x\_in=1 --> S1

&#x20;   S1 -- x\_in=1 --> S2

&#x20;   S2 -- x\_in=1 --> S3

&#x20;   S3 -- x\_in=1 --> S0



When `x\_in = 0`:



&#x20;   S0 → S0

&#x20;   S1 → S1

&#x20;   S2 → S2

&#x20;   S3 → S3



The important sequence for consecutive `1` inputs is therefore:



&#x20;   S0 → S1 → S2 → S3 → S0



\---



\## Reset Operation



The FSM uses an active-low asynchronous reset.



When:



&#x20;   reset\_b = 0



the current state is immediately set to:



&#x20;   S0



The reset does not depend on the clock.



When:



&#x20;   reset\_b = 1



the FSM returns to normal synchronous operation and the state is updated on each rising edge of `clk`.



The state register therefore implements the following behavior:



&#x20;   reset\_b = 0 → state = S0 immediately



&#x20;   reset\_b = 1 → state = next\_state on rising edge of clk



\---



\## VHDL Implementation



The VHDL implementation is divided into a sequential state-register process and a combinational next-state/output process.



\### State Register



The state register is responsible for storing the current state.



Its behavior can be represented as:



&#x20;   process(clk, reset\_b)



&#x20;   if reset\_b = '0' then

&#x20;       state <= S0;



&#x20;   elsif rising\_edge(clk) then

&#x20;       state <= next\_state;



&#x20;   end if;



The asynchronous reset is handled independently from the clock, while normal state transitions occur only on the rising edge of `clk`.



\### Next-State and Output Logic



The second process determines both `next\_state` and `y\_out`.



The logic examines:



&#x20;   state

&#x20;   x\_in



and determines the appropriate state transition and output.



Default assignments are used so that every execution of the combinational process produces a defined value for both `next\_state` and `y\_out`.



This prevents unintended latch inference.



\---



\## Hardware Structure



The synthesized circuit consists of:



\- A 2-bit state register

\- Next-state combinational logic

\- Output combinational logic

\- Clock input

\- Active-low asynchronous reset



The 2-bit state register stores the current FSM state.



The next-state logic receives the current state and `x\_in`, then generates the next state.



The output logic receives the state and `x\_in`, then generates `y\_out`.



The general hardware structure can be represented as:



&#x20;   x\_in ───────────────┐

&#x20;                       │

&#x20;                       ▼

&#x20;                +-------------+

&#x20;                | Next-State  |

&#x20;                |    Logic    |

&#x20;                +------+------+

&#x20;                       |

&#x20;                       ▼

&#x20;                 +-----------+

&#x20;         clk ───►|   State   |

&#x20;      reset\_b ──►| Register  |

&#x20;                 |   2-bit   |

&#x20;                 +-----+-----+

&#x20;                       |

&#x20;                       │ state

&#x20;                       ▼

&#x20;                +-------------+

&#x20;       x\_in ───►|   Output    |

&#x20;                |    Logic    |

&#x20;                +------+------+

&#x20;                       |

&#x20;                       ▼

&#x20;                     y\_out



The synthesized RTL schematic shows this structure through flip-flops and multiplexer-based combinational logic.



\---



\## Synthesized Circuit



The synthesized circuit contains a 2-bit state register and several combinational logic resources used to implement the state transitions and output function.



The state register is clocked by `clk` and includes an active-low clear path driven by `reset\_b`.



The synthesized combinational logic determines the next value loaded into the state register.



The output logic generates `y\_out` according to the current state and the input condition.



The RTL schematic therefore provides a hardware representation of the original VHDL FSM description.



\---



\## Simulation



The testbench generates a periodic clock with a 10 ns period and applies several input patterns to the FSM.



The simulation includes:



\- Initial asynchronous reset

\- State holding with `x\_in = 0`

\- State progression with `x\_in = 1`

\- Output verification in every state

\- Transition from `S3` back to `S0`

\- Additional reset verification during operation



The maximum simulation time is limited to 160 ns.



The main signals observed in the waveform are:



&#x20;   x\_in

&#x20;   clk

&#x20;   reset\_b

&#x20;   y\_out



\---



\## Simulation Verification



The simulation waveform verifies the expected FSM behavior.



After the initial reset, the FSM begins in `S0`.



When `x\_in = 0`, the machine remains in the current state.



When `x\_in = 1`, the state advances on each rising edge of the clock:



&#x20;   S0 → S1 → S2 → S3 → S0



The output changes according to the current state and the input condition.



The expected output behavior is:



&#x20;   S0 → y\_out = 0

&#x20;   S1 → y\_out = 0

&#x20;   S2 + x\_in=0 → y\_out = 1

&#x20;   S2 + x\_in=1 → y\_out = 0

&#x20;   S3 → y\_out = 1



The waveform also confirms the asynchronous reset behavior. When `reset\_b` is asserted low during operation, the FSM immediately returns to `S0`.



\---



\## Simulation Result



The simulation confirms that the implemented state transitions match the defined state transition table.



The following behaviors are verified:



\- `S0` correctly transitions to `S1` when `x\_in = 1`.

\- `S1` correctly transitions to `S2` when `x\_in = 1`.

\- `S2` remains in `S2` when `x\_in = 0`.

\- `S2` transitions to `S3` when `x\_in = 1`.

\- `S3` remains in `S3` when `x\_in = 0`.

\- `S3` returns to `S0` when `x\_in = 1`.

\- `y\_out` becomes high in `S2` when `x\_in = 0`.

\- `y\_out` remains high in `S3`.

\- The asynchronous active-low reset correctly initializes the FSM to `S0`.



The synthesized circuit and simulation waveform are consistent with the VHDL implementation and confirm the correct operation of the four-state FSM.



\---



\## Result



The four-state FSM was successfully implemented in VHDL and synthesized into sequential hardware.



The design demonstrates:



\- 2-bit FSM state representation

\- Synchronous state transitions

\- Active-low asynchronous reset

\- Combinational next-state logic

\- State and input-dependent output logic

\- Hardware synthesis from behavioral VHDL

\- Functional verification through simulation



The synthesized circuit and simulation results confirm that the hardware implementation follows the specified state transition and output behavior.

