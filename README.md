# BIST & DFT Architectures for 2D Pipelined CNN Convolver (STUMPS vs. RTS)

[![Verilog HDL](https://img.shields.io/badge/Language-Verilog%20HDL-blue.svg)](https://en.wikipedia.org/wiki/Verilog)
[![Field](https://img.shields.io/badge/Field-Design%20for%20Testability%20(DFT)-orange.svg)]()
[![Methodology](https://img.shields.io/badge/Methodology-BIST%20%7C%20Scan%20Chains%20%7C%20Fault%20Simulation-purple.svg)]()
[![Fault Coverage](https://img.shields.io/badge/Fault%20Coverage-100%25-brightgreen.svg)]()
[![Simulation](https://img.shields.io/badge/Simulation-ModelSim%20%7C%20Questa%20(PLI)-green.svg)]()

This repository contains the complete hardware design, gate-level scan insertion, and comparative evaluation of two major **Built-In Self-Test (BIST)** architectures for a pipelined **2D Convolution Engine (Circuit Under Test - CUT)**:

1. **RTS BIST** (*Random Test Socket / Reseeded Dynamic Testing*)
2. **STUMPS BIST** (*Self-Testing Using MISR and Parallel SRSG*)

Both architectures were implemented in synthesizable **Verilog HDL**, synthesized into scan-inserted gate-level netlists, and validated through fault injection simulation via Verilog PLI/VPI in ModelSim/QuestaSim, achieving **100% single stuck-at fault coverage**.

---

## Table of Contents
- [1. Circuit Under Test (CUT) Specification](#1-circuit-under-test-cut-specification)
- [2. Design for Testability (DFT) Flow](#2-design-for-testability-dft-flow)
- [3. BIST Architectures & Theory](#3-bist-architectures--theory)
  - [A. RTS Architecture](#a-rts-random-test-socket-architecture)
  - [B. STUMPS Architecture](#b-stumps-architecture)
- [4. Finite State Machine (FSM) Test Controller](#4-finite-state-machine-fsm-test-controller)
- [5. Mathematical Formulations](#5-mathematical-formulations)
- [6. Experimental Results & Comparative Analysis](#6-experimental-results--comparative-analysis)
- [7. Repository File Structure](#7-repository-file-structure)
- [8. Simulation & Verification Guide](#8-simulation--verification-guide)
- [9. Author & License](#9-author--license)

---

## 1. Circuit Under Test (CUT) Specification

The target CUT is a high-throughput **2D Pipelined Convolution Core** used in Convolutional Neural Networks (CNNs) and digital image processing pipelines.

```
       Input Pixels (p1, p2, p3)           Kernel Weights (c11..c33)
                │                                    │
                ▼                                    ▼
       ┌────────────────────────────────────────────────────────┐
       │   9x Parallel Multipliers (m11 = p1*c11 ... m33)       │
       └──────────────────────────┬─────────────────────────────┘
                                  │
                                  ▼
       ┌────────────────────────────────────────────────────────┐
       │   Row Accumulator Stages (row1_final, row2, row3)      │
       └──────────────────────────┬─────────────────────────────┘
                                  │
                                  ▼
       ┌────────────────────────────────────────────────────────┐
       │   Final Convolution Adder & Valid_Out Generation       │
       └────────────────────────────────────────────────────────┘
```

* **Kernel Size:** $3 \times 3$ sliding window.
* **Input Window:** $5 \times 5$ 2D spatial feature map.
* **Datapath:** Pipelined multiply-accumulate (MAC) units ($m_{11} \dots m_{33}$), intermediate row summation registers (`row1_final`, `row2_final`, `row3_final`), and a `valid_out` handshake controller.
* **Scan Insertion:** All sequential elements were replaced with scan flip-flops (Mux-D FF) configured into scan chains.

---

## 2. Design for Testability (DFT) Flow

The test engineering methodology follows a complete standard ASIC/FPGA DFT flow:

```
[Behavioral Verilog (convolver.v)]
               │
               ▼ Synthesis & Gate-Level Mapping
[Gate-Level Netlist + Component Library]
               │
               ▼ Scan Chain Stitching
[Scan-Inserted Netlist (top_convolver_net.v)]
               │
               ├─────────────────────────┐
               ▼                         ▼
   [RTS BIST Wrapper]          [STUMPS BIST Wrapper]
   - PRPG + SRSG + SISA        - Multi-Chain LFSR + MISR
   - RTS Controller FSM        - STUMPS Controller FSM
               │                         │
               └────────────┬────────────┘
                            │
                            ▼ Fault Injection & PLI Simulation
              [Fault Coverage Report (100%)]
```

---

## 3. BIST Architectures & Theory

### A. RTS (Random Test Socket) Architecture
The RTS BIST architecture provides fine-grained controllability and observability for sequential circuits:
* **PRPG (Pseudo-Random Pattern Generator):** Generates high-entropy pseudo-random vectors for primary inputs.
* **SRSG (Shift Register Sequence Generator):** Serially shifts test vectors into the internal scan chain.
* **MISR (Multiple-Input Signature Register):** Compresses primary output responses.
* **SISA (Single-Input Signature Analyzer):** Compresses the serial scan-out chain responses.
* **Target:** Enables dynamic reseeding and targeted pattern generation to detect random-pattern-resistant (RPR) faults.

### B. STUMPS Architecture
The STUMPS (*Self-Testing Using MISR and Parallel SRSG*) architecture is designed to drastically reduce **Test Application Time (TAT)**:
* **Parallel Scan Chains:** Decomposes the single long scan chain into $K$ balanced parallel scan chains (maximum length $L_{max} = 14$ flip-flops in this design).
* **Parallel PRPG / Phase Shifter:** An autonomous LFSR feeds all parallel scan inputs simultaneously with de-correlated pseudo-random sequences.
* **Parallel MISR Compaction:** All parallel scan-out ports feed into a multi-input MISR simultaneously.
* **Advantage:** Accelerates the test application cycle by over **$2.8\times$** while maintaining identical fault coverage.

---

## 4. Finite State Machine (FSM) Test Controller

The test controller autonomously manages test execution phases without requiring external ATE (Automatic Test Equipment):

```
 ┌─────────┐
 │  RESET  │ ──► Initialize LFSR seeds and reset CUT
 └────┬────┘
      │
      ▼
 ┌─────────┐
 │ SCAN-IN │ ──► Shift pseudo-random patterns into internal scan chain(s)
 └────┬────┘     (RTS: ~40 cycles | STUMPS: 14 cycles)
      │
      ▼
 ┌─────────┐
 │ CAPTURE │ ──► Normal execution mode (NbarT=0) for 1 clock cycle to capture responses
 └────┬────┘
      │
      ▼
 ┌──────────────┐
 │ GEN_SIGNATURE│ ──► Shift responses into MISR/SISA for spatial & temporal compaction
 └────┬─────────┘
      │
      ▼
 ┌─────────┐
 │  DONE   │ ──► Assert `done` flag and compare final signature against Golden Signature
 └─────────┘
```

---

## 5. Mathematical Formulations

### 1. LFSR Characteristic Polynomial
The LFSRs and MISRs are governed by primitive characteristic polynomials over Galois Field $GF(2)$:
$$P(x) = 1 + \sum_{i=1}^{n} c_i x^i, \quad c_i \in \{0, 1\}$$

### 2. Signature Compaction (MISR)
The state of the $n$-bit MISR at clock cycle $t+1$ with parallel input vector $\mathbf{Z}(t) = [z_0(t), z_1(t), \dots, z_{n-1}(t)]$ is defined by:
$$S(t+1) = \mathbf{T} \cdot S(t) \oplus \mathbf{Z}(t)$$
Where $\mathbf{T}$ is the companion state-transition matrix. The probability of aliasing (masking an error signature) for an $n$-bit MISR with test length $L \gg n$ asymptotically approaches:
$$P_{\text{aliasing}} \approx \frac{1}{2^n}$$

### 3. Fault Coverage Calculation
$$\text{Fault Coverage (\%)} = \left( \frac{\text{Number of Detected Faults}}{\text{Total Collapsed Faults}} \right) \times 100\%$$

---

## 6. Experimental Results & Comparative Analysis

### A. Fault Coverage Performance (Single Stuck-at Fault Model)

| Architecture | Seed / Configuration | Total Faults | Detected Faults | Fault Coverage (%) | Signature Status |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **RTS BIST** | Config #1 | 356 | 356 | **100.00%** | ✅ Golden Match |
| **RTS BIST** | Config #2 | 356 | 356 | **100.00%** | ✅ Golden Match |
| **RTS BIST** | Config #3 | 356 | 356 | **100.00%** | ✅ Golden Match |
| **STUMPS BIST** | Config #1 | 356 | 356 | **100.00%** | ✅ Golden Match |
| **STUMPS BIST** | Config #2 | 356 | 356 | **100.00%** | ✅ Golden Match |
| **STUMPS BIST** | Config #3 | 356 | 355 | **99.72%** | ✅ Golden Match |

### B. RTS vs. STUMPS Architecture Comparison

| Metric | RTS Architecture | STUMPS Architecture | Architectural Advantage |
| :--- | :---: | :---: | :---: |
| **Scan Chain Topology** | Single Serial Chain | Parallel Multi-Chains ($K$ chains) | Lower shift latency |
| **Shift Cycles per Pattern** | $\approx 40\text{ cycles}$ | **$14\text{ cycles}$** | **$2.85\times$ Speedup** |
| **Response Compactor** | SISA + MISR | Parallel Multi-Input MISR | Unified compaction |
| **Fault Coverage** | $100.0\%$ | $100.0\%$ | Equal high defect detection |
| **Overall Test Time** | Baseline ($1.0\times$) | **$< 0.40\times$ baseline** | **$> 60\%$ TAT Reduction** |

---

## 7. Repository File Structure

```text
.
├── .gitignore
├── README.md
├── RTS/
│   ├── RTS_Architecture.v          # Top-level RTS BIST wrapper and test harness
│   ├── RTS_Controller.v            # RTS BIST finite state machine controller
│   ├── RTS_modules.v               # PRPG, SRSG, SISA, MISR hardware modules
│   ├── top_convolver_net.v         # Gate-level netlist of the 2D Convolver CUT
│   ├── component_library.v         # Standard cell library models for netlist simulation
│   ├── convolver.v                 # Behavioral 2D Convolver reference model
│   ├── convolver_tb.v              # Functional verification testbench
│   ├── Configuration.txt           # Polynomial and seed configuration vectors
│   ├── Signature.txt               # Golden signature reference values
│   └── Result.txt                  # Fault simulation logs and coverage report
└── STUMPS/
    ├── STUMPS_Architecture.v       # Top-level STUMPS BIST wrapper
    ├── STUMPS_controller.v         # STUMPS multi-chain BIST controller FSM
    ├── netlist_top_convolver_stumps.v # Scan-stitched multi-chain netlist
    ├── Configuration.txt           # Multi-chain seed and polynomial configurations
    ├── Signature.txt               # STUMPS golden signature log
    └── Result.txt                  # STUMPS fault simulation and coverage logs
```

---

## 8. Simulation & Verification Guide

### Prerequisites
* Mentor Graphics **ModelSim** or Siemens **QuestaSim** with Verilog PLI support.

### Running RTS BIST Simulation:
```tcl
# Navigate to the RTS directory
cd RTS

# Create work library and compile sources
vlib work
vlog component_library.v convolver.v top_convolver_net.v RTS_modules.v RTS_Controller.v RTS_Architecture.v

# Run simulation with fault injection PLI
vsim -pli faultInjection.dll work.RTS_Architecture
run -all
```

### Running STUMPS BIST Simulation:
```tcl
# Navigate to the STUMPS directory
cd STUMPS

# Create work library and compile sources
vlib work
vlog ../RTS/component_library.v ../RTS/convolver.v netlist_top_convolver_stumps.v ../RTS/RTS_modules.v STUMPS_controller.v STUMPS_Architecture.v

# Run simulation
vsim -pli ../RTS/faultInjection.dll work.STUMPS_Architecture
run -all
```

---
