# 4-bit Ripple Counter

## Overview

This project implements a 4-bit asynchronous ripple counter using four cascaded D Flip-Flops.

Unlike a synchronous counter, where all flip-flops receive the same clock signal, a ripple counter uses the output of one flip-flop as the clock input of the next flip-flop. As a result, state changes propagate sequentially through the register.

The counter has:

- A clock input `count`
- An active-high asynchronous reset `reset`
- Four outputs `A0`, `A1`, `A2`, and `A3`

The four outputs represent the current 4-bit counter value.

---

## Theory

A binary counter is a sequential circuit that progresses through a sequence of binary values in response to clock pulses.

A 4-bit binary counter can represent 16 states:

    0000 → 0001 → 0010 → 0011 → ... → 1110 → 1111 → 0000

A ripple counter is an asynchronous counter in which the clock signal does not drive all flip-flops simultaneously.

Instead, the clocking relationship is:

    count → F0 → F1 → F2 → F3

The output of each flip-flop becomes the clock input of the next flip-flop.

Because each flip-flop must wait for the previous stage to change, the state transition propagates through the circuit like a ripple. This produces a propagation delay between the individual bit transitions.

---

## Ripple Counter Structure

The counter is constructed from four identical D Flip-Flop components.

The connection structure is:

    count → F0 → A0
               |
               v
               F1 → A1
                    |
                    v
                    F2 → A2
                         |
                         v
                         F3 → A3

The first flip-flop receives the external `count` signal as its clock.

The following flip-flops use the previous stage output as their clock:

    F0 clock = count
    F1 clock = A0
    F2 clock = A1
    F3 clock = A2

Each flip-flop toggles whenever its clock experiences the specified active edge.

---

## D Flip-Flop as a Toggle Element

The component used in the counter is a D Flip-Flop whose D input is connected to the inverted current output.

Conceptually:

    D = ~Q

Therefore, whenever the active clock edge occurs:

    Q(next) = ~Q

This makes the D Flip-Flop operate as a toggle element.

Each stage therefore divides the effective frequency of its input clock by two.

The resulting frequency relationship is:

    A0 = count / 2
    A1 = count / 4
    A2 = count / 8
    A3 = count / 16

This frequency division produces the binary counting sequence.

---

## Counting Sequence

Starting from `0000`, the counter progresses through:

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
    ...

The least significant bit `A0` changes most frequently, while `A3` changes least frequently.

Each higher-order bit therefore represents a progressively divided clock frequency.

---

## Asynchronous Reset

The counter uses an active-high asynchronous reset.

When:

    reset = 1

all four flip-flops are immediately cleared:

    A3 A2 A1 A0 = 0000

The reset operation does not wait for a clock transition.

When:

    reset = 0

the counter resumes normal ripple-counting operation.

The asynchronous reset is connected to every flip-flop so that the entire counter can be reset simultaneously.

---

## Design Description

The top-level module `Ripple_Counter_4bit` instantiates four `Comp_D_flip_flop` components.

The connections are:

| Flip-Flop | Clock Input | Output |
|-----------|-------------|--------|
| F0 | `count` | `A0` |
| F1 | `A0` | `A1` |
| F2 | `A1` | `A2` |
| F3 | `A2` | `A3` |

Every flip-flop receives the same asynchronous `reset` signal.

The internal D Flip-Flop is designed so that its output toggles whenever its clock experiences a falling edge:

    Q(next) = ~Q

This creates a divide-by-two function at each stage.

---

## Component Behavior

### Comp_D_flip_flop

The flip-flop contains:

- `clk` : Clock input
- `reset` : Active-high asynchronous reset
- `Q` : Stored output

Its behavior is:

    reset = 1
        → Q = 0

    reset = 0 and falling edge of clk
        → Q = ~Q

A small propagation delay is included in the flip-flop model to represent the time required for the output to change after the clock event.

This delay is especially important in a ripple counter because the delay accumulates as the transition propagates through the four stages.

