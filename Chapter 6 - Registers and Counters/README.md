# 4-bit Ripple Counter

## Overview

This project implements a 4-bit asynchronous ripple counter using four cascaded complementary D Flip-Flops.

Each flip-flop operates as a toggle element by feeding the inverted output back to its D input. The output of each flip-flop is then used as the clock signal for the next stage.

The counter provides four output bits:

- `A0` : Least Significant Bit (LSB)
- `A1`
- `A2`
- `A3` : Most Significant Bit (MSB)

An active-high asynchronous reset initializes all four outputs to `0`.

---

## Theory

A binary counter is a sequential circuit that progresses through a series of binary values according to clock transitions.

A 4-bit counter contains four storage elements and can represent 16 different values:

    0000 → 0001 → 0010 → 0011 → ... → 1110 → 1111 → 0000

A ripple counter differs from a synchronous counter in how the flip-flops are clocked.

In a synchronous counter, all flip-flops receive the same clock signal.

In a ripple counter, the output of one flip-flop is connected to the clock input of the next flip-flop:

    count → FF0 → FF1 → FF2 → FF3

Because the clock signal propagates through the flip-flops sequentially, the circuit is called an asynchronous or ripple counter.

---

## Complement D Flip-Flop

The basic building block of this counter is a complementary D Flip-Flop.

The D input is internally configured so that:

    D = ~Q

Therefore, on the active clock edge:

    Q(next) = ~Q

This means the flip-flop toggles its output every time the active clock edge occurs.

A toggle flip-flop divides the frequency of its input clock by two.

The resulting frequency relationship between the counter stages is:

    A0 = count / 2
    A1 = count / 4
    A2 = count / 8
    A3 = count / 16

This frequency division produces the binary counting sequence.

---

## Counter Structure

The four flip-flops are connected in a ripple configuration.

The clock connections are:

    F0 clock = count
    F1 clock = A0
    F2 clock = A1
    F3 clock = A2

The overall structure is:

    count
      |
      v
    +----+       +----+       +----+       +----+
    | F0 | ----> | F1 | ----> | F2 | ----> | F3 |
    +----+       +----+       +----+       +----+
      |            |            |            |
      v            v            v            v
     A0           A1           A2           A3

Each stage divides the effective clock frequency by two.

---

## Counting Sequence

Starting from the reset state:

    A3 A2 A1 A0 = 0000

the counter progresses through:

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
    0000

The sequence repeats continuously while the counter is operating.

The least significant bit `A0` toggles most frequently, while each higher-order bit toggles at half the frequency of the preceding bit.

---

## Asynchronous Reset

The counter uses an active-high asynchronous reset.

When:

    reset = 1

all four flip-flops are immediately cleared:

    A3 A2 A1 A0 = 0000

The reset operation does not depend on the clock.

After:

    reset = 0

the counter resumes normal ripple-counting operation.

The reset signal is connected to all four flip-flops, allowing the complete counter to be initialized simultaneously.

---

## Design Description

The top-level module consists of four instances of the `Comp_D_flip_flop` component.

The stage connections are:

| Flip-Flop | Clock Source | Output |
|-----------|--------------|--------|
| F0 | `count` | `A0` |
| F1 | `A0` | `A1` |
| F2 | `A1` | `A2` |
| F3 | `A2` | `A3` |

Each flip-flop also receives the same asynchronous `reset` signal.

The `Comp_D_flip_flop` component toggles its stored value on the falling edge of its clock:

    falling edge of clk
        ↓
    Q(next) = ~Q

A propagation delay of 2 ns is included in the flip-flop model to represent the delay between a clock event and the resulting output transition.

---

## Ripple Propagation

One of the main characteristics of a ripple counter is that its state changes propagate through the individual stages rather than occurring simultaneously.

For example, during a transition such as:

    0111 → 1000

the lower-order flip-flops change first, and their outputs subsequently trigger the higher-order stages.

The propagation can be represented as:

    count
      ↓
     A0
      ↓
     A1
      ↓
     A2
      ↓
     A3

Because each stage has a propagation delay, the higher-order bits change slightly later than the lower-order bits.

