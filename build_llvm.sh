#!/bin/bash

OSNAME=xomb
NCPU=4

BINUTILS_VER=2.20
GCC_VER=4.5.0
GMP_VER=5.0.1
MPFR_VER=2.4.2
NEWLIB_VER=1.18.0
MPC_VER=0.8.1
LLVM_VER=2.8

export TARGET=x86_64-pc-${OSNAME}
export PREFIX=`pwd`/local

mkdir -p build
mkdir -p local
cd build

WFLAGS=-c

export PATH=$PREFIX/bin:$PATH


echo "FETCH LLVM"
wget $WFLAGS http://llvm.org/releases/2.8/llvm-$LLVM_VER.tgz
tar -xf llvm-$LLVM_VER.tgz

echo "PATCH LLVM"
patch -p1 -d llvm-$LLVM_VER < ../llvm.patch 

echo "BUILD LLVM"
mkdir -p llvm-obj
cd llvm-obj
../llvm-$LLVM_VER/configure --build=x86_64-unknown-linux-gnu --host=x86_64-pc-xomb --enable-optimized --enable-targets=x86 --prefix=$PREFIX
make
