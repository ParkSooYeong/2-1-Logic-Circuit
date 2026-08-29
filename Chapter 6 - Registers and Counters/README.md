# 4-bit Shift Register (Structural VHDL)

## Overview

This project implements a 4-bit multi-function shift register using a structural VHDL design.

The register supports four operating modes selected by the control signals `s0` and `s1`:

- Hold
- Shift Right
- Shift Left
- Parallel Load

The structural implementation divides the register into four identical stages. Each stage consists of a 4-to-1 multiplexer and a D Flip-Flop. The multiplexer selects the appropriate next value for each register bit, while the D Flip-Flop stores that value on the rising edge of the clock.

An active-low asynchronous clear signal, `Clear_b`, resets all four register bits to `0000`.

---

## Theory

A shift register is a sequential circuit used to store binary data and shift that data between adjacent storage elements.

A 4-bit shift register contains four storage elements. Depending on the required operation, the register can:

- Preserve its current contents
- Shift data toward the MSB
- Shift data toward the LSB
- Load a complete 4-bit value in parallel

A multi-function shift register can be constructed by placing a multiplexer before each flip-flop. The multiplexer selects the data source according to control signals, and the selected value is stored when the clock edge occurs.

The basic structure of each stage is:

    Multiple Data Sources
            |
            v
       +----------+
       | 4-to-1   |
       |   MUX    |
       +----+-----+
            |
            v
       +----------+
       | D Flip-  |
       |   Flop   |
       +----+-----+
            |
            v
      Register Bit

Four such stages are connected together to form the complete 4-bit register.

---

## Operating Modes

The operation is selected using `{s0, s1}`.

| `s0` | `s1` | Operation |
|------|------|-----------|
| 0 | 0 | Hold |
| 0 | 1 | Shift Right |
| 1 | 0 | Shift Left |
| 1 | 1 | Parallel Load |

The corresponding next-state functions are:

| Mode | Next Register Value |
|------|---------------------|
| `00` | `A_par` |
| `01` | `{MSB_in, A_par[3:1]}` |
| `10` | `{A_par[2:0], LSB_in}` |
| `11` | `I_par` |

---

## Hold

When `s0 = 0` and `s1 = 0`, the register keeps its current contents.

    A_par(next) = A_par

For example:

    1010 → 1010

The feedback path from each register bit to its corresponding multiplexer allows the current value to be selected again.

---

## Shift Right

When `s0 = 0` and `s1 = 1`, the register shifts one bit toward the LSB side.

The operation is:

    A_par(next) = {MSB_in, A_par[3:1]}

The bit entering the register is provided by `MSB_in`.

For example:

    A_par = 1010
    MSB_in = 0

    Next A_par = 0101

A second shift with `MSB_in = 1` produces:

    0101 → 1010

Thus, the serial input enters the MSB position while the existing bits move toward the LSB.

---

## Shift Left

When `s0 = 1` and `s1 = 0`, the register shifts one bit toward the MSB side.

The operation is:

    A_par(next) = {A_par[2:0], LSB_in}

The bit entering the register is provided by `LSB_in`.

For example:

    A_par = 1100
    LSB_in = 1

    Next A_par = 1001

With `LSB_in = 0`, the next shift produces:

    1001 → 0010

Thus, the serial input enters the LSB position while the existing bits move toward the MSB.

---

## Parallel Load

When `s0 = 1` and `s1 = 1`, the complete four-bit input is loaded at once.

The operation is:

    A_par(next) = I_par

For example:

    I_par = 1010

After the next rising clock edge:

    A_par = 1010

Parallel loading allows all four bits of the register to be updated simultaneously.

---

## Asynchronous Clear

The register uses an active-low asynchronous clear signal, `Clear_b`.

When:

    Clear_b = 0

all register bits are immediately cleared:

    A_par = 0000

The clear operation does not require a clock edge.

When `Clear_b` returns to `1`, normal operation resumes and the selected data is stored on the next rising edge of `clk`.

---

## Structural Design

The structural implementation divides the 4-bit register into four individual stages:

    ST0
    ST1
    ST2
    ST3

Each stage contains:

- One 4-to-1 multiplexer
- One D Flip-Flop

The four stages are connected according to the shift-register data path.

### Stage 0

Stage 0 generates `A_par[0]`.

Its inputs correspond to:

- `i0` → `LSB_in`
- `i1` → `A_par[1]`
- `i2` → `A_par[0]`
- `i3` → `I_par[0]`

### Stage 1

Stage 1 generates `A_par[1]`.

Its inputs correspond to:

- `i0` → `A_par[0]`
- `i1` → `A_par[2]`
- `i2` → `A_par[1]`
- `i3` → `I_par[1]`

### Stage 2

Stage 2 generates `A_par[2]`.

Its inputs correspond to:

- `i0` → `A_par[1]`
- `i1` → `A_par[3]`
- `i2` → `A_par[2]`
- `i3` → `I_par[2]`

### Stage 3

Stage 3 generates `A_par[3]`.

Its inputs correspond to:

