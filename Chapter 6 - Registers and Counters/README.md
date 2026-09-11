# 4-bit Binary Counter with Parallel Load

## Overview

This project implements a 4-bit synchronous binary counter with parallel-load functionality.

The circuit provides four operating behaviors:

- Asynchronous Clear
- Parallel Load
- Count Up
- Hold

The counter stores its current value in the 4-bit register `A_count[3:0]`.

The `load` and `count` control signals determine whether a new parallel value is loaded, the current value is incremented, or the current value is maintained.

A carry-out signal, `C_out`, is generated when the counter reaches its maximum value while counting is enabled.

---

## Theory

A binary counter is a sequential circuit that advances through a sequence of binary values in response to clock pulses.

A 4-bit binary counter has 16 possible states:

    0000
    0001
    0010
    ...
    1110
    1111

After reaching `1111`, the next increment causes the counter to overflow and return to `0000`.

The counter in this project additionally supports parallel loading. This allows an arbitrary 4-bit value to be loaded into the register instead of incrementing the current value.

The counter therefore behaves according to the following priority:

    Clear → Load → Count → Hold

This priority determines which operation is performed when multiple control signals are active.

---

## Operating Modes

The normal operating modes are:

| `clear_b` | `load` | `count` | Operation |
|-----------|--------|---------|-----------|
| 0 | X | X | Asynchronous Clear |
| 1 | 1 | X | Parallel Load |
| 1 | 0 | 1 | Count Up |
| 1 | 0 | 0 | Hold |

The asynchronous clear has the highest priority.

When both `load` and `count` are high, the parallel-load operation takes priority over counting.

---

## Binary Counting

When:

    clear_b = 1
    load = 0
    count = 1

the counter increments by one on every rising edge of `clk`.

The next-state equation is:

    A_count(next) = A_count + 1

For example:

    1010 → 1011 → 1100 → 1101 → 1110 → 1111

When the counter reaches:

    A_count = 1111

the next counting operation produces:

    A_count = 0000

because the register contains only four bits.

---

## Parallel Load

When:

    clear_b = 1
    load = 1

the value on `Data_in[3:0]` is loaded into the counter on the next rising edge of `clk`.

The next-state equation is:

    A_count(next) = Data_in

For example:

    Data_in = 1010

After the rising clock edge:

    A_count = 1010

Parallel loading allows the counter to begin counting from any desired 4-bit value.

---

## Hold

When:

    clear_b = 1
    load = 0
    count = 0

the counter retains its current value.

The next-state equation is:

    A_count(next) = A_count

For example:

    A_count = 1101

After another rising clock edge:

    A_count = 1101

No counting or loading occurs in this mode.

---

## Asynchronous Clear

The counter uses an active-low asynchronous clear signal, `clear_b`.

When:

    clear_b = 0

the register is immediately cleared to:

    A_count = 0000

The clear operation does not require a clock edge.

When `clear_b` returns to `1`, the counter resumes normal operation.

The clear operation has higher priority than both the parallel-load and counting operations.

---

## Carry-Out

The counter generates `C_out` when the current counter value is `1111` and counting is enabled.

The carry-out condition is:

    C_out = count AND NOT(load) AND (A_count = 1111)

Therefore:

    C_out = 1

only when:

    A_count = 1111
    count = 1
    load = 0

The carry-out signal indicates that the counter has reached its terminal count and that the next increment will cause an overflow from `1111` to `0000`.

---

## Design Description

The module contains the following inputs and outputs.

### Inputs

- `count` : Enables binary counting
- `load` : Enables parallel loading
- `clk` : Clock signal
- `clear_b` : Active-low asynchronous clear
- `Data_in[3:0]` : 4-bit parallel input

### Outputs

- `A_count[3:0]` : Current counter value
- `C_out` : Carry-out signal

The main storage element is the 4-bit register `A_count`.

The next value of the register is selected according to the control signals.

The functional behavior is:

    clear_b = 0
        → A_count = 0000

    clear_b = 1 and load = 1
        → A_count = Data_in

    clear_b = 1 and load = 0 and count = 1
        → A_count = A_count + 1

    clear_b = 1 and load = 0 and count = 0
        → A_count remains unchanged

---

## RTL Implementation

The sequential logic is implemented using a clocked process sensitive to both the rising edge of `clk` and the falling edge of `clear_b`.

The state update follows this priority:

    if clear_b = 0
        clear the register

    else if load = 1
        load Data_in

    else if count = 1
        increment A_count

    else
        hold A_count

This structure directly represents the required priority of the control signals.

