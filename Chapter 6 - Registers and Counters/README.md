# 4-bit Binary Counter with Parallel Load

## Overview

This project implements a 4-bit binary counter with parallel-load functionality using VHDL.

The counter stores its current value in the 4-bit register `A_count[3:0]` and supports four operating conditions:

- Asynchronous Clear
- Parallel Load
- Count Up
- Hold

The control signals `load` and `count` determine the normal operating mode, while `clear_b` asynchronously resets the counter.

A carry-out signal, `C_out`, is also generated when the counter reaches its terminal value `1111` while counting is enabled.

The behavioral VHDL description is synthesized into a circuit consisting of a 4-bit register, incrementing logic, multiplexing logic, comparison logic, and carry-out logic.

---

## Theory

A binary counter is a sequential logic circuit that changes its stored binary value according to clock pulses.

A 4-bit binary counter has 16 possible states:

    0000
    0001
    0010
    0011
    0100
    0101
    0110
    0111
    1000
    1001
    1010
    1011
    1100
    1101
    1110
    1111

After `1111`, the next increment produces `0000`, because the register stores only four bits.

A parallel-load counter extends the basic binary counter by allowing an externally supplied binary value to be loaded directly into the register.

The general next-state behavior is:

    Next State = f(Current State, Load, Count, Data_in)

The output register value is:

    A_count = Current Counter Value

This design also provides a carry-out indication when the counter reaches its maximum value during counting.

---

## Operating Modes

The counter operation is determined by `clear_b`, `load`, and `count`.

| `clear_b` | `load` | `count` | Operation |
|------------|--------|---------|-----------|
| 0 | X | X | Asynchronous Clear |
| 1 | 1 | X | Parallel Load |
| 1 | 0 | 1 | Count Up |
| 1 | 0 | 0 | Hold |

The operation priority is:

    Clear → Load → Count → Hold

Therefore, when `load` and `count` are both asserted, the parallel-load operation takes priority over counting.

---

## Asynchronous Clear

The counter uses an active-low asynchronous clear signal, `clear_b`.

When:

    clear_b = 0

the register is immediately cleared:

    A_count = 0000

The clear operation does not wait for a rising edge of `clk`.

When `clear_b` returns to `1`, normal operation resumes.

The asynchronous clear has the highest priority over Load and Count operations.

---

## Parallel Load

When:

    clear_b = 1
    load = 1

the value on `Data_in[3:0]` is loaded into the counter at the rising edge of `clk`.

The next-state equation is:

    A_count(next) = Data_in

For example:

    Data_in = 1010

After the active clock edge:

    A_count = 1010

This allows the counter to begin counting from an arbitrary 4-bit value.

---

## Count Operation

When:

    clear_b = 1
    load = 0
    count = 1

the counter increments by one at every rising edge of `clk`.

The next-state equation is:

    A_count(next) = A_count + 1

For example:

    1001 → 1010 → 1011 → 1100 → 1101

The counter continues until it reaches:

    1111

The next increment causes the 4-bit counter to wrap around:

    1111 → 0000

---

## Hold Operation

When:

    clear_b = 1
    load = 0
    count = 0

the counter maintains its current value.

The next-state equation is:

    A_count(next) = A_count

For example:

    A_count = 1101

After another rising edge:

    A_count = 1101

No counting or parallel loading occurs in this mode.

---

## Carry-Out

The output `C_out` indicates that the counter is currently at its maximum value while the Count operation is enabled.

The carry-out condition is:

    A_count = 1111
    count = 1
    load = 0

Therefore:

    C_out = 1

only when all three conditions are satisfied.

The logic can be expressed as:

    C_out = count AND NOT(load) AND (A_count = 1111)

When the counter is at `1111` and `C_out` is asserted, the next Count operation produces the overflow transition:

    1111 → 0000

---

## Design Description

The VHDL module contains the following signals.

### Inputs

- `Data_in[3:0]` : 4-bit parallel input data
- `count` : Enables counting
- `load` : Enables parallel loading
- `clk` : Clock signal
- `clear_b` : Active-low asynchronous clear

### Outputs

- `A_count[3:0]` : Current 4-bit counter value
- `C_out` : Carry-out signal

The counter register is represented by `A_count`.

During normal operation, the register can receive one of three values:

    Data_in
    A_count + 1
    A_count

The appropriate value is selected according to `load` and `count` and stored at the rising edge of `clk`.

---

## RTL Structure

The sequential logic is described using a clocked process that is sensitive to both `clk` and `clear_b`.

The register behavior can be summarized as:

    clear_b = 0
        → A_count = 0000

    clear_b = 1 and load = 1
        → A_count = Data_in

    clear_b = 1 and load = 0 and count = 1
        → A_count = A_count + 1

    clear_b = 1 and load = 0 and count = 0
        → A_count remains unchanged