- `i0` → `A_par[2]`
- `i1` → `MSB_in`
- `i2` → `A_par[3]`
- `i3` → `I_par[3]`

The select input of all four multiplexers is driven by:

    select = {s0, s1}

This allows every stage to perform the same selected operation simultaneously.

---

## 4-to-1 Multiplexer

The `Mux_4x1` module selects one of four inputs using the two-bit `select` signal.

The selection is:

    select = 00 → i0
    select = 01 → i1
    select = 10 → i2
    select = 11 → i3

The multiplexer therefore determines which data source is passed to the D Flip-Flop of each stage.

---

## D Flip-Flop

Each stage uses a D Flip-Flop to store one register bit.

The flip-flop is triggered by the rising edge of `clk`.

It also includes an asynchronous clear input.

The behavior is:

    Clr = 1 → Q = 0

    Clr = 0 and rising edge of clk → Q = D

The active-low external clear signal is inverted before being connected to the active-high clear input of the D Flip-Flop.

---

## Hardware Structure

The complete structural design can be represented as four parallel stages:

    +---------+     +---------+     +---------+     +---------+
    | Stage 0 |     | Stage 1 |     | Stage 2 |     | Stage 3 |
    | MUX +   |     | MUX +   |     | MUX +   |     | MUX +   |
    | DFF     |     | DFF     |     | DFF     |     | DFF     |
    +----+----+     +----+----+     +----+----+     +----+----+
         |               |               |               |
         v               v               v               v
      A_par[0]        A_par[1]        A_par[2]        A_par[3]

All stages share:

    clk
    Clear_b
    select = {s0, s1}

The interconnections between stages form the shift paths, while the parallel input signals provide the parallel-load path.

---

## Synthesized Circuit

The synthesized RTL schematic shows the hierarchical structure of the design.

Each stage contains a 4-to-1 multiplexer followed by a D Flip-Flop. The four stages are arranged vertically and connected through feedback and shift paths.

The synthesized circuit clearly shows:

- Four independent register stages
- Four 4-to-1 multiplexers
- Four D Flip-Flops
- Common clock distribution
- Common asynchronous clear distribution
- Feedback paths for the Hold operation
- Inter-stage connections for shifting
- Serial inputs for Shift Right and Shift Left
- Parallel input connections for Parallel Load

The structural organization makes the relationship between the VHDL components and the synthesized hardware explicit.

---

## Simulation

The testbench verifies all major operating modes of the register.

The simulation observes:

    s0
    s1
    MSB_in
    LSB_in
    clk
    Clear_b
    I_par[3:0]
    A_par[3:0]

The sequence includes:

1. Initial asynchronous clear
2. Parallel Load
3. Hold
4. Shift Right
5. Additional Shift Right
6. Parallel Load
7. Shift Left
8. Additional Shift Left
9. Hold
10. Asynchronous clear
11. Final Parallel Load

The maximum simulation interval is limited to 160 ns.

---

## Simulation Verification

The simulation begins with `Clear_b` asserted, producing:

    A_par = 0000

A parallel-load operation then applies:

    I_par = 1010

and the register becomes:

    A_par = 1010

The Hold mode keeps the register at:

    A_par = 1010

The Shift Right operation then produces:

    1010 → 0101 → 1010

The first transition uses `MSB_in = 0`, and the second uses `MSB_in = 1`.

The register is then loaded with:

    I_par = 1100

The Shift Left operation produces:

    1100 → 1001 → 0010

The inserted values are controlled by `LSB_in`.

After the shifting operations, the Hold mode keeps:

    A_par = 0010

The asynchronous clear is then asserted:

    Clear_b = 0

which immediately produces:

    A_par = 0000

Finally, another parallel-load operation applies:

    I_par = 0110

resulting in:

    A_par = 0110

---

## Waveform Interpretation

The simulation waveform demonstrates the relationship between the mode-selection signals and the register contents.

The `s0` and `s1` signals determine which input is selected by every 4-to-1 multiplexer.

The register output `A_par[3:0]` changes on the rising edge of `clk` when a normal operating mode is selected.

The asynchronous clear is an exception: when `Clear_b` is asserted low, `A_par` is cleared immediately without waiting for a clock edge.

The observed register sequence is:

    0000 → 1010 → 1010 → 0101 → 1010
         → 1100 → 1001 → 0010 → 0010
         → 0000 → 0110

This sequence covers all four operating modes and confirms the intended behavior of the structural shift register.

---

## Result

The 4-bit shift register was successfully implemented using a structural VHDL architecture consisting of four stages.

Each stage combines a 4-to-1 multiplexer and a D Flip-Flop to select and store the appropriate next value.

The four control modes provide:

    00 → Hold
    01 → Shift Right
    10 → Shift Left
    11 → Parallel Load

The synthesized circuit confirms the expected hierarchy of multiplexers and flip-flops, while the simulation verifies correct data retention, bidirectional shifting, parallel loading, and asynchronous clearing.

The structural implementation therefore demonstrates how a configurable 4-bit shift register can be constructed from reusable digital logic components and verified through synthesized hardware and simulation.