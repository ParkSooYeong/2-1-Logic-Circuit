\# Prob5\_51\_vhdl



\## Overview



This project implements a \*\*4-state Moore Finite State Machine (FSM)\*\* in VHDL.



The FSM transitions through four states (`S0`–`S3`) according to the input signal `x\_in`. Since this is a \*\*Moore machine\*\*, the output depends solely on the current state and is independent of the current input value.



The synthesized circuit uses a state register and combinational logic to generate the next state and output. Simulation verifies the correctness of the state transitions, asynchronous reset operation, and Moore-type output behavior.



\---



\# Theory



\## Moore Finite State Machine



A Moore Finite State Machine is a sequential circuit in which the output is determined only by the current state.



Its operation consists of two functional blocks:



1\. \*\*State Register\*\*

&#x20;  - Stores the current state.

&#x20;  - Updates on every rising edge of the clock.

&#x20;  - Returns to the initial state when the asynchronous reset is asserted.



2\. \*\*Next-State Logic\*\*

&#x20;  - Computes the next state using the current state and the input signal.



The relationship can be expressed as:



```

Next State = f(Current State, Input)



Output = g(Current State)

```



Unlike a Mealy machine, the output does not change immediately with the input. Instead, it changes only after the state register is updated by the clock, resulting in stable and glitch-free outputs.



\---



\## State Transition Table



| Current State | x\_in = 0 | x\_in = 1 | Output |

|--------------|----------|----------|--------|

| S0 | S0 | S1 | 0 |

| S1 | S1 | S2 | 0 |

| S2 | S2 | S3 | 1 |

| S3 | S3 | S0 | 1 |



The output is asserted whenever the FSM is in \*\*S2\*\* or \*\*S3\*\*.



\---



\# VHDL Implementation



The design is divided into two functional processes.



\## 1. State Register



The sequential process stores the current state.



\- Rising-edge triggered clock

\- Active-low asynchronous reset

\- Loads the next state every clock cycle



```vhdl

process(clk, reset)

```



When `reset` is asserted low, the state immediately returns to \*\*S0\*\* regardless of the clock.



\---



\## 2. Next-State and Output Logic



A combinational process determines both the next state and the Moore output.



```vhdl

process(state, x\_in)

```



The next state is selected according to the current state and input value, while the output depends only on the current state.



```

S0 → y\_out = 0

S1 → y\_out = 0

S2 → y\_out = 1

S3 → y\_out = 1

```



This implementation clearly separates sequential logic from combinational logic, following the standard Moore FSM design methodology.



\---



\# Circuit Description



The synthesized circuit consists of:



\- A 2-bit state register

\- Combinational next-state logic

\- Moore output logic



Quartus synthesis implements the combinational logic primarily with multiplexers, while the state register is realized using flip-flops with an asynchronous clear input.



The output is generated directly from the registered state, ensuring that output transitions occur only after clock-triggered state updates.



\---



\# Simulation



The testbench verifies the FSM by applying:



\- Clock generation

\- Active-low asynchronous reset

\- Multiple input transitions

\- Continuous state transition verification



The simulation confirms that:



\- The FSM initializes to \*\*S0\*\* after reset.

\- Consecutive `x\_in = 1` inputs advance the FSM through `S0 → S1 → S2 → S3`.

\- Holding `x\_in = 0` keeps the machine in its current state.

\- The output is asserted only while the FSM is in \*\*S2\*\* or \*\*S3\*\*.

\- Applying reset during operation immediately returns the FSM to \*\*S0\*\*, clearing the output.



\---



\# Simulation Result



The simulation waveform demonstrates the expected Moore FSM behavior.



\- The asynchronous reset correctly initializes the state machine.

\- The FSM advances through the defined sequence on each rising clock edge when `x\_in = 1`.

\- When the machine reaches \*\*S2\*\* and \*\*S3\*\*, `y\_out` becomes high and remains stable until the state changes.

\- Holding `x\_in = 0` prevents further state advancement and maintains the current output.

\- A reset pulse immediately forces the FSM back to \*\*S0\*\*, causing the output to return low.

\- Output transitions occur only after state transitions, confirming the fundamental characteristic of a Moore finite state machine.



The synthesized circuit and simulation waveform are fully consistent with the designed state transition table and verify the correct implementation of the VHDL Moore FSM.

