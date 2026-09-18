# 4-bit Binary Counter with Parallel Load

## Overview

This project implements a 4-bit binary counter with parallel-load functionality using Verilog HDL.

The counter stores its current value in the 4-bit register `A_count` and supports the following operations:

- Asynchronous Clear
- Parallel Load
- Count Up
- Hold

The operation is controlled by the `load`, `count`, and `clr` signals.

A `C_out` signal is also provided to indicate that the counter has reached its maximum value, `1111`, while counting is enabled.

The design is synthesized into a circuit containing a 4-bit register, incrementing logic, selection logic, comparison logic, and carry-out logic.

---

## Theory

A binary counter is a sequential logic circuit that changes its stored binary value in response to clock transitions.

A 4-bit binary counter can represent 16 different values:

    0000 → 0001 → 0010 → 0011 → ... → 1110 → 1111

After `1111`, the next increment returns the counter to `0000`.

A parallel-load counter extends the basic counter by allowing an external binary value to be loaded directly into the register. This makes it possible to start counting from an arbitrary value.

The counter also includes an asynchronous clear function, which allows the stored value to be reset independently of the clock.

---

## Operation Priority

The counter operates according to the following priority:

    Clear
      ↓
    Load
      ↓
    Count
      ↓
    Hold

This means that:

1. `clr = 0` immediately clears the counter.
2. When `clr = 1` and `load = 1`, `Data_in` is loaded.
3. When `clr = 1`, `load = 0`, and `count = 1`, the counter increments.
4. When both `load = 0` and `count = 0`, the current value is retained.

When `load` and `count` are both asserted, the parallel-load operation takes precedence.

---

## Control Table

| `clr` | `load` | `count` | Operation |
|-------|--------|---------|-----------|
| 0 | X | X | Asynchronous Clear |
| 1 | 1 | X | Parallel Load |
| 1 | 0 | 1 | Count Up |
| 1 | 0 | 0 | Hold |

The clear operation is asynchronous, while Load, Count, and Hold are synchronized to the rising edge of `clk`.

---

## Parallel Load

When:

    clr = 1
    load = 1

the value of `Data_in[3:0]` is loaded into `A_count` on the rising edge of `clk`.

The next-state equation is:

    A_count(next) = Data_in

For example:

    Data_in = 1001

After the rising clock edge:

    A_count = 1001

This allows the counter to begin counting from any selected 4-bit value.

---

## Count Operation

When:

    clr = 1
    load = 0
    count = 1

the counter increments by one on every rising edge of `clk`.

The next-state equation is:

    A_count(next) = A_count + 1

For example, starting from:

    1001

the counter progresses as:

    1001 → 1010 → 1011 → 1100 → 1101 → ...

The counter continues until it reaches:

    1111

The following increment produces:

    1111 → 0000

This is the normal overflow behavior of a 4-bit binary counter.

---

## Hold Operation

When:

    clr = 1
    load = 0
    count = 0

the counter retains its current value.

The next-state equation is:

    A_count(next) = A_count

For example:

    A_count = 1011

After another rising edge of `clk`:

    A_count = 1011

No counting or loading occurs while the counter is in Hold mode.

---

## Asynchronous Clear

The `clr` input is an active-low asynchronous clear.

When:

    clr = 0

the counter is immediately reset to:

    A_count = 0000

The clear operation does not require a clock edge.

When `clr` returns to `1`, normal operation resumes.

The asynchronous clear has the highest priority in the counter.

---

## Carry-Out

The `C_out` output indicates that the counter has reached its terminal value while counting is enabled.

The carry-out condition is:

    A_count = 1111
    count = 1
    load = 0

Therefore:

    C_out = 1

only when all three conditions are satisfied.

The logic can be expressed as:

    C_out = count AND NOT(load) AND (A_count = 1111)

When `A_count = 1111` and the counter is enabled, `C_out` indicates that the next counting operation will overflow the 4-bit register.

---

## Design Description

The module contains the following inputs and outputs.

### Inputs

- `count` : Enables the count-up operation
- `load` : Enables parallel loading
- `clk` : Clock signal
- `clr` : Active-low asynchronous clear
- `Data_in[3:0]` : 4-bit parallel input

### Outputs

- `A_count[3:0]` : Current 4-bit counter value
- `C_out` : Carry-out indication

The counter register receives one of three possible values during normal operation:

    Data_in
    A_count + 1
    A_count

The selected value is stored in `A_count` on the rising edge of `clk`.

