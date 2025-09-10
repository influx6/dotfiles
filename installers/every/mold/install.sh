#!/bin/bash

git clone --branch stable https://github.com/rui314/mold.git
cd mold
./install-build-deps.sh
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=c++ -B build
cmake --build build -j$(nproc)
cmake --build build --target install
