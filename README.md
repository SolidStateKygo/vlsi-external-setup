# Portable Chip Design Toolchain on WSL

This repository documents how to migrate a **WSL (Ubuntu 22.04)** and **Docker** environment to an external hard drive (e.g., Drive `E:`) and install a complete Open-Source Chip Design (VLSI) toolchain.

This setup allows you to run heavy EDA tools (OpenLane, Magic, Ngspice, etc.) and store massive PDKs (SkyWater 130) on an external drive, saving space on your main machine.

## 📂 Repository Structure

- **`docs/`**: Step-by-step guides for moving your OS to the external drive.
    
- **`scripts/`**: Automated scripts to install the toolchain.
    

## 🚀 Getting Started

### Phase 1: Migration (One-Time Setup)

Before installing tools, you must move your Linux subsystem to the external drive.

1. **Migration Guide**: Move Ubuntu and Docker data to External Drive (`E:`).
    
2. **User Setup Guide**: Fix root login and permissions after migration.
    

### Phase 2: Installation

Once you are running Ubuntu from your external drive (verified via `wsl -d Ubuntu`), run these scripts inside your Ubuntu terminal.

**1. Install Dependencies** Installs all system libraries, graphics drivers, and build tools.

```
chmod +x scripts/01_install_dependencies.sh
./scripts/01_install_dependencies.sh
```

**2. Install Digital Tools (OpenLane & Verilog)** Installs OpenLane (Docker-based), Icarus Verilog, GTKWave, and Cocotb.

```
chmod +x scripts/02_install_digital.sh
./scripts/02_install_digital.sh
```

_Note: This step downloads the Sky130 PDK and may take 30+ minutes._

**3. Install Analog Tools (Source Build)** Compiles Magic, Xschem, Ngspice, GAW, and GDS3D from source.

```
chmod +x scripts/03_install_analog.sh
./scripts/03_install_analog.sh
```

### Phase 3: Verification

Run the verification script to ensure all tools are detected and working.

```
chmod +x scripts/verify_setup.sh
./scripts/verify_setup.sh
```

## 🛠️ Included Tools

|Category|Tools|
|---|---|
|**Digital Backend**|OpenLane (OpenROAD, Yosys, KLayout, Magic)|
|**Simulation**|Icarus Verilog, GTKWave, Cocotb, Ngspice|
|**Analog/Layout**|Xschem, Magic VLSI, Netgen, GDS3D|
|**Integration**|SkyWater 130nm PDK|