The carry-out logic continuously compares the current counter value with `1111` and combines this condition with the control signals.

---

## Hardware Structure

The synthesized circuit consists of several functional blocks:

- 4-bit register
- 4-bit incrementer
- Multiplexer logic
- Equality comparator
- Carry-out logic
- Asynchronous clear connection

The main data path can be represented as:

    A_count
       |
       +--------------------+
       |                    |
       v                    v
    Increment            Feedback
       |                    |
       +---------+----------+
                 |
                 v
              +------+
    Data_in → | MUX  | → D input
              +------+
                 |
                 v
            +-----------+
      clk → | 4-bit     |
 clear_b →  | Register  |
            +-----+-----+
                  |
                  v
             A_count[3:0]

The feedback path allows the current counter value to be reused for both the Count and Hold operations.

The parallel input provides the separate data path required for Load.

---

## Synthesized Circuit

The synthesized circuit shows the counter implemented using:

- A 4-bit register
- An adder for `A_count + 1`
- Multiplexer logic for selecting the next register value
- Equality comparison logic for detecting `1111`
- Logic gates for generating `C_out`
- An asynchronous clear input

The register output is fed back into the combinational logic.

For the Count operation, the current counter value is sent to the incrementer and the resulting value is selected as the next register value.

For the Load operation, `Data_in[3:0]` is selected instead.

For Hold, the current register value is selected again.

The equality comparator checks whether:

    A_count = 1111

and the comparator output is combined with `count` and `load` to generate `C_out`.

The synthesized RTL schematic therefore directly reflects the behavioral VHDL description.

---

## Simulation

The testbench verifies the major functions of the counter by applying different control signals and input values while generating a periodic clock.

The main signals observed in the simulation are:

    A_count[3:0]
    C_out
    Data_in[3:0]
    count
    load
    clk
    clear_b

The simulation includes:

- Initial asynchronous clear
- Parallel loading
- Hold operation
- Binary counting
- Terminal-count detection
- Overflow from `1111` to `0000`
- Load priority when Load and Count are simultaneously asserted
- Reset during normal operation
- Counting after reset

The simulation is limited to 160 ns.

---

## Simulation Verification

The simulation begins with the asynchronous clear enabled, which produces:

    A_count = 0000

The counter then performs a parallel load using:

    Data_in = 1010

resulting in:

    A_count = 1010

When counting is enabled, the register advances through:

    1010 → 1011 → 1100 → 1101

The counter is subsequently loaded with:

    Data_in = 1110

Counting then produces:

    1110 → 1111 → 0000

This demonstrates the terminal-count and overflow behavior of the 4-bit counter.

When:

    A_count = 1111
    count = 1
    load = 0

the carry-out signal is asserted:

    C_out = 1

The following rising edge increments the counter and produces:

    0000

---

## Load Priority Verification

The simulation also verifies the priority between the Load and Count operations.

When:

    load = 1
    count = 1

and:

    Data_in = 0101

the counter loads the parallel input rather than incrementing the current value.

Therefore:

    A_count = 0101

This confirms that the Load operation has priority over Count.

---

## Waveform Interpretation

The simulation waveform demonstrates the relationship between the control signals and the 4-bit counter value.

The observed register values include:

    0000
    1010
    1011
    1100
    1101
    1110
    1111
    0000
    0101
    0000
    0001
    0010
    0011
    0100

The transitions correspond to the different operating modes applied during the simulation.

The waveform shows that:

- Parallel Load changes `A_count` to the value on `Data_in`.
- Count increments the register on each rising edge.
- Hold preserves the existing register value.
- Clear forces the register to `0000`.
- `C_out` is asserted at the terminal count condition.
- The counter wraps from `1111` to `0000` on the next Count operation.

---

## Functional Summary

The complete behavior of the counter can be summarized by the following equations:

    A_count(next) = 0000
    when clear_b = 0

    A_count(next) = Data_in
    when clear_b = 1 and load = 1

    A_count(next) = A_count + 1
    when clear_b = 1, load = 0, and count = 1

    A_count(next) = A_count
    when clear_b = 1, load = 0, and count = 0

The carry-out equation is:

    C_out = count AND NOT(load) AND (A_count = 1111)

These equations define the complete functional behavior of the circuit.

---

## Result

The 4-bit binary counter with parallel-load functionality was successfully implemented using VHDL.

The design supports:

- Asynchronous Clear
- Parallel Load
- Count Up
- Hold
- Carry-Out Detection
- 4-bit Overflow

The synthesized circuit demonstrates the expected combination of a 4-bit register, incrementer, multiplexer logic, equality comparator, and carry-out logic.

The simulation verifies parallel loading, binary counting, data holding, asynchronous clearing, terminal-count detection, carry-out generation, Load priority, and counter overflow.

The synthesized hardware and simulation waveform are consistent with the intended design and demonstrate the operation of a 4-bit binary counter with parallel-load functionality.