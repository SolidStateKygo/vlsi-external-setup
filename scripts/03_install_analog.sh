#!/bin/bash
set -e

echo "=== Phase 3: Installing Analog Tools (Source Builds) ==="
mkdir -p $HOME/tools
cd $HOME/tools

# 1. Magic VLSI
echo ">>> compiling Magic..."
if [ -d "magic" ]; then sudo rm -rf magic; fi
git clone https://github.com/RTimothyEdwards/magic
cd magic
./configure
make
sudo make install
cd ..

# 2. Xschem
echo ">>> Compiling Xschem..."
if [ -d "xschem" ]; then sudo rm -rf xschem; fi
git clone https://github.com/StefanSchippers/xschem.git
cd xschem
./configure
make
sudo make install
cd ..

# 3. Ngspice
echo ">>> Compiling Ngspice..."
if [ -d "ngspice_git" ]; then sudo rm -rf ngspice_git; fi
git clone https://git.code.sf.net/p/ngspice/ngspice.git ngspice_git
cd ngspice_git
./autogen.sh
mkdir release && cd release
../configure --with-x --enable-xspice --disable-debug --enable-cider --with-readline=yes --enable-openmp
make -j$(nproc)
sudo make install
cd ../..

# 4. GAW (Waveform Viewer)
# Note: Using GitHub mirror as tuxfamily often times out
echo ">>> Compiling GAW..."
if [ -d "xschem-gaw" ]; then sudo rm -rf xschem-gaw; fi
git clone https://github.com/StefanSchippers/xschem-gaw.git
cd xschem-gaw
./configure
make -j$(nproc)
sudo make install
cd ..

# 5. GDS3D (3D Viewer)
echo ">>> Compiling GDS3D..."
if [ -d "GDS3D" ]; then sudo rm -rf GDS3D; fi
git clone https://github.com/trilomix/GDS3D.git
cd GDS3D
make -C linux
# Install binary to system path for easy access
sudo cp linux/GDS3D /usr/local/bin/gds3d
cd ..

echo "=== Analog Tools Installed Successfully ==="