# 4-bit Shift Register

## Overview

This project implements a 4-bit shift register with four selectable operating modes using Verilog HDL.

The register stores a 4-bit value in `A_par[3:0]` and updates the stored data on the rising edge of `clk`. An active-low asynchronous clear, `Clear_b`, initializes the register to `0000`.

The operating mode is selected using the two control signals `s0` and `s1`.

The four available operations are:

- Hold
- Shift Right
- Shift Left
- Parallel Load

---

## Theory

A shift register is a sequential logic circuit used to store and move binary data.

A typical shift register is constructed from a series of flip-flops. Each flip-flop stores one bit, and the stored data can be shifted between adjacent flip-flops when a clock edge occurs.

A multi-mode shift register extends this concept by allowing different data sources to be selected depending on control signals.

In this design, each bit of the 4-bit register receives its next value through combinational selection logic. The control signals `s0` and `s1` determine which operation is selected, while the selected value is stored in the register on the next rising edge of `clk`.

The general structure is:

Input Data → Mode Selection Logic → Register → Stored Data

The register therefore combines combinational data selection with sequential storage.

---

## Operating Modes

The operating mode is selected by `{s0, s1}`.

| `s0` | `s1` | Operation |
|------|------|-----------|
| 0 | 0 | Hold |
| 0 | 1 | Shift Right |
| 1 | 0 | Shift Left |
| 1 | 1 | Parallel Load |

---

## Hold Operation

When:

`s0 = 0`  
`s1 = 0`

the current register value is preserved.

The next register value is:

`A_par(next) = A_par`

No data is shifted and no new value is loaded.

This mode allows the register contents to remain unchanged while clock pulses continue to occur.

---

## Shift Right Operation

When:

`s0 = 0`  
`s1 = 1`

the register performs:

`A_par(next) = {MSB_in, A_par[3:1]}`

The existing bits move toward the LSB side, while `MSB_in` enters the MSB position.

For example:

`A_par = 1010`

with:

`MSB_in = 0`

the next value becomes:

`0101`

Therefore, each rising clock edge shifts the stored data one bit toward the right and inserts a new serial bit at the MSB position.

---

## Shift Left Operation

When:

`s0 = 1`  
`s1 = 0`

the register performs:

`A_par(next) = {A_par[2:0], LSB_in}`

The existing bits move toward the MSB side, while `LSB_in` enters the LSB position.

For example:

`A_par = 1100`

with:

`LSB_in = 1`

the next value becomes:

`1001`

Each rising clock edge therefore shifts the stored data one bit toward the left and inserts a new serial bit at the LSB position.

---

## Parallel Load Operation

When:

`s0 = 1`  
`s1 = 1`

the register loads all four bits of `I_par` simultaneously.

The next register value is:

`A_par(next) = I_par`

For example:

`I_par = 1010`

After the next rising clock edge:

`A_par = 1010`

Parallel loading allows the complete register contents to be updated in a single clock cycle.

---

## Asynchronous Clear

The register uses an active-low asynchronous clear signal.

When:

`Clear_b = 0`

the register is immediately cleared:

`A_par = 0000`

The clear operation does not require a clock edge.

When `Clear_b` returns to `1`, the register resumes normal operation and the next selected value is loaded on the following rising edge of `clk`.

---

## Design Description

The design contains the following inputs and output:

### Inputs

- `s0` : Mode selection bit
- `s1` : Mode selection bit
- `MSB_in` : Serial input used during shift-right operation
- `LSB_in` : Serial input used during shift-left operation
- `clk` : Clock signal
- `Clear_b` : Active-low asynchronous clear
- `I_par[3:0]` : 4-bit parallel input

### Output

- `A_par[3:0]` : 4-bit register output

The mode selection determines which value is presented to the D inputs of the four register bits.

The four next-value possibilities are:

| Mode | Next Value |
|------|------------|
| `00` | `A_par` |
| `01` | `{MSB_in, A_par[3:1]}` |
| `10` | `{A_par[2:0], LSB_in}` |
| `11` | `I_par` |

The selected value is stored on the rising edge of `clk`.

---

## RTL Implementation

The register is implemented as a clocked sequential process:

`always @(posedge clk or negedge Clear_b)`

The asynchronous clear has priority over the selected operating mode.

When `Clear_b = 0`, the register is cleared to `0000`.

Otherwise, the `case` statement uses `{s0, s1}` to determine the next register value.

The feedback connections used in the hold and shift operations allow the current register contents to participate in the next-state calculation.

---

## Synthesized Circuit

The synthesized circuit contains a 4-bit register preceded by combinational multiplexing logic.

The RTL schematic shows four multiplexer structures, one for each register bit. These multiplexers select among:

- The current register value
- Shifted register values
- Serial inputs
- Parallel input data

The selected values are connected to the D inputs of the four flip-flops.

A common clock drives all four flip-flops, so the entire 4-bit register is updated simultaneously.

The active-low `Clear_b` signal is connected to the clear inputs of the register elements, allowing the complete register to be cleared asynchronously.

The synthesized structure therefore represents a conventional multi-mode shift register built from multiplexers and flip-flops.

---

## Simulation

The testbench exercises all four operating modes of the shift register.

The simulation checks:

- Asynchronous clear
- Parallel load
- Hold
- Shift right
- Shift left
- Multiple shift operations
- Additional clear operation
- Final parallel load

The main signals observed in the waveform are:

- `s0`
- `s1`
- `MSB_in`
- `LSB_in`
- `clk`
- `Clear_b`
- `I_par[3:0]`
- `A_par[3:0]`

The simulation allows the effect of each control combination to be observed directly.

---

## Simulation Verification

The simulation begins with `Clear_b` asserted, forcing:

`A_par = 0000`

A parallel-load operation then loads:

`I_par = 1010`

resulting in:

`A_par = 1010`

The hold mode preserves this value.

During the shift-right operation, the register changes according to the inserted `MSB_in` value.

For example:

`1010 → 0101 → 1010`

The register is then loaded with:

`I_par = 1100`

Afterward, the shift-left operation produces:

`1100 → 1001 → 0010`

depending on the applied `LSB_in` values.

The hold operation maintains the current register contents without shifting.

Another asynchronous clear forces:

`A_par = 0000`

Finally, a parallel-load operation loads:

`I_par = 0110`

and the register output becomes:

`A_par = 0110`

These transitions match the defined operating modes and confirm the correct behavior of the shift register.

---

## Result

The 4-bit shift register was successfully implemented using combinational mode-selection logic and sequential storage elements.

The design supports four operations:

- Hold
- Shift Right
- Shift Left
- Parallel Load

The synthesized RTL structure confirms the use of multiplexers for selecting the appropriate next value for each register bit and flip-flops for storing the selected data.

The simulation waveform verifies correct operation of all four modes, serial shifting, parallel loading, data retention, and asynchronous clearing.

The implementation therefore demonstrates the construction and operation of a configurable 4-bit shift register using synchronous sequential logic.