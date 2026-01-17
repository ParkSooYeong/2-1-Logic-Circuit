# AND_OR_PROP_DELAY_VHDL (Component-Based Structural Modeling)

## Description
This project is an example of **structural modeling in VHDL using components**.  
Basic logic gates are implemented as independent components and then interconnected in a top-level entity to form a complete circuit.

The logical behavior of the circuit is defined as follows:

- w1 = A AND B  
- E  = NOT C  
- D  = w1 OR E  

Each logic gate includes a propagation delay to model realistic timing behavior.

- AND gate : 30 ns  
- NOT gate : 10 ns  
- OR gate  : 20 ns  

---

## Files
- `and2_gate.vhd`  
  : 2-input AND gate component (30 ns propagation delay)

- `or2_gate.vhd`  
  : 2-input OR gate component (20 ns propagation delay)

- `inv_gate.vhd`  
  : Inverter (NOT gate) component (10 ns propagation delay)

- `and_or_prop_delay_vhdl.vhd`  
  : Top-level entity using component-based structural modeling

- `and_or_prop_delay_vhdl_tb.vhd`  
  : Testbench for functional and timing simulation

- `and_or_prop_delay_vhdl.pdf`  
  : RTL schematic and simulation waveform results

---

## Design Method
- Structural modeling using VHDL components
- Explicit component declarations and instantiations
- Signal-based interconnection (`w1`)
- Propagation delays modeled using the `after` keyword

---

## Tools
- Quartus Prime Lite (Analysis & Synthesis)
- ModelSim-Altera (Simulation)

---

## Simulation Results
The simulation waveform verifies:

- Correct logical operation of the AND, NOT, and OR gates
- Clearly observable propagation delays for each gate
- Proper signal flow:
  - A, B → w1 (AND)
  - C → E (NOT)
  - w1, E → D (OR)

The structural hierarchy and timing behavior match the intended circuit design.

---

## Notes
- Component port declarations must exactly match the corresponding entity definitions.
- Either positional or named port mapping may be used, but consistency is important.
- This design demonstrates reusable, component-based VHDL structural modeling.
