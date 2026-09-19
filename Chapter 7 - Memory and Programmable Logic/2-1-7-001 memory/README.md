# 64 x 4 Asynchronous Memory

## Overview

This project implements a 64-word by 4-bit asynchronous memory using Verilog HDL.

The memory contains:

- 64 addressable words
- 4 bits of data per word
- 6-bit address input
- 4-bit data input
- 4-bit data output
- Enable control
- Read/Write control

The memory is organized as:

    64 words × 4 bits = 256 bits

Each memory location can store one 4-bit value and is selected using the 6-bit `Address` input.

The design uses asynchronous read and write behavior, meaning that the memory operation is controlled directly by the enable, read/write control, address, and data signals without a separate clock signal.

---

## Memory Organization

The memory array is declared as:

    Mem[0:63]

with each location containing 4 bits.

The address width is 6 bits:

    Address[5:0]

Since 6 bits can represent 64 different binary values:

    000000 → 0
    000001 → 1
    ...
    111111 → 63

the complete memory address space contains 64 locations.

Each location stores a 4-bit value:

    Mem[Address] = 4-bit data

---

## Memory Interface

The module has the following inputs and outputs.

### Inputs

- `Enable` : Enables memory access
- `ReadWrite` : Selects Read or Write operation
- `Address[5:0]` : Selects one of the 64 memory locations
- `DataIn[3:0]` : Data used during a Write operation

### Output

- `DataOut[3:0]` : Data read from the selected memory location

The control signals determine whether the memory is disabled, performing a read, or performing a write.

---

## Control Operation

The memory operates according to the following table:

| `Enable` | `ReadWrite` | Operation |
|----------|-------------|-----------|
| 0 | X | Disabled |
| 1 | 0 | Write |
| 1 | 1 | Read |

When `Enable = 0`, the memory is disabled and `DataOut` is placed in the high-impedance state:

    DataOut = ZZZZ

This allows the output to behave like a tri-state memory data bus.

---

## Write Operation

When:

    Enable = 1
    ReadWrite = 0

the 4-bit value on `DataIn` is stored at the memory location specified by `Address`.

The write operation is:

    Mem[Address] = DataIn

For example:

    Address = 001011
    DataIn  = 1010

stores:

    Mem[11] = 1010

The memory contents remain stored until another write operation overwrites the same address.

Because this is an asynchronous memory model, the write operation does not depend on a clock edge.

---

## Read Operation

When:

    Enable = 1
    ReadWrite = 1

the memory contents at the selected address are placed on `DataOut`.

The read operation is:

    DataOut = Mem[Address]

For example, if:

    Mem[11] = 1010

then:

    Address = 001011
    Enable  = 1
    ReadWrite = 1

produces:

    DataOut = 1010

Changing the address changes the selected memory location and therefore changes the read data.

---

## Disabled State

When:

    Enable = 0

the memory does not drive the data output.

The output is:

    DataOut = ZZZZ

The high-impedance state is useful when the memory is connected to a shared data bus, because the memory can release the bus when it is not selected.

---

## Address Decoding

The 6-bit address input selects one of the 64 memory locations.

The address range is:

| Address Range | Number of Locations |
|---------------|---------------------|
| `000000` to `111111` | 64 |

For example:

    Address = 000000 → Memory location 0
    Address = 000001 → Memory location 1
    Address = 001010 → Memory location 10
    Address = 010100 → Memory location 20
    Address = 111111 → Memory location 63

The address decoder therefore determines which memory word participates in the selected operation.

---

## Memory Data Path

The logical data flow is:

    Address[5:0]
          |
          v
    +-------------+
    | Address     |
    | Selection   |
    +------+------+
           |
           v
    +-------------+
    |   64 x 4    |
    |   Memory    |
    +------+------+
           |
           v
      DataOut[3:0]

During a Write operation, `DataIn[3:0]` is stored in the selected memory location.

During a Read operation, the selected memory word is transferred to `DataOut[3:0]`.

---

## RTL Behavior

The memory operation is controlled by the `Enable` and `ReadWrite` signals.

The basic behavior is:

    if Enable = 1
        if ReadWrite = 1
            DataOut = Mem[Address]
        else
            Mem[Address] = DataIn
    else
        DataOut = ZZZZ

This structure implements both asynchronous read and asynchronous write behavior.

The memory does not require a clock signal.

---

## Read and Write Control

The `ReadWrite` signal determines the direction of the data transfer.

When:

    ReadWrite = 0

data flows:

    DataIn → Memory

When:

    ReadWrite = 1

data flows:

    Memory → DataOut

Therefore, the complete data direction can be summarized as:

    Write:
    DataIn → Mem[Address]

    Read:
    Mem[Address] → DataOut

---

## Hardware Structure

