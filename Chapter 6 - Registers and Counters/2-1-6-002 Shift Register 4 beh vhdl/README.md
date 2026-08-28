# 4-bit Shift Register

## Overview

This project implements a 4-bit shift register with four selectable operating modes using VHDL.

The register stores a 4-bit value in `A_par[3:0]` and updates its contents on the rising edge of `clk`. An active-low asynchronous clear signal, `Clear_b`, resets the register to `0000`.

The operating mode is selected by the two control signals `s0` and `s1`.

The four available operations are:

- Hold
- Shift Right
- Shift Left
- Parallel Load

The design is implemented as a behavioral VHDL model and is synthesized into a register with combinational multiplexer logic.

---

## Theory

A shift register is a sequential logic circuit that stores binary data and moves the stored bits between adjacent storage elements according to a clock signal.

A 4-bit shift register contains four flip-flops, with each flip-flop storing one bit. By controlling the data source connected to each flip-flop, the register can support multiple operations such as holding the current value, shifting data, and loading a complete parallel value.

A multi-mode shift register can be implemented by placing a multiplexer in front of each register bit. The multiplexer selects the appropriate input according to the control signals.

The general structure is:

Input Sources → Multiplexer Selection → 4-bit Register → A_par[3:0]

The selected data is captured by the register on the rising edge of the clock.

---

## Operating Modes

The operating mode is selected by `{s0, s1}`.

| `s0` | `s1` | Operation |
|------|------|-----------|
| 0 | 0 | Hold |
| 0 | 1 | Shift Right |
| 1 | 0 | Shift Left |
| 1 | 1 | Parallel Load |

Each mode determines the value that will be loaded into the 4-bit register at the next rising edge of `clk`.

---

## Hold

When:

    s0 = 0
    s1 = 0

the register retains its current contents.

The next-state equation is:

    A_par(next) = A_par

For example:

    A_par = 1010

After a clock edge in Hold mode:

    A_par = 1010

No bits are shifted and no new data is loaded.

---

## Shift Right

When:

    s0 = 0
    s1 = 1

the register performs:

    A_par(next) = {MSB_in, A_par[3:1]}

The existing bits move toward the LSB side, while `MSB_in` is inserted into the MSB position.

For example:

    Before: 1010
    MSB_in: 0

    After: 0101

A second shift with:

    MSB_in = 1

produces:

    0101 → 1010

Therefore, the register shifts one position toward the right on every active clock edge and receives a new serial bit at the MSB side.

---

## Shift Left

When:

    s0 = 1
    s1 = 0

the register performs:

    A_par(next) = {A_par[2:0], LSB_in}

The existing bits move toward the MSB side, while `LSB_in` is inserted into the LSB position.

For example:

    Before: 1100
    LSB_in: 1

    After: 1001

With:

    LSB_in = 0

the next shift produces:

    1001 → 0010

Therefore, the register shifts one position toward the left on every active clock edge and receives a new serial bit at the LSB side.

---

## Parallel Load

When:

    s0 = 1
    s1 = 1

the register loads the complete 4-bit value from `I_par`.

The next-state equation is:

    A_par(next) = I_par

For example:

    I_par = 1010

After the next rising edge:

    A_par = 1010

Parallel loading allows all four register bits to be updated simultaneously.

---

## Asynchronous Clear

The design uses an active-low asynchronous clear signal, `Clear_b`.

When:

    Clear_b = 0

the register is immediately cleared to:

    A_par = 0000

The clear operation does not depend on the clock.

When `Clear_b` returns to `1`, the register resumes normal operation and the selected value is loaded on the next rising edge of `clk`.

The clear input therefore has priority over the four normal operating modes.

---

## Design Description

The module contains the following inputs and output.

### Inputs

- `s0` : First mode-selection bit
- `s1` : Second mode-selection bit
- `MSB_in` : Serial input for shift-right operation
- `LSB_in` : Serial input for shift-left operation
- `clk` : Clock signal
- `Clear_b` : Active-low asynchronous clear
- `I_par[3:0]` : 4-bit parallel data input

### Output

- `A_par[3:0]` : 4-bit register output

The next value of the register is selected according to the following table:

| Mode | Next Value |
|------|------------|
| `00` | `A_par` |
| `01` | `{MSB_in, A_par[3:1]}` |
| `10` | `{A_par[2:0], LSB_in}` |
| `11` | `I_par` |

The selected value is stored in the register on the rising edge of `clk`.

---

## VHDL Implementation

The design uses a clocked process that is sensitive to both `clk` and `Clear_b`.

The sequential behavior is conceptually:

    if Clear_b = '0'
        A_par <= "0000"

    elsif rising_edge(clk)
        case {s0, s1}
            00 → Hold
            01 → Shift Right
            10 → Shift Left
            11 → Parallel Load