This effect is visible in the simulation waveform and is an important characteristic of asynchronous counters.

---

## Hardware Structure

The synthesized circuit contains four flip-flop stages connected in cascade.

Each stage contains:

- A D Flip-Flop
- Feedback from `Q` to `D` through inversion
- An asynchronous clear connection

The resulting hardware structure is:

    +----------------+     +----------------+     +----------------+     +----------------+
    | Comp_D_FF F0   |     | Comp_D_FF F1   |     | Comp_D_FF F2   |     | Comp_D_FF F3   |
    |                |     |                |     |                |     |                |
    | clk = count    |---->| clk = A0      |---->| clk = A1      |---->| clk = A2      |
    | Q = A0         |     | Q = A1         |     | Q = A2         |     | Q = A3         |
    +----------------+     +----------------+     +----------------+     +----------------+

The synthesized RTL schematic clearly shows the cascading relationship between the four flip-flops.

---

## Synthesized Circuit

The synthesized circuit consists of:

- Four D Flip-Flops
- Four feedback paths that implement the toggle behavior
- A common asynchronous reset path
- A ripple clock connection between the stages

The first flip-flop receives the external `count` signal.

The output of each stage is used as the clock for the following stage.

This produces the characteristic hardware structure of an asynchronous ripple counter.

The synthesized circuit directly reflects the hierarchical structure of the VHDL implementation.

---

## Simulation

The testbench generates a periodic `count` signal with a 10 ns period.

The simulation verifies:

- Initial asynchronous reset
- Binary counting operation
- Cascaded ripple behavior
- Propagation delay between counter stages
- Reset during normal operation
- Continued counting after reset is released

The main signals observed are:

    count
    reset
    A0
    A1
    A2
    A3

The maximum simulation interval is limited to 160 ns.

---

## Simulation Verification

The simulation begins with the reset asserted.

The counter is initialized to:

    A3 A2 A1 A0 = 0000

After reset is released, the counter begins advancing according to the input clock.

The waveform shows the expected binary counting behavior:

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
    ...

The waveform also shows the difference in switching frequency between the individual counter bits.

The observed frequencies follow:

    A0 > A1 > A2 > A3

where each successive stage changes at approximately half the frequency of the previous stage.

---

## Ripple Delay Verification

The waveform demonstrates that the counter bits do not always change simultaneously.

When a transition propagates through the counter, each flip-flop responds after the preceding stage changes.

The 2 ns propagation delay included in the flip-flop model makes the ripple effect visible.

For example, when a transition requires multiple bits to change, the resulting waveform shows the changes propagating sequentially through:

    A0 → A1 → A2 → A3

This confirms the asynchronous nature of the counter.

---

## Reset Verification

The reset signal is asserted again during normal counting operation.

When:

    reset = 1

the counter immediately returns to:

    0000

The reset occurs independently of the clock, confirming that the reset is asynchronous.

After:

    reset = 0

the ripple counter resumes counting from the reset state.

---

## Waveform Interpretation

The simulation waveform demonstrates the relationship between the external clock and the cascaded counter outputs.

The signal `A0` changes most frequently because it is directly driven by the external `count` signal.

`A1` changes when `A0` provides the appropriate clock transition.

Similarly:

    A0 → A1 → A2 → A3

forms the ripple path through the counter.

The resulting four-bit output represents the binary count value.

The waveform also clearly demonstrates propagation delay between successive counter stages, which is a defining characteristic of ripple counters.

---

## Result

The 4-bit ripple counter was successfully implemented using four cascaded complementary D Flip-Flops.

Each flip-flop operates as a toggle element, and the output of each stage provides the clock for the next stage.

The counter correctly produces the binary sequence:

    0000 → 0001 → 0010 → ... → 1111 → 0000

The synthesized circuit confirms the expected cascaded flip-flop structure.

The simulation verifies:

- Binary counting
- Frequency division
- Asynchronous reset
- Ripple propagation
- Inter-stage propagation delay
- Correct four-bit output behavior

The implementation demonstrates the fundamental structure and timing characteristics of a 4-bit asynchronous ripple counter.