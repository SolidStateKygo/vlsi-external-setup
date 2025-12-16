#!/bin/bash

echo "=== Open-Source VLSI Toolchain Check (Ubuntu 22.04) ==="
echo "Date: $(date)"

# Helper function for OK/MISSING
check_cmd() {
    local tool=$1
    local ver_cmd=$2
    local install_cmd=$3
    if command -v "$tool" &> /dev/null; then
        echo "$tool: OK $("$ver_cmd" 2>&1 | head -n1 | cut -d' ' -f2-)"
    else
        echo "$tool: MISSING ($install_cmd)"
    fi
}

# Helper for Python packages
check_py_pkg() {
    local pkg=$1
    local install_cmd=$2
    if python3 -c "import $pkg" &> /dev/null; then
        echo "Python $pkg: OK"
    else
        echo "Python $pkg: MISSING ($install_cmd)"
    fi
}

# Tools
echo "== Installed Tools =="
check_cmd "sbt" "sbt --version" "sudo apt install sbt"  # For Chisel
check_cmd "iverilog" "iverilog -V" "sudo apt install iverilog"
check_cmd "vvp" "vvp -V" "sudo apt install iverilog"
check_cmd "yosys" "yosys -V" "sudo apt install yosys"
check_cmd "magic" "magic -version" "Built from source"
check_cmd "klayout" "klayout -v" "sudo apt install klayout"
check_cmd "gds3d" "gds3d" "Built from source"
check_cmd "xschem" "xschem -v" "Built from source"
check_cmd "ngspice" "ngspice -v" "Built from source"
check_cmd "gtkwave" "gtkwave -v" "sudo apt install gtkwave"
check_cmd "gaw" "gaw --version" "Built from source"

# Additions
echo "== Additional Tools =="
check_cmd "openlane" "openlane --help" "Inside Docker (Run 'make mount' in ~/OpenLane)"
check_cmd "netgen" "netgen -h" "sudo apt install netgen-lvs"

# Python packages
echo "== Python Packages =="
check_py_pkg "cocotb" "pip3 install cocotb"
check_py_pkg "numpy" "pip3 install numpy"
check_py_pkg "pyyaml" "pip3 install pyyaml"
check_py_pkg "click" "pip3 install click"

# PDK and Env
echo "== SkyWater PDK & Env =="
PDK_PATHS=("~/pdks" "~/skywater-pdk" "$HOME/OpenLane/pdks/sky130A" "/usr/local/pdks")
PDK_FOUND=false
for path in "${PDK_PATHS[@]}"; do
    eval expanded_path="$path"
    if [ -d "$expanded_path" ] && [ -d "$expanded_path/sky130A" ]; then
        echo "SkyWater PDK: OK at $expanded_path"
        PDK_FOUND=true
        break
    fi
done

echo "PDK_ROOT: ${PDK_ROOT:-NOT SET} (Check .bashrc)"
echo "OPENLANE_ROOT: ${OPENLANE_ROOT:-NOT SET} (Check .bashrc)"

echo "=== End Check ==="