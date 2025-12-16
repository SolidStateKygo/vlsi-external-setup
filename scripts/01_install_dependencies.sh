#!/bin/bash
set -e

echo "=== Phase 1: Installing System Dependencies ==="

# Update Repositories
sudo apt update && sudo apt upgrade -y

# 1. Essential Build Tools
echo ">>> Installing Build Tools..."
sudo apt install -y build-essential git cmake python3 python3-pip python3-venv \
    autoconf automake libtool flex bison gperf

# 2. Graphics & UI Libraries (Crucial for Magic, Xschem, GDS3D)
# Fixes 'GL/glx.h' and 'Xaw' errors
echo ">>> Installing Graphics Libraries..."
sudo apt install -y libx11-dev libx11-xcb-dev libxrender-dev libxext-dev \
    libxaw7-dev libgtk-3-dev libcairo2-dev libglu1-mesa-dev \
    mesa-common-dev libgl1-mesa-dev

# 3. Scripting & Misc Libraries
echo ">>> Installing Tcl/Tk and Helpers..."
sudo apt install -y tcl-dev tk-dev libcairo2-dev libreadline-dev \
    csh tcsh libxpm-dev

echo "=== System Dependencies Installed Successfully ==="