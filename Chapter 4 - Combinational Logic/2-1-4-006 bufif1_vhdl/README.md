# BUFIF1 and NOTIF1 VHDL Implementation and Simulation

## 📌 Project Overview

This project implements and verifies the following digital logic components using VHDL:

- **BUFIF1** (3-State Buffer, Active-High Enable)
- **NOTIF1** (Inverter with 3-State Output, Active-High Enable)

Functional verification was performed using ModelSim after synthesis in Quartus Prime.

---

## 🧩 Design Description

### 1️⃣ BUFIF1

The buffer transfers the input to the output when the control (enable) signal is `'1'`.  
When the control signal is `'0'`, the output enters a High-Impedance (`'Z'`) state.

**Behavioral Expression:**

```
buf_out <= buf_in when control = '1' else 'Z';
```

---

### 2️⃣ NOTIF1

The inverter outputs the inverted input when the control signal is `'1'`.  
When the control signal is `'0'`, the output enters a High-Impedance (`'Z'`) state.

**Behavioral Expression:**

```
not_out <= not(not_in) when control = '1' else 'Z';
```

---

## ⚙️ Design Environment

- Quartus Prime 15.1 Lite Edition
- ModelSim ALTERA 10.4b
- VHDL-93 Standard
- Library: `ieee.std_logic_1164`

---

## 🏗 RTL Structure

From the RTL Viewer:

- `control` → Output Enable (OE)
- `buf_in` → Data Input
- `buf_out` → Output

Note:  
FPGAs do not implement internal tri-state buffers. During synthesis, the tri-state logic is converted into a multiplexer-based structure.

---

## 🧪 Simulation Results

### ✔ BUFIF1 Truth Table

| control | buf_in | buf_out |
|----------|--------|----------|
| 0 | X | Z |
| 1 | 0 | 0 |
| 1 | 1 | 1 |

---

### ✔ NOTIF1 Truth Table

| control | not_in | not_out |
|----------|--------|----------|
| 0 | X | Z |
| 1 | 0 | 1 |
| 1 | 1 | 0 |

Waveform analysis confirms:

- Output is active only when `control = '1'`
- Output remains in High-Impedance (`'Z'`) when `control = '0'`

---

## ⚠️ Errors Encountered and Solutions

### 1️⃣ std_logic Not Declared

**Cause:**
Missing IEEE library declaration.

**Solution:**
```
library ieee;
use ieee.std_logic_1164.all;
```

---

### 2️⃣ 'z' Character Error

**Cause:**
Lowercase `'z'` is not defined in `std_logic`.

**Solution:**
Use uppercase `'Z'`.

---

### 3️⃣ ModelSim vsim-3170 Error

**Cause:**
Mismatch between testbench entity name and `.do` file execution name.

**Solution:**
Ensure the correct entity name is used:
```
vsim tb_bufif1_notif1
```

---

## ✅ Conclusion

- Always use uppercase `'Z'` for High-Impedance in VHDL.
- Internal tri-state logic in FPGA is synthesized into multiplexers.
- Ensure entity names match when running ModelSim simulations.

---

## 👨‍💻 Author

Digital Logic Circuit Laboratory  
VHDL Dataflow Modeling Practice