The synthesized circuit represents the memory as an asynchronous RAM structure together with input/output selection logic.

The major functional blocks are:

- Memory array
- Address selection logic
- Write-enable logic
- Read-data path
- Output-enable logic

The address bus selects the memory word, while the control signals determine whether the selected location is written or read.

The synthesized design shown in the RTL schematic contains an asynchronous RAM block with:

    DATAIN[3:0]
    ADDRESS[5:0]
    WE

and a corresponding data output path.

Additional logic controls whether the memory output drives the external `DataOut[3:0]` bus.

---

## Synthesized Circuit

The synthesized circuit is implemented as an asynchronous RAM structure.

The RTL schematic shows:

- A `64 × 4` memory block
- A 6-bit address input
- A 4-bit input data bus
- A 4-bit output data bus
- Write-enable logic derived from the control signals
- Output selection and enable logic

The memory block receives:

    Address[5:0]
    DataIn[3:0]

and produces the stored data corresponding to the selected address.

The write-enable function is controlled by the memory enable and read/write signals.

When the memory is being read, the stored value is routed toward `DataOut`.

When the memory is disabled, the output path is placed in the high-impedance state.

The synthesized structure therefore reflects the logical organization of an asynchronous 64-word by 4-bit memory.

---

## Simulation

The testbench verifies both Read and Write operations across multiple memory addresses.

The main signals observed in the simulation are:

    Enable
    ReadWrite
    Address[5:0]
    DataIn[3:0]
    DataOut[3:0]

The simulation verifies:

- Writing data to different memory addresses
- Reading the previously stored values
- Changing the selected address during Read operation
- Disabling the memory
- Verifying high-impedance output
- Overwriting an existing memory location
- Reading the updated value

The memory is tested without a clock because the design uses asynchronous memory operations.

---

## Simulation Sequence

The testbench first writes several values to different memory locations.

The following values are stored:

    Address 0  → 1010
    Address 1  → 1100
    Address 10 → 0110

The memory is then switched to Read mode.

Reading the corresponding addresses produces:

    Address 0  → DataOut = 1010
    Address 1  → DataOut = 1100
    Address 10 → DataOut = 0110

Another memory location is tested:

    Address 20 → 1111

The stored value is then overwritten:

    Address 20
    Old Data = 1111
    New Data = 0011

A subsequent Read operation confirms:

    DataOut = 0011

This demonstrates that a Write operation replaces the previous contents of the selected memory location.

---

## Disabled Output Verification

The simulation also disables the memory by setting:

    Enable = 0

During this condition:

    DataOut = ZZZZ

This verifies that the memory output is not actively driving the data bus while the memory is disabled.

The high-impedance output is important for systems where multiple devices may share the same data bus.

---

## Waveform Interpretation

The simulation waveform demonstrates the relationship between `Enable`, `ReadWrite`, `Address`, `DataIn`, and `DataOut`.

During Write operations:

    Enable = 1
    ReadWrite = 0

the input data is stored at the selected address.

During Read operations:

    Enable = 1
    ReadWrite = 1

the data stored at the selected address appears on `DataOut`.

The observed read values correspond to the previously written memory contents:

    Address 0  → 1010
    Address 1  → 1100
    Address 10 → 0110
    Address 20 → 1111

After overwriting address 20:

    Address 20 → 0011

the updated value is observed during the subsequent Read operation.

When `Enable` is deasserted, `DataOut` enters the high-impedance state.

---

## Asynchronous Memory Behavior

Unlike synchronous RAM, this design does not use a clock signal.

The memory operation responds directly to changes in:

    Enable
    ReadWrite
    Address
    DataIn

For Read operations, changing the address selects a different memory location and changes the output data.

For Write operations, changing the address and input data updates the selected memory location when writing is enabled.

This makes the design an asynchronous memory model.

---

## Memory Capacity

The implemented memory capacity is:

    64 × 4 bits = 256 bits

The memory contains:

    64 words

and each word contains:

    4 bits

The total storage capacity is therefore:

    256 bits
    = 32 bytes

The address width is 6 bits because:

    2^6 = 64

This provides exactly one unique address for every memory word.

---

## Result

The 64-word by 4-bit asynchronous memory was successfully implemented using Verilog HDL.

The design supports:

- Asynchronous Read
- Asynchronous Write
- 64 memory locations
- 4-bit data width
- 6-bit addressing
- Memory Enable
- Read/Write control
- High-impedance output when disabled
- Data overwriting at existing addresses

The synthesized circuit demonstrates the expected asynchronous RAM structure, address selection logic, write-enable control, and output-enable path.

The simulation verifies that values written to selected addresses can be read back correctly, that existing values can be overwritten, and that the output becomes high impedance when the memory is disabled.

The synthesized hardware and simulation waveform are consistent with the intended 64 × 4 asynchronous memory design.