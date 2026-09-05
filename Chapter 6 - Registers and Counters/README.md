# 4-bit Binary Counter with Parallel Load

## Overview

This project implements a 4-bit binary counter with parallel-load functionality.

The circuit supports three main operations:

- Asynchronous clear
- Parallel load
- Binary counting

The operation is controlled by the `Count` and `Load` signals. The current 4-bit counter value is stored in `A_count`.

A carry-out signal, `C_out`, is also generated when the counter reaches its maximum value while counting is enabled.

The counter is implemented using a 4-bit register, combinational selection logic, and comparison logic for carry detection.

---

## Theory

A binary counter is a sequential circuit that stores a binary value and changes that value according to clock pulses.

A 4-bit binary counter can represent 16 different values:

    0000 → 0001 → 0010 → ... → 1110 → 1111

After reaching `1111`, incrementing once more causes the 4-bit value to wrap around to `0000`.

Because the counter has four storage bits, it can represent values from:

    0 to 15

This design additionally supports parallel loading, allowing an externally supplied 4-bit value to be loaded directly into the counter instead of incrementing the current value.

The circuit therefore has three normal operating modes:

    Clear
    Parallel Load
    Count
    Hold

The active-low asynchronous clear has the highest priority.

---

## Operation Priority

The counter operation follows this priority:

    Clear
      ↓
    Load
      ↓
    Count
      ↓
    Hold

This means that:

- When `clr = 0`, the counter is immediately cleared.
- When `Load = 1`, `Data_in` is loaded into the counter.
- When `Load = 0` and `Count = 1`, the counter increments.
- When both `Load = 0` and `Count = 0`, the counter holds its current value.

---

## Control Logic

The operating conditions are:

| `clr` | `Load` | `Count` | Operation |
|---|---|---|---|
| 0 | X | X | Clear |
| 1 | 1 | X | Parallel Load |
| 1 | 0 | 1 | Count Up |
| 1 | 0 | 0 | Hold |

The clear operation is asynchronous, while Load, Count, and Hold are synchronized to the rising edge of `clk`.

---

## Parallel Load

When:

    clr = 1
    Load = 1

the counter loads the value present on `Data_in`.

The next counter value is:

    A_count(next) = Data_in

For example:

    Data_in = 1010

After the next rising clock edge:

    A_count = 1010

Parallel loading allows the counter to start counting from an arbitrary 4-bit value.

---

## Count Operation

When:

    clr = 1
    Load = 0
    Count = 1

the counter increments by one on every rising edge of `clk`.

The counting behavior is:

    A_count(next) = A_count + 1

For example:

    1010 → 1011 → 1100 → 1101 → ...

When the counter reaches its maximum value:

    1111

the next increment wraps around to:

    0000

because only four bits are stored.

---

## Hold Operation

When:

    clr = 1
    Load = 0
    Count = 0

the current counter value is preserved.

The next-state behavior is:

    A_count(next) = A_count

For example:

    A_count = 1101

After another rising clock edge:

    A_count = 1101

The counter therefore remains unchanged until either Load or Count is enabled.

---

## Asynchronous Clear

The counter uses an active-low asynchronous clear signal, `clr`.

When:

    clr = 0

the counter is immediately cleared to:

    A_count = 0000

The clear operation does not require a clock edge.

This allows the counter to be initialized or reset at any time.

When `clr` returns to `1`, normal operation resumes on the next rising edge of `clk`.

---

## Carry-Out

The counter generates the carry-out signal `C_out` when all of the following conditions are satisfied:

    Count = 1
    Load = 0
    A_count = 1111

The logic equation is:

    C_out = Count AND NOT(Load) AND (A_count = 1111)

Therefore:

    C_out = 1

only when the counter is at its maximum value and is currently operating in Count mode.

The carry signal indicates that the counter has reached its terminal value and that the next counting operation will overflow from `1111` to `0000`.

---

## Design Description

The design contains the following inputs and outputs.

### Inputs

- `Count` : Enables binary counting
- `Load` : Enables parallel loading
- `clk` : Clock signal
- `clr` : Active-low asynchronous clear
- `Data_in[3:0]` : Parallel input data

### Outputs

- `A_count[3:0]` : Current 4-bit counter value
- `C_out` : Carry-out indication

The main state-holding element is the 4-bit register `A_count`.

The register receives its next value from combinational selection logic that chooses between:

    Data_in
    A_count + 1
    A_count

