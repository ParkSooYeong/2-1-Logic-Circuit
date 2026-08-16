# Prob5_52

## Overview

This project implements a four-state finite state machine (FSM) using Verilog HDL.

The FSM consists of four states, S0, S1, S2, and S3, represented by a 2-bit state register. The state changes according to the input signal x_in on the rising edge of the clock.

An active-low asynchronous reset, reset_b, initializes the FSM to S0.

The design is divided into a sequential state register and combinational next-state and output logic.

---

## Theory

A Finite State Machine (FSM) is a sequential logic circuit whose behavior is determined by its current state and input signals.

An FSM generally consists of three major components:

- State Register: Stores the current state.
- Next-State Logic: Determines the next state from the current state and input signals.
- Output Logic: Generates the output according to the current state and input signals.

The state register in this design is updated on the rising edge of the clock.

The reset signal is active-low and asynchronous. When reset_b becomes 0, the state is immediately forced to S0 regardless of the clock.

The general FSM relationship is:

Next State = f(Current State, Input)

Output = g(Current State, Input)

---

## State Encoding

The FSM uses four states encoded as follows:

| State | Encoding |
|-------|----------|
| S0 | 2'b00 |
| S1 | 2'b01 |
| S2 | 2'b10 |
| S3 | 2'b11 |

Two flip-flops are therefore sufficient to store the current state.

---

## State Transition Table

| Current State | x_in = 0 | x_in = 1 |
|---------------|----------|----------|
| S0 | S0 | S1 |
| S1 | S1 | S2 |
| S2 | S2 | S3 |
| S3 | S3 | S0 |

When x_in is 0, the FSM remains in its current state.

When x_in is 1, the FSM advances through the sequence:

S0 → S1 → S2 → S3 → S0

---

## Output Logic

The output behavior is:

| Current State | x_in = 0 | x_in = 1 |
|---------------|----------|----------|
| S0 | 0 | 0 |
| S1 | 0 | 0 |
| S2 | 1 | 0 |
| S3 | 1 | 1 |

The output can therefore be summarized as:

S0 → y_out = 0

S1 → y_out = 0

S2 → y_out = !x_in

S3 → y_out = 1

The output is not purely state-dependent because the output in S2 changes according to x_in. Therefore, the output logic contains both state-dependent and input-dependent behavior.

---

## State Register

The state register is implemented using a sequential always block.

    always @(posedge clk, negedge reset_b) begin
        if (!reset_b)
            state <= s0;
        else
            state <= next_state;
    end

The state changes on the rising edge of clk.

When reset_b changes from 1 to 0, the FSM is immediately reset to S0 without waiting for a clock edge.

This implements an asynchronous active-low reset.

---

## Next-State Logic

The next-state logic determines the next state from the current state and x_in.

The transition behavior is:

    S0:
        x_in = 0 → S0
        x_in = 1 → S1

    S1:
        x_in = 0 → S1
        x_in = 1 → S2

    S2:
        x_in = 0 → S2
        x_in = 1 → S3

    S3:
        x_in = 0 → S3
        x_in = 1 → S0

Therefore, a continuous input sequence of x_in = 1 causes the FSM to cycle through:

S0 → S1 → S2 → S3 → S0

---

## Output Logic Implementation

The output is generated inside the combinational logic together with the next-state calculation.

The design initially assigns default values:

    y_out = 1'b0;
    next_state = s0;

The case statement then overrides these values according to the current state and input.

This structure ensures that both y_out and next_state always receive a value and prevents unintended storage elements from being inferred in the combinational logic.

The special behavior occurs in state S2:

- When x_in = 0, y_out becomes 1 and the FSM remains in S2.
- When x_in = 1, y_out becomes 0 and the FSM moves to S3.

---

## Synthesized Circuit

The synthesized circuit consists of:

- A 2-bit state register implemented with flip-flops
- Combinational next-state logic
- Combinational output logic
- Clock input
- Active-low asynchronous reset

The state register stores the current FSM state.

The combinational next-state logic determines which state will be loaded into the register at the next rising edge of clk.

The output logic generates y_out from the current state and x_in.

The asynchronous reset is connected to the state register so that the FSM can immediately return to S0 when reset_b is asserted.

The synthesized RTL circuit therefore corresponds directly to the behavioral FSM description.

---

## Simulation

The testbench generates a 10 ns clock and applies multiple x_in patterns to verify the FSM.

The simulation includes:

- Initial asynchronous reset
- State-hold behavior when x_in = 0
- State progression when x_in = 1
- Output verification for each state
- Transition from S3 back to S0
- Additional asynchronous reset verification

The total simulation time is limited to 160 ns.

---

## Simulation Verification

The simulation waveform verifies that the FSM is initialized to S0 when reset_b is asserted.

After reset is released, the FSM responds to x_in on each rising edge of clk.

When x_in remains low, the current state is maintained.

When x_in remains high, the FSM progresses through:

S0 → S1 → S2 → S3 → S0

The output behavior observed during simulation is:

- S0: y_out = 0
- S1: y_out = 0
- S2 with x_in = 0: y_out = 1
- S2 with x_in = 1: y_out = 0
- S3: y_out = 1

The waveform also verifies that asserting reset_b low asynchronously returns the FSM to S0.

---

## Result

The four-state FSM was successfully implemented using Verilog HDL.

The synthesized circuit contains the expected state-register flip-flops and combinational logic for next-state and output generation.

The simulation results match the defined state transition table and output conditions. The asynchronous active-low reset correctly initializes the FSM to S0, while the input signal controls the progression between states.

The synthesized circuit and simulation waveform together confirm the correct functional implementation of the FSM.