---

## Timing Behavior

Unlike a synchronous counter, the four output bits do not necessarily change at exactly the same time.

When the first flip-flop changes state, its output becomes the clock for the second flip-flop.

The second flip-flop then changes after its propagation delay, causing the same process to continue through the third and fourth stages.

Conceptually:

    count changes
        ↓
    A0 changes
        ↓
    A1 changes
        ↓
    A2 changes
        ↓
    A3 changes

This sequential propagation is the defining timing characteristic of a ripple counter.

---

## Synthesized Circuit

The synthesized circuit contains four cascaded `Comp_D_flip_flop` blocks.

The RTL schematic shows:

- Four D Flip-Flops
- A common asynchronous reset connection
- `count` connected to the clock of the first flip-flop
- `A0` connected to the clock of the second flip-flop
- `A1` connected to the clock of the third flip-flop
- `A2` connected to the clock of the fourth flip-flop

The feedback connection inside each flip-flop creates the toggle behavior.

The synthesized hardware therefore directly reflects the ripple-counter structure described by the HDL.

---

## Simulation

The testbench generates a periodic `count` signal and applies an asynchronous reset before normal counting begins.

The primary signals observed in the simulation are:

    count
    reset
    A0
    A1
    A2
    A3

The simulation is designed to observe both the binary counting sequence and the propagation delay between the individual counter bits.

---

## Simulation Verification

The simulation begins with the reset asserted:

    reset = 1

This initializes all counter outputs to:

    A3 A2 A1 A0 = 0000

After the reset is released, the counter begins to advance in response to the `count` signal.

The waveform demonstrates the binary sequence:

    0000
    0001
    0010
    0011
    0100
    0101
    0110
    0111
    1000
    ...

The least significant bit `A0` changes at every effective counter transition.

`A1`, `A2`, and `A3` change progressively less frequently because each stage is clocked by the output of the previous stage.

---

## Ripple Propagation Delay

The simulation also demonstrates the propagation behavior inherent to the ripple-counter architecture.

When a transition propagates through the counter, the individual bits do not change simultaneously.

For example, during a transition such as:

    0111 → 1000

the output bits must change sequentially:

    A0: 1 → 0
    A1: 1 → 0
    A2: 1 → 0
    A3: 0 → 1

Because each stage is triggered by the preceding stage and includes propagation delay, these changes occur one after another.

The waveform therefore provides a visual representation of the ripple effect.

---

## Reset Verification

The simulation also applies the reset signal during normal operation.

When:

    reset = 1

the counter immediately returns to:

    A3 A2 A1 A0 = 0000

The reset operation occurs independently of the `count` signal, confirming the asynchronous nature of the reset.

After the reset is released, the counter resumes its normal counting sequence.

---

## Waveform Interpretation

The simulation waveform contains four output signals representing the binary counter value:

    A3 A2 A1 A0

The outputs form a binary counting sequence, with `A0` representing the least significant bit and `A3` representing the most significant bit.

The waveform also shows that:

- `A0` toggles most frequently.
- `A1` toggles at half the frequency of `A0`.
- `A2` toggles at half the frequency of `A1`.
- `A3` toggles at half the frequency of `A2`.
- Reset immediately forces all outputs to zero.
- Output transitions propagate from the lower-order bit toward the higher-order bit.

This behavior is consistent with the structure of an asynchronous ripple counter.

---

## Result

The 4-bit ripple counter was successfully implemented using four cascaded D Flip-Flops configured as toggle elements.

The counter generates the expected 4-bit binary sequence from `0000` through `1111` and then wraps back to `0000`.

The synthesized circuit confirms the cascaded flip-flop structure, while the simulation verifies both binary counting and the propagation behavior associated with an asynchronous ripple counter.

The design demonstrates the fundamental operation of ripple counters, including frequency division, asynchronous reset, binary state progression, and cumulative propagation delay through cascaded sequential elements.
