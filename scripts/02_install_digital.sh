#!/bin/bash
set -e

echo "=== Phase 2: Installing Digital Tools (OpenLane & Verilog) ==="

# 1. Icarus Verilog & GTKWave & Yosys (via APT)
echo ">>> Installing Icarus Verilog, GTKWave, Yosys..."
sudo apt install -y iverilog gtkwave yosys klayout

# 2. Python Packages (Cocotb)
echo ">>> Installing Python Packages..."
pip3 install --user cocotb numpy pyyaml click pandas

# 3. OpenLane & PDK (The Heavy Install)
echo ">>> Installing OpenLane (This may take time)..."
cd $HOME

# Remove existing if present (to ensure clean install)
if [ -d "OpenLane" ]; then
    echo "Existing OpenLane found. backing up..."
    mv OpenLane OpenLane_backup_$(date +%s)
fi

git clone https://github.com/The-OpenROAD-Project/OpenLane.git
cd OpenLane

echo ">>> Pulling Docker Image..."
make

echo ">>> Installing Sky130 PDK (Downloading ~20GB)..."
make pdk

# 4. Environment Variables
echo ">>> Updating .bashrc..."
if ! grep -q "OPENLANE_ROOT" ~/.bashrc; then
    echo "" >> ~/.bashrc
    echo "# --- VLSI Environment Variables ---" >> ~/.bashrc
    echo "export PDK_ROOT=\$HOME/OpenLane/pdks" >> ~/.bashrc
    echo "export PDK=sky130A" >> ~/.bashrc
    echo "export OPENLANE_ROOT=\$HOME/OpenLane" >> ~/.bashrc
    echo "export PATH=\$PATH:\$HOME/.local/bin" >> ~/.bashrc
fi

echo "=== Digital Tools Installed. Please restart your terminal. ==="