This structure separates the mode-selection behavior from the storage behavior while keeping the implementation synthesizable.

The current register value is fed back into the combinational selection logic for the Hold, Shift Right, and Shift Left operations.

---

## Hardware Structure

The synthesized circuit consists of a 4-bit register and combinational multiplexer logic.

Conceptually, each register bit receives one of several possible data sources:

    Current register value
    Shifted register value
    Serial input
    Parallel input

The `s0` and `s1` control signals determine which source is selected.

The selected data is then stored in the four flip-flops when `clk` has a rising edge.

The overall data path can be represented as:

    +-----------------------------+
    |      Mode Selection         |
    |                             |
    |  Hold                       |
    |  Shift Right                |
    |  Shift Left                 | ----> D inputs
    |  Parallel Load              |
    +-----------------------------+
                    |
                    v
              +-----------+
              | 4-bit     |
       clk -->| Register  |
   Clear_b -->|           |
              +-----+-----+
                    |
                    v
                A_par[3:0]

The synthesized RTL schematic shows multiple multiplexer blocks connected to the D inputs of the 4-bit register.

---

## Synthesized Circuit

The synthesized circuit contains:

- Four D-type storage elements representing `A_par[3:0]`
- Multiplexer logic for selecting the next value of each bit
- Feedback paths from `A_par[3:0]`
- Serial input paths for `MSB_in` and `LSB_in`
- Parallel input paths from `I_par[3:0]`
- A common clock
- An active-low asynchronous clear

The feedback connections are particularly important.

For Hold mode, the current register output is selected again.

For Shift Right mode, the current register bits are shifted toward the LSB direction and `MSB_in` is inserted.

For Shift Left mode, the current register bits are shifted toward the MSB direction and `LSB_in` is inserted.

For Parallel Load mode, the four bits of `I_par` are selected directly.

The synthesized circuit therefore corresponds directly to the four operating modes defined by the VHDL implementation.

---

## Simulation

The testbench exercises all four operating modes and the asynchronous clear function.

The simulation observes:

- `s0`
- `s1`
- `MSB_in`
- `LSB_in`
- `clk`
- `Clear_b`
- `I_par[3:0]`
- `A_par[3:0]`

The input sequence is designed to demonstrate each register operation.

The maximum simulation interval is limited to 160 ns.

---

## Simulation Verification

The simulation begins with the asynchronous clear asserted.

The register is therefore initialized to:

    A_par = 0000

The first parallel-load operation applies:

    I_par = 1010

and produces:

    A_par = 1010

The Hold mode is then applied, and the register retains:

    A_par = 1010

The Shift Right operation is then verified.

With:

    MSB_in = 0

the register changes:

    1010 → 0101

With:

    MSB_in = 1

the next shift produces:

    0101 → 1010

The register is then loaded with:

    I_par = 1100

The Shift Left operation is subsequently verified.

With:

    LSB_in = 1

the register changes:

    1100 → 1001

With:

    LSB_in = 0

the next shift produces:

    1001 → 0010

The Hold mode maintains:

    A_par = 0010

The asynchronous clear is then asserted again, forcing:

    A_par = 0000

Finally, the register performs another parallel load:

    I_par = 0110

resulting in:

    A_par = 0110

These transitions match the defined operating modes and confirm the functionality of the register.

---

## Waveform Interpretation

The simulation waveform demonstrates the relationship between the control signals and the stored register value.

The `s0` and `s1` signals determine which operation is active.

The `A_par[3:0]` waveform changes only when a selected value is captured on a rising edge of `clk`, except when `Clear_b` is asserted, which asynchronously clears the register.

The observed register sequence is:

    0000
      ↓
    1010     Parallel Load
      ↓
    1010     Hold
      ↓
    0101     Shift Right
      ↓
    1010     Shift Right
      ↓
    1100     Parallel Load
      ↓
    1001     Shift Left
      ↓
    0010     Shift Left
      ↓
    0010     Hold
      ↓
    0000     Asynchronous Clear
      ↓
    0110     Parallel Load

This sequence demonstrates all major functions of the shift register in a single simulation.

---

## Result

The 4-bit shift register was successfully implemented using VHDL.

The design supports four selectable operations:

- Hold
- Shift Right
- Shift Left
- Parallel Load

The synthesized circuit shows the expected combination of multiplexer logic and four storage elements. The feedback paths provide the current register contents required for Hold and Shift operations, while the serial and parallel input paths provide the additional data sources.

The simulation verifies that the register correctly performs each selected operation, maintains its contents in Hold mode, shifts data in both directions, loads parallel data, and responds immediately to the active-low asynchronous clear.

The synthesized hardware structure and simulation waveform are consistent with the intended 4-bit multi-mode shift register.