The counter uses non-blocking register assignments, so the stored value changes synchronously with the rising edge of the clock during normal operation.

---

## Hardware Structure

The synthesized circuit contains the following major components:

- 4-bit register
- Incrementing adder
- Parallel-load data path
- Multiplexer for selecting the next counter value
- Equality comparator for detecting `1111`
- Logic gates for generating `C_out`
- Clock input
- Active-low asynchronous clear

The main datapath can be represented conceptually as:

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
    Data_in -->| MUX  |----> D input
              +------+
                 |
                 v
            +-----------+
      clk ->| 4-bit     |
 clear_b -->| Register  |
            +-----+-----+
                  |
                  v
             A_count[3:0]

The multiplexer selects either the parallel input, incremented counter value, or current counter value according to the control signals.

---

## Synthesized Circuit

The synthesized RTL schematic shows the counter as a combination of sequential storage and combinational logic.

The 4-bit register stores `A_count[3:0]`.

An adder generates the incremented value:

    A_count + 1

A multiplexer selects the appropriate next register value based on `load` and `count`.

The feedback path from the register output allows the current counter value to be retained during Hold and used as the input to the incrementing logic during Count mode.

An equality comparator checks whether:

    A_count = 1111

The comparator output is combined with `count` and `load` to generate `C_out`.

The synthesized circuit therefore clearly represents:

    Register
    + Adder
    + Multiplexer
    + Comparator
    + Carry-Out Logic

---

## Simulation

The testbench verifies the major operating modes of the counter.

The simulation observes:

    Count
    Load
    clk
    clr
    Data_in[3:0]
    C_out
    A_count[3:0]

The test sequence includes:

- Initial asynchronous clear
- Parallel loading of `1010`
- Hold operation
- Counting from `1010`
- Parallel loading of `1110`
- Counting through `1111`
- Carry-out verification
- Overflow from `1111` to `0000`
- Load priority verification
- Additional asynchronous clear
- Final count operation

The simulation is limited to 160 ns.

---

## Simulation Verification

The simulation begins with the asynchronous clear operation, which initializes the counter to:

    A_count = 0000

The counter then loads:

    Data_in = 1010

resulting in:

    A_count = 1010

After the load operation, counting is enabled and the counter progresses through:

    1010 → 1011 → 1100 → 1101

The counter is then loaded with:

    Data_in = 1110

After counting is enabled:

    1110 → 1111 → 0000

This confirms both the normal counting operation and the 4-bit overflow behavior.

When the counter reaches:

    A_count = 1111

while:

    count = 1
    load = 0

the carry-out signal becomes:

    C_out = 1

After the following rising edge, the counter wraps around:

    1111 → 0000

The simulation also tests the priority between `load` and `count`.

When:

    load = 1
    count = 1

and:

    Data_in = 0101

the counter loads the parallel input rather than incrementing:

    A_count = 0101

This confirms that the parallel-load operation has priority over the counting operation.

Finally, the asynchronous clear is asserted again, forcing:

    A_count = 0000

The counter then resumes normal counting operation.

---

## Waveform Interpretation

The simulation waveform demonstrates the relationship between the control inputs, the stored counter value, and the carry-out signal.

The observed counter sequence includes:

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

The waveform also shows the `C_out` assertion when the counter is at `1111` while counting is enabled.

The counter value changes on the rising edge of `clk` during normal operation, while the asynchronous clear can reset the register independently of the clock.

---

## Functional Relationships

The main functional relationships of the circuit are:

    A_count(next) = 0000
    when clear_b = 0

    A_count(next) = Data_in
    when clear_b = 1 and load = 1

    A_count(next) = A_count + 1
    when clear_b = 1, load = 0, and count = 1

    A_count(next) = A_count
    when clear_b = 1, load = 0, and count = 0

The carry-out condition is:

    C_out = 1
    when A_count = 1111, count = 1, and load = 0

These equations completely describe the functional behavior of the counter.

---

## Result

The 4-bit binary counter with parallel-load functionality was successfully implemented.

The design supports:

- Asynchronous Clear
- Parallel Load
- Binary Count Up
- Hold
- Carry-Out Detection
- 4-bit Overflow

The synthesized circuit contains the expected 4-bit register, incrementing adder, multiplexer, equality comparator, and carry-out logic.

The simulation confirms correct parallel loading, counting, holding, asynchronous clearing, terminal-count detection, carry-out generation, and overflow behavior.

The synthesized hardware and simulation waveform are consistent with the defined control logic and demonstrate the correct operation of the 4-bit binary counter.