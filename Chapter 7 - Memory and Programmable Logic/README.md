# 64 × 4 Asynchronous Memory

## Overview

This project implements a 64-word by 4-bit asynchronous memory using VHDL.

The memory contains:

    64 words × 4 bits = 256 bits

Each memory location stores one 4-bit data value and is selected by a 6-bit address.

The design supports:

- Asynchronous Write
- Asynchronous Read
- Memory Enable control
- Read/Write control
- High-impedance output when the memory is not reading

The synthesized circuit is implemented as an asynchronous RAM structure with additional logic for write enable and output control.

---

## Theory

A memory is a sequential storage circuit that stores data in individually addressable locations.

A memory with `N` address bits can access:

    2^N

different locations.

Since this design uses a 6-bit address:

    2^6 = 64

the memory contains 64 independently addressable words.

Each word contains 4 bits, giving the total memory capacity:

    64 × 4 = 256 bits

or:

    32 bytes

The memory can be represented conceptually as:

    Address        Data
    000000   →    4-bit value
    000001   →    4-bit value
    000010   →    4-bit value
      ...
    111111   →    4-bit value

The address selects one memory location, while the control signals determine whether data is read from or written to that location.

---

## Memory Organization

The memory array is organized as:

    64 words × 4 bits

The 6-bit `Address` signal selects one of the 64 memory locations.

The address range is:

    000000 → Address 0
    000001 → Address 1
    000010 → Address 2
    ...
    111111 → Address 63

Each selected location stores a 4-bit value.

For example:

    Address = 001010
    Data    = 0110

corresponds to:

    Mem[10] = 0110

---

## Memory Interface

The design uses the following interface signals.

### Inputs

- `Enable` : Enables memory operation
- `ReadWrite` : Selects Read or Write mode
- `DataIn[3:0]` : Data supplied during Write
- `Address[5:0]` : Selects the memory location

### Output

- `DataOut[3:0]` : Data read from the selected memory location

The memory does not use a clock. Both Read and Write operations are asynchronous.

---

## Control Operation

The control behavior is:

| `Enable` | `ReadWrite` | Operation |
|----------|-------------|-----------|
| 0 | X | Disabled |
| 1 | 0 | Write |
| 1 | 1 | Read |

The `ReadWrite` signal is interpreted as:

    ReadWrite = 0 → Write
    ReadWrite = 1 → Read

When `Enable = 0`, the memory does not drive the output bus.

---

## Write Operation

When:

    Enable = 1
    ReadWrite = 0

the value on `DataIn` is written to the memory location selected by `Address`.

The operation can be represented as:

    Mem[Address] = DataIn

For example:

    Address = 000000
    DataIn  = 1010

stores:

    Mem[0] = 1010

Another example:

    Address = 000001
    DataIn  = 1100

stores:

    Mem[1] = 1100

Because the memory is asynchronous, a clock signal is not required for the write operation.

---

## Read Operation

When:

    Enable = 1
    ReadWrite = 1

the data stored at the selected address is transferred to `DataOut`.

The operation can be represented as:

    DataOut = Mem[Address]

For example, after storing:

    Mem[10] = 0110

a Read operation with:

    Address = 001010

produces:

    DataOut = 0110

Changing the address while the memory is enabled in Read mode changes the selected memory location and therefore changes the output data.

---

## Disabled State

When:

    Enable = 0

the memory output is placed in the high-impedance state:

    DataOut = ZZZZ

This behavior allows the memory output to behave like a tri-state bus interface.

When the memory is disabled, it releases the data bus rather than continuously driving a logic value.

---

## Output Behavior During Write

During a Write operation:

    Enable = 1
    ReadWrite = 0

the memory stores `DataIn` into the selected address.

The output is not used for Readback during this operation and is kept inactive by the output control logic.

Therefore, the data flow during Write is:

    DataIn → Memory

while the data flow during Read is:

    Memory → DataOut

---

## Address Decoding

The 6-bit address provides 64 possible locations.

The address structure is:

    Address[5:0]

The corresponding address values are:

    000000 = 0
    000001 = 1
    001010 = 10
    010100 = 20
    111111 = 63

The memory uses the address value to select exactly one word from the 64-word array.

---

## VHDL Implementation

The memory array is conceptually represented by a two-dimensional storage structure:

    64 locations
    each location = 4 bits

The Write logic checks whether the memory is enabled and whether the operation is Write.

The Read logic checks whether the memory is enabled and whether the operation is Read.

The Read path initializes the output to high impedance and drives the selected memory value only when a valid Read operation is active.

The functional behavior can be summarized as:

    Enable = 0
        → DataOut = ZZZZ

    Enable = 1 and ReadWrite = 0
        → Mem[Address] = DataIn

    Enable = 1 and ReadWrite = 1
        → DataOut = Mem[Address]

---

## Asynchronous Read and Write

Unlike a synchronous memory, this design has no clock input.

The memory responds directly to changes in:

    Enable
    ReadWrite
    Address
    DataIn

For Read:

    Address → Memory → DataOut

For Write:

    Address + DataIn → Memory

This allows memory operations to occur independently of a clock edge.

---

## Hardware Structure

The synthesized circuit consists of:

- An asynchronous RAM block
- Address input logic
- Data input logic
- Write-enable logic
- Read-enable/output logic
- Tri-state output control

