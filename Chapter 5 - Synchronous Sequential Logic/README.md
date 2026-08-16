\# Prob5\_52



\## Overview



This project implements a four-state finite state machine (FSM) using Verilog HDL.



The FSM consists of four states, S0, S1, S2, and S3, represented by a 2-bit state register. The state changes according to the input signal x\_in on the rising edge of the clock.



An active-low asynchronous reset, reset\_b, initializes the FSM to S0.



The design is divided into a sequential state register and combinational next-state and output logic.



\---



\## Theory



A Finite State Machine (FSM) is a sequential logic circuit whose behavior is determined by its current state and input signals.



An FSM generally consists of three major components:



\- State Register: Stores the current state.

\- Next-State Logic: Determines the next state from the current state and input signals.

\- Output Logic: Generates the output according to the current state and input signals.



The state register in this design is updated on the rising edge of the clock.



The reset signal is active-low and asynchronous. When reset\_b becomes 0, the state is immediately forced to S0 regardless of the clock.



The general FSM relationship is:



Next State = f(Current State, Input)



Output = g(Current State, Input)



\---



\## State Encoding



The FSM uses four states encoded as follows:



| State | Encoding |

|-------|----------|

| S0 | 2'b00 |

| S1 | 2'b01 |

| S2 | 2'b10 |

| S3 | 2'b11 |



Two flip-flops are therefore sufficient to store the current state.



\---



\## State Transition Table



| Current State | x\_in = 0 | x\_in = 1 |

|---------------|----------|----------|

| S0 | S0 | S1 |

| S1 | S1 | S2 |

| S2 | S2 | S3 |

| S3 | S3 | S0 |



When x\_in is 0, the FSM remains in its current state.



When x\_in is 1, the FSM advances through the sequence:



S0 → S1 → S2 → S3 → S0



\---



\## Output Logic



The output behavior is:



| Current State | x\_in = 0 | x\_in = 1 |

|---------------|----------|----------|

| S0 | 0 | 0 |

| S1 | 0 | 0 |

| S2 | 1 | 0 |

| S3 | 1 | 1 |



The output can therefore be summarized as:



S0 → y\_out = 0



S1 → y\_out = 0



S2 → y\_out = !x\_in



S3 → y\_out = 1



The output is not purely state-dependent because the output in S2 changes according to x\_in. Therefore, the output logic contains both state-dependent and input-dependent behavior.



\---



\## State Register



The state register is implemented using a sequential always block.



&#x20;   always @(posedge clk, negedge reset\_b) begin

&#x20;       if (!reset\_b)

&#x20;           state <= s0;

&#x20;       else

&#x20;           state <= next\_state;

&#x20;   end



The state changes on the rising edge of clk.



When reset\_b changes from 1 to 0, the FSM is immediately reset to S0 without waiting for a clock edge.



This implements an asynchronous active-low reset.



\---



\## Next-State Logic



The next-state logic determines the next state from the current state and x\_in.



The transition behavior is:



&#x20;   S0:

&#x20;       x\_in = 0 → S0

&#x20;       x\_in = 1 → S1



&#x20;   S1:

&#x20;       x\_in = 0 → S1

&#x20;       x\_in = 1 → S2



&#x20;   S2:

&#x20;       x\_in = 0 → S2

&#x20;       x\_in = 1 → S3



&#x20;   S3:

&#x20;       x\_in = 0 → S3

&#x20;       x\_in = 1 → S0



Therefore, a continuous input sequence of x\_in = 1 causes the FSM to cycle through:



S0 → S1 → S2 → S3 → S0



\---



\## Output Logic Implementation



The output is generated inside the combinational logic together with the next-state calculation.



The design initially assigns default values:



&#x20;   y\_out = 1'b0;

&#x20;   next\_state = s0;



The case statement then overrides these values according to the current state and input.



This structure ensures that both y\_out and next\_state always receive a value and prevents unintended storage elements from being inferred in the combinational logic.



The special behavior occurs in state S2:



\- When x\_in = 0, y\_out becomes 1 and the FSM remains in S2.

\- When x\_in = 1, y\_out becomes 0 and the FSM moves to S3.



\---



\## Synthesized Circuit



The synthesized circuit consists of:



\- A 2-bit state register implemented with flip-flops

\- Combinational next-state logic

\- Combinational output logic

\- Clock input

\- Active-low asynchronous reset



The state register stores the current FSM state.



The combinational next-state logic determines which state will be loaded into the register at the next rising edge of clk.



The output logic generates y\_out from the current state and x\_in.



The asynchronous reset is connected to the state register so that the FSM can immediately return to S0 when reset\_b is asserted.



The synthesized RTL circuit therefore corresponds directly to the behavioral FSM description.



\---



\## Simulation



The testbench generates a 10 ns clock and applies multiple x\_in patterns to verify the FSM.



The simulation includes:



\- Initial asynchronous reset

\- State-hold behavior when x\_in = 0

\- State progression when x\_in = 1

\- Output verification for each state

\- Transition from S3 back to S0

\- Additional asynchronous reset verification



The total simulation time is limited to 160 ns.



\---



\## Simulation Verification



The simulation waveform verifies that the FSM is initialized to S0 when reset\_b is asserted.



After reset is released, the FSM responds to x\_in on each rising edge of clk.



When x\_in remains low, the current state is maintained.



When x\_in remains high, the FSM progresses through:



S0 → S1 → S2 → S3 → S0



The output behavior observed during simulation is:



\- S0: y\_out = 0

\- S1: y\_out = 0

\- S2 with x\_in = 0: y\_out = 1

\- S2 with x\_in = 1: y\_out = 0

\- S3: y\_out = 1



The waveform also verifies that asserting reset\_b low asynchronously returns the FSM to S0.



\---



\## Result



The four-state FSM was successfully implemented using Verilog HDL.



The synthesized circuit contains the expected state-register flip-flops and combinational logic for next-state and output generation.



The simulation results match the defined state transition table and output conditions. The asynchronous active-low reset correctly initializes the FSM to S0, while the input signal controls the progression between states.



The synthesized circuit and simulation waveform together confirm the correct functional implementation of the FSM.