---

## RTL Structure

The sequential logic is implemented with a clocked process.

The behavior can be summarized as:

    if clr = 0
        A_count <= 0000

    else if load = 1
        A_count <= Data_in

    else if count = 1
        A_count <= A_count + 1

    else
        A_count <= A_count

The carry-out is generated separately by comparing the current counter value with `1111`.

This separates the state-holding function from the terminal-count detection logic.

---

## Hardware Structure

The synthesized circuit contains several major functional blocks:

- 4-bit register
- 4-bit incrementing adder
- Multiplexer for next-value selection
- Equality comparator
- Carry-out logic
- Asynchronous clear circuitry

The main data path is:

    A_count ──→ Incrementer ──┐
                              │
    Data_in ──────────────────┤
                              ▼
                            MUX
                              │
                              ▼
                         4-bit Register
                              │
                              ▼
                         A_count[3:0]

The current register value is fed back into the combinational logic.

This feedback allows the counter to increment its current value or retain it during Hold mode.

---

## Synthesized Circuit

The synthesized RTL schematic shows the counter implemented with a 4-bit register and combinational logic.

The main components visible in the synthesized circuit are:

- An adder that produces `A_count + 1`
- Selection logic for choosing between the incremented value and `Data_in`
- Feedback from the register output
- A 4-bit equality comparator that detects `A_count = 1111`
- Logic that combines the comparator result with `count` and `load` to generate `C_out`
- A register with an asynchronous clear input

The synthesized structure corresponds directly to the RTL description.

The feedback path from `A_count` is used by both the incrementing logic and the Hold operation.

---

## Simulation

The testbench applies different combinations of `count`, `load`, `clr`, and `Data_in` while generating a periodic clock.

The simulation verifies:

- Asynchronous clear
- Parallel loading
- Counting
- Hold operation
- Counter overflow
- Carry-out generation
- Load priority over Count
- Reset during normal operation

The main signals observed in the waveform are:

    count
    load
    clk
    clr
    Data_in[3:0]
    C_out
    A_count[3:0]

---

## Simulation Verification

The simulation begins by clearing the counter.

After the clear operation:

    A_count = 0000

A parallel-load operation then applies:

    Data_in = 1010

and the register becomes:

    A_count = 1010

When counting is enabled, the counter advances through:

    1010 → 1011 → 1100 → 1101

The counter is then loaded with a value close to its maximum:

    Data_in = 1110

Counting produces:

    1110 → 1111 → 0000

This verifies both terminal-count behavior and 4-bit overflow.

When the counter reaches:

    A_count = 1111

with:

    count = 1
    load = 0

the carry-out signal becomes asserted:

    C_out = 1

The following count operation causes the register to wrap around:

    1111 → 0000

---

## Load Priority Verification

The simulation also verifies the priority relationship between `load` and `count`.

When both are asserted:

    load = 1
    count = 1

and:

    Data_in = 0101

the counter loads the parallel input instead of incrementing the current value.

Therefore:

    A_count = 0101

This confirms that the Load operation has priority over Count.

---

## Waveform Interpretation

The simulation waveform demonstrates the relationship between the control signals and the stored counter value.

The counter progresses according to the enabled operation.

The observed sequence includes:

    0000
      ↓
    1010    Parallel Load
      ↓
    1011    Count
      ↓
    1100    Count
      ↓
    1101    Count
      ↓
    1110    Parallel Load
      ↓
    1111    Count
      ↓
    0000    Overflow
      ↓
    0101    Parallel Load
      ↓
    0000    Asynchronous Clear
      ↓
    0001    Count
      ↓
    0010    Count
      ↓
    0011    Count

The waveform also shows the carry-out assertion around the terminal count.

The counter output changes synchronously with the rising edge of `clk`, while the asynchronous clear can reset the register independently of the clock.

---

## Result

The 4-bit binary counter with parallel-load functionality was successfully implemented and synthesized.

The design supports:

- Asynchronous Clear
- Parallel Load
- Count Up
- Hold
- Carry-Out Detection
- 4-bit Overflow

The synthesized circuit demonstrates the expected combination of a 4-bit register, incrementer, multiplexer, equality comparator, and carry-out logic.

The simulation verifies correct parallel loading, counting, holding, asynchronous clearing, terminal-count detection, carry-out generation, Load priority, and overflow behavior.

The synthesized hardware structure and simulation waveform are consistent with the intended counter design.