The selected value is stored on the rising edge of `clk`.

---

## RTL Implementation

The sequential portion of the design is implemented with a clocked process.

The basic behavior is:

    if clr = 0
        A_count <= 0000

    else if Load = 1
        A_count <= Data_in

    else if Count = 1
        A_count <= A_count + 1

    else
        A_count <= A_count

The use of non-blocking assignments ensures that the register updates synchronously at the clock edge.

The combinational carry-out logic continuously checks whether the counter is at `1111` while counting is enabled.

---

## Hardware Structure

The synthesized circuit consists of:

- A 4-bit register
- An incrementing adder
- Multiplexer logic for selecting the next counter value
- Equality comparison logic
- AND logic for generating `C_out`
- Clock input
- Active-low asynchronous clear

The main data path can be represented as:

    Data_in[3:0] --------+
                         |
                         v
                    +---------+
                    |         |
    A_count + 1 --->|   MUX   |----> D input
                    |         |
    A_count --------|         |
                    +----+----+
                         |
                         v
                    +---------+
              clk ->| 4-bit   |
             clr -->| Register|
                    +----+----+
                         |
                         v
                    A_count[3:0]

The multiplexer selects the appropriate next value according to the control inputs.

---

## Synthesized Circuit

The synthesized RTL schematic shows the hardware realization of the counter.

The major components visible in the synthesized circuit are:

- A 4-bit register for `A_count`
- An adder for generating the incremented count
- Multiplexer logic for selecting between parallel load, count, and hold operations
- Equality comparison logic for detecting `A_count = 1111`
- Logic for generating `C_out`
- Asynchronous clear circuitry

The feedback path from `A_count` to the combinational logic is essential for both the Hold operation and the Count operation.

For counting, the current register value is incremented and selected as the next value.

For Hold, the current register value is fed back directly.

For Parallel Load, `Data_in` is selected instead.

The comparison block checks whether the current counter value is `1111`, while the control signals determine whether the carry-out should be asserted.

---

## Simulation

The testbench exercises the counter through multiple operating conditions.

The main signals observed in the simulation are:

    Count
    Load
    clk
    clr
    Data_in[3:0]
    C_out
    A_count[3:0]

The simulation includes:

- Asynchronous clear
- Parallel loading of an initial value
- Hold operation
- Counting through multiple values
- Loading a value near the maximum count
- Carry-out verification
- Overflow from `1111` to `0000`
- Load priority over Count
- Additional asynchronous clear
- Final counting operation

The simulation interval is limited to 160 ns.

---

## Simulation Verification

The simulation first asserts the clear signal and initializes the counter:

    A_count = 0000

The counter then performs a parallel load:

    Data_in = 1010

resulting in:

    A_count = 1010

When both `Load` and `Count` are disabled, the counter holds its value.

Counting is then enabled, producing the sequence:

    1010 → 1011 → 1100 → 1101

The counter is subsequently loaded with:

    Data_in = 1110

Counting then produces:

    1110 → 1111 → 0000

When the counter is `1111` while:

    Count = 1
    Load = 0

the carry-out signal becomes:

    C_out = 1

After the next counting edge, the counter wraps around:

    1111 → 0000

The simulation also verifies Load priority by asserting both `Load` and `Count` simultaneously.

In this condition, the parallel data is loaded instead of incrementing the counter:

    Load = 1
    Count = 1
    Data_in = 0101

resulting in:

    A_count = 0101

This confirms that Load has higher priority than Count.

---

## Waveform Interpretation

The waveform demonstrates the relationship between the control signals and the counter value.

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

The waveform also shows the carry-out pulse when the counter reaches its terminal value of `1111` while counting is enabled.

The counter updates on rising edges of `clk`, while the asynchronous clear can change the counter value independently of the clock.

---

## Result

The 4-bit binary counter was successfully implemented with parallel-load and asynchronous-clear functionality.

The design supports:

- Asynchronous Clear
- Parallel Load
- Binary Count Up
- Hold
- Carry-Out Detection

The synthesized circuit shows the expected combination of a 4-bit register, incrementing logic, multiplexers, comparison logic, and carry detection logic.

The simulation confirms correct register loading, counting, holding, asynchronous clearing, carry-out generation, and overflow behavior.

The results demonstrate a complete synchronous 4-bit counter with selectable parallel loading and terminal-count detection.