The main data path can be represented as:

    Address[5:0]
           |
           v
    +----------------+
    |                |
    |   64 × 4 RAM   |
    |                |
    +--------+-------+
             |
             v
        DataOut[3:0]

During Write:

    DataIn[3:0] → RAM

During Read:

    RAM → DataOut[3:0]

The synthesized circuit also contains logic that controls the RAM write enable and the output enable according to `Enable` and `ReadWrite`.

---

## Synthesized Circuit

The synthesized RTL schematic shows an `ASYNC_RAM` block representing the memory array.

The memory block receives:

    DATAIN[3:0]
    ADDRESS[5:0]

and produces:

    DATAOUT[3:0]

The write-enable path is generated from the memory control signals.

The output path is controlled separately so that the memory output is only driven during a valid Read operation.

The synthesized schematic therefore contains three major functional sections:

    Input Data
        ↓
    Addressed Memory
        ↓
    Output Control
        ↓
    DataOut[3:0]

The memory array is implemented as an asynchronous RAM because neither the Read nor the Write path depends on a clock.

---

## Simulation

The testbench verifies the asynchronous memory by writing several values to different addresses and subsequently reading them back.

The main signals observed during simulation are:

    Enable
    ReadWrite
    DataIn[3:0]
    Address[5:0]
    DataOut[3:0]

The simulation verifies:

- Writing data to multiple addresses
- Reading previously stored data
- Changing the memory address during Read
- Disabling the memory output
- Overwriting an existing memory location
- Reading the updated value

Because the memory is asynchronous, no clock signal is required in the testbench.

---

## Simulation Sequence

The testbench first writes the following values:

| Address | Written Data |
|---------|--------------|
| 0 | `1010` |
| 1 | `1100` |
| 10 | `0110` |

The memory is then switched to Read mode.

The expected read results are:

| Address | `DataOut` |
|---------|-----------|
| 0 | `1010` |
| 1 | `1100` |
| 10 | `0110` |

The memory is then disabled.

When:

    Enable = 0

the output becomes:

    DataOut = ZZZZ

Another memory location is then tested.

Address 20 is first written with:

    1111

and read back as:

    1111

The same location is then overwritten with:

    0011

and the subsequent Read operation produces:

    DataOut = 0011

This confirms that a new Write operation replaces the previous value at the same address.

---

## Simulation Verification

The waveform verifies the expected behavior of the memory.

The first Write operations store:

    Mem[0]  = 1010
    Mem[1]  = 1100
    Mem[10] = 0110

During the corresponding Read operations, the waveform shows:

    Address 0  → DataOut = 1010
    Address 1  → DataOut = 1100
    Address 10 → DataOut = 0110

When the memory is disabled, the output is released:

    DataOut = ZZZZ

The testbench then writes:

    Mem[20] = 1111

and reads:

    DataOut = 1111

The value at address 20 is subsequently overwritten:

    Mem[20] = 0011

and the updated value is correctly observed:

    DataOut = 0011

These results verify both storage and retrieval operations.

---

## Waveform Interpretation

The waveform shows the control signals and corresponding memory data.

During the Write intervals:

    Enable = 1
    ReadWrite = 0

the selected memory locations are updated using `DataIn`.

During the Read intervals:

    Enable = 1
    ReadWrite = 1

the corresponding stored value appears on `DataOut`.

The observed data transitions include:

    1010
    1100
    0110
    1111
    0011

These values correspond to the data previously written to the tested addresses.

The waveform also demonstrates that the output is disabled when the memory is not performing a Read.

---

## Data Overwrite

An important property demonstrated by the simulation is that a memory location can be overwritten.

The testbench first stores:

    Address 20 → 1111

A subsequent Read returns:

    1111

The same address is then written with:

    0011

A later Read returns:

    0011

This confirms that the most recent Write operation determines the stored value at that address.

---

## Memory Capacity

The total memory capacity is:

    64 × 4 bits = 256 bits

This is equivalent to:

    32 bytes

The 6-bit address supports:

    2^6 = 64

unique memory locations.

The 4-bit data width means that each address stores one hexadecimal digit.

Therefore, the address space can be viewed as:

    64 words
    ×
    4 bits per word

---

## Functional Summary

The complete functional behavior is:

    Enable = 0
        → DataOut = ZZZZ

    Enable = 1, ReadWrite = 0
        → Write DataIn to Mem[Address]

    Enable = 1, ReadWrite = 1
        → Read Mem[Address] to DataOut

The memory can therefore be described as:

    Write:
    DataIn → Mem[Address]

    Read:
    Mem[Address] → DataOut

The memory operates asynchronously because no clock signal is required for either operation.

---

## Result

The 64-word by 4-bit asynchronous memory was successfully implemented using VHDL.

The design provides:

- 64 addressable memory locations
- 4-bit data width
- 6-bit address width
- Asynchronous Read
- Asynchronous Write
- Enable control
- Read/Write control
- High-impedance output when disabled
- Memory data overwriting

The synthesized circuit shows the expected asynchronous RAM structure together with write-enable and output-control logic.

The simulation verifies that data can be written to selected memory locations, read back correctly, overwritten with new values, and disconnected from the output bus when the memory is disabled.

The synthesized hardware and simulation waveform are consistent with the intended 64 × 4 asynchronous memory architecture.