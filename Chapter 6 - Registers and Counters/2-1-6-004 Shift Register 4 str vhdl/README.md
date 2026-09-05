# 4-bit Shift Register (Structural VHDL)

## Overview

This project implements a 4-bit multi-function shift register using a structural VHDL design.

The register supports four operating modes selected by the control signals `s0` and `s1`:

- Hold
- Shift Right
- Shift Left
- Parallel Load

The design is constructed hierarchically from reusable components. Each register stage consists of a 4-to-1 multiplexer and a D Flip-Flop. Four stages are connected together to form the complete 4-bit shift register.

An active-low asynchronous clear signal, `Clear_b`, resets the entire register to `0000`.

---

## Theory

A shift register is a sequential logic circuit used to store binary data and move the stored bits according to clock pulses.

A 4-bit shift register consists of four storage elements. Depending on the selected operating mode, each storage element receives one of several possible inputs:

- Its current value for the Hold operation
- A neighboring register bit for shifting
- A serial input for introducing new data
- A parallel input for loading an entire word

A multi-function shift register can be implemented by placing a multiplexer in front of each flip-flop.

The multiplexer selects the appropriate input, and the selected value is stored by the flip-flop on the rising edge of the clock.

The general structure of a register stage is:

    Data Inputs
        |
        v
    +---------+
    | 4-to-1  |
    |   MUX   |
    +----+----+
         |
         v
    +---------+
    | D Flip- |
    |  Flop   |
    +----+----+
         |
         v
      Q Output

By connecting multiple stages together, the resulting register can shift data between adjacent bits.

---

## Operating Modes

The operating mode is selected by the two-bit control signal `{s0, s1}`.

| `s0` | `s1` | Operation |
|------|------|-----------|
| 0 | 0 | Hold |
| 0 | 1 | Shift Right |
| 1 | 0 | Shift Left |
| 1 | 1 | Parallel Load |

Each mode determines which input is selected by the 4-to-1 multiplexer in every register stage.

---

## Hold Operation

When:

    s0 = 0
    s1 = 0

the current register contents are preserved.

The next-state equation is:

    A_par(next) = A_par

The feedback path from each register output to its multiplexer allows the current value to be selected again.

For example:

    A_par = 1010

After the next rising clock edge:

    A_par = 1010

---

## Shift Right

When:

    s0 = 0
    s1 = 1

the register performs:

    A_par(next) = {MSB_in, A_par[3:1]}

The existing bits move toward the LSB side, and `MSB_in` is inserted into the MSB position.

For example:

    Before: 1010
    MSB_in: 0
    After:  0101

With another shift and `MSB_in = 1`:

    0101 → 1010

The structural implementation achieves this operation by connecting each stage to the next lower-order register bit, with `MSB_in` connected to the most significant stage.

---

## Shift Left

When:

    s0 = 1
    s1 = 0

the register performs:

    A_par(next) = {A_par[2:0], LSB_in}

The existing bits move toward the MSB side, and `LSB_in` is inserted into the LSB position.

For example:

    Before: 1100
    LSB_in: 1
    After:  1001

With another shift and `LSB_in = 0`:

    1001 → 0010

The structural implementation achieves this operation by connecting each stage to the next higher-order register bit, with `LSB_in` connected to the least significant stage.

---

## Parallel Load

When:

    s0 = 1
    s1 = 1

the register loads the entire 4-bit input `I_par`.

The next-state equation is:

    A_par(next) = I_par

For example:

    I_par = 1010

After the next rising clock edge:

    A_par = 1010

All four register bits are loaded simultaneously.

---

## Asynchronous Clear

The register uses an active-low asynchronous clear signal, `Clear_b`.

When:

    Clear_b = 0

all four register bits are immediately cleared:

    A_par = 0000

The clear operation does not wait for a clock edge.

When `Clear_b` returns to `1`, normal operation resumes, and the selected input is captured on the next rising edge of `clk`.

---

## Structural Design

The structural implementation is divided into three reusable components:

1. `Mux_4x1`
2. `D_flip_flop`
3. `stage`

These components are then instantiated four times in the top-level shift register.

The hierarchy is:

    Shift_Register_4_str_vhdl
        |
        +-- ST0
        |    +-- Mux_4x1
        |    +-- D_flip_flop
        |
        +-- ST1
        |    +-- Mux_4x1
        |    +-- D_flip_flop
        |
        +-- ST2
        |    +-- Mux_4x1
        |    +-- D_flip_flop
        |
        +-- ST3
             +-- Mux_4x1
             +-- D_flip_flop

Each `stage` selects one of four possible data inputs and stores the selected value in a D Flip-Flop.

---

## 4-to-1 Multiplexer

The `Mux_4x1` component selects one of four input signals based on the two-bit `sel` signal.

The selection is:

    sel = 00 → i0
    sel = 01 → i1
    sel = 10 → i2
    sel = 11 → i3

The multiplexer therefore determines which value is presented to the D input of the corresponding flip-flop.

---

## D Flip-Flop

The `D_flip_flop` component stores one bit of the register.

It is triggered by the rising edge of `clk`.

The flip-flop also includes an active-high clear input. The external active-low `Clear_b` signal is inverted before being connected to this clear input.

Its behavior is:

    clr = 1 → Q = 0

    clr = 0 and rising_edge(clk) → Q = D

Four D Flip-Flops are required to implement the 4-bit register.

---

## Stage Structure

Each stage contains one multiplexer and one D Flip-Flop.

The stage receives four possible data sources:

    i0
    i1
    i2
    i3

The selected value is:

    mux_out = selected input

and is then stored by the D Flip-Flop:

    Q(next) = mux_out

This allows each stage to independently select the appropriate value required for Hold, Shift Right, Shift Left, or Parallel Load.

---

## Data Connections Between Stages

The four stages are connected to form the shift paths.

### Stage 0

The inputs correspond to:

    i0 = A_par(0)
    i1 = A_par(1)
    i2 = LSB_in
    i3 = I_par(0)

### Stage 1

The inputs correspond to:

    i0 = A_par(1)
    i1 = A_par(2)
    i2 = A_par(0)
    i3 = I_par(1)

### Stage 2

The inputs correspond to:

    i0 = A_par(2)
    i1 = A_par(3)
    i2 = A_par(1)
    i3 = I_par(2)

### Stage 3

The inputs correspond to:

    i0 = A_par(3)
    i1 = MSB_in
    i2 = A_par(2)
    i3 = I_par(3)

These connections provide the feedback, shift, and parallel-load paths required by the four operating modes.

---

## Synthesized Circuit

The synthesized circuit reflects the hierarchical structural design.

The top-level circuit contains four stage blocks, and each stage contains:

- One 4-to-1 multiplexer
- One D Flip-Flop

The four multiplexers use the common select signal:

    sel = s0 & s1

The register outputs are fed back to the multiplexer inputs to support the Hold and Shift operations.

The inter-stage connections provide the bidirectional shift paths.

The serial inputs `MSB_in` and `LSB_in` are connected to the appropriate end stages, while `I_par[3:0]` provides the parallel-load data.

The common clock drives all four D Flip-Flops, allowing the entire register to update simultaneously.

The active-low clear signal is distributed to every stage so that the complete register can be asynchronously cleared.

The synthesized schematic therefore directly reflects the structural VHDL hierarchy.

---

## Simulation

The testbench verifies the functionality of the complete 4-bit structural shift register.

The main signals observed during simulation are:

    s0
    s1
    MSB_in
    LSB_in
    clk
    Clear_b
    I_par[3:0]
    A_par[3:0]

The simulation exercises all four operating modes and the asynchronous clear function.

The maximum simulation interval is limited to 160 ns.

---

## Simulation Verification

The simulation begins with `Clear_b` asserted, causing the register to initialize to:

    A_par = 0000

A parallel-load operation then applies:

    I_par = 1010

resulting in:

    A_par = 1010

The Hold mode maintains this value.

The Shift Right operation is then applied. With the specified `MSB_in` values, the register changes:

    1010 → 0101 → 1010

The register is then loaded with:

    I_par = 1100

The Shift Left operation produces:

    1100 → 1001 → 0010

The Hold mode then maintains:

    A_par = 0010

The asynchronous clear is subsequently asserted, forcing:

    A_par = 0000

Finally, another parallel-load operation applies:

    I_par = 0110

and produces:

    A_par = 0110

These transitions demonstrate the operation of all four modes.

---

## Waveform Interpretation

The simulation waveform shows that the register output changes synchronously with the rising edge of `clk` during normal operation.

The control signals `s0` and `s1` determine which operation is selected.

The observed register values follow the expected sequence:

    0000
      ↓
    1010    Parallel Load
      ↓
    1010    Hold
      ↓
    0101    Shift Right
      ↓
    1010    Shift Right
      ↓
    1100    Parallel Load
      ↓
    1001    Shift Left
      ↓
    0010    Shift Left
      ↓
    0010    Hold
      ↓
    0000    Asynchronous Clear
      ↓
    0110    Parallel Load

The waveform confirms that the structural implementation performs the same register operations defined by the operating-mode table.

---

## Result

The 4-bit multi-function shift register was successfully implemented using structural VHDL.

The design uses reusable `Mux_4x1`, `D_flip_flop`, and `stage` components to construct four register stages.

The synthesized circuit demonstrates the expected combination of multiplexers, flip-flops, feedback paths, and inter-stage connections.

The simulation verifies:

- Hold operation
- Shift Right operation
- Shift Left operation
- Parallel Load operation
- Serial input handling
- Active-low asynchronous clear
- Synchronous register updates

The synthesized circuit and simulation waveform are consistent with the intended structural design and confirm the correct operation of the 4-bit multi-mode shift register.
