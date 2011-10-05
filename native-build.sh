
source scripts/functions.sh

# --- Variables ---

source scripts/nativevars.sh


# --- Directory creation ---

mkdir -p build
mkdir -p $PREFIX
cd build

setphase "MAKE OBJECT DIRECTORIES"
mkdir -p binutils-obj
mkdir -p gcc-obj
mkdir -p newlib-obj
mkdir -p gmp-obj
mkdir -p mpfr-obj
mkdir -p mpc-obj
if [ $EXTRAS -eq 1 ]; then
mkdir -p ppl-obj
mkdir -p cloog-obj
fi

# --- Fetch and extract each package ---
source ../scripts/fetchandpatch.sh


# --- Compile all packages ---

# relevant thread for building static bin utils (and dealing with ppl :)
# http://sources.redhat.com/ml/binutils/2011-08/msg00182.html
setphase "COMPILE _static_ BINUTILS"
cd binutils-obj
#--enable-plugins:  Building BFD with plugin support requires a host that supports -ldl.
../binutils-${BINUTILS_VER}/configure $CROSSCONFIG --enable-gold --disable-werror || exit
make configure-host || exit
make -j$NCPU all-gold LDFLAGS="-all-static $SHAREDLDFLAGS" || exit
make -j$NCPU LDFLAGS="-all-static $SHAREDLDFLAGS" || exit
make install || exit
cd ..

setphase "COMPILE GMP"
cd gmp-obj
../gmp-${GMP_VER}/configure $CROSSCONFIG --enable-cxx --disable-shared || exit
make -j$NCPU || exit
if [ $NOTEST -ne 1 ]; then
		make check || exit
fi
make install || exit
cd ..

setphase "COMPILE MPFR"
cd mpfr-obj
../mpfr-${MPFR_VER}/configure $CROSSCONFIG --with-gmp=$PREFIX --disable-shared || exit
make -j$NCPU || exit
if [ $NOTEST -ne 1 ]; then
		make check || exit
fi
make install || exit
cd ..

setphase "COMPILE MPC"
cd mpc-obj
../mpc-${MPC_VER}/configure $CROSSCONFIG --with-gmp=$PREFIX --with-mpfr=$PREFIX --disable-shared || exit
make -j$NCPU || exit
if [ $NOTEST -ne 1 ]; then
		make check || exit
fi
make install || exit
cd ..

if [ $EXTRAS -eq 1 ]; then
setphase "COMPILE PPL"
cd ppl-obj
../ppl-${PPL_VER}/configure $CROSSCONFIG --with-gmp-prefix=$PREFIX --disable-shared || exit
make -j$NCPU || exit
if [ $NOTEST -ne 1 ]; then
		make check || exit
fi
make install || exit
cd ..

setphase "COMPILE CLOOG"
cd cloog-obj
../cloog-${CLOOG_VER}/configure $CROSSCONFIG --with-gmp-prefix=$PREFIX --disable-shared || exit
make -j$NCPU || exit
if [ $NOTEST -ne 1 ]; then
		make check || exit
fi
make install || exit
cd ..
fi

setphase "AUTOCONF GCC"
cd gcc-${GCC_VER}/libstdc++-v3
#autoreconf || exit
#autoconf || exit
cd ../..

setphase "COMPILE GCC"
cd gcc-obj
../gcc-${GCC_VER}/configure $CROSSCONFIG --enable-languages=c,c++ --disable-libssp --with-gmp=$PREFIX --with-mpfr=$PREFIX --with-mpc=$PREFIX  --with-ppl=$PREFIX --enable-cloog-backend=isl --disable-nls --with-newlib  --without-headers --disable-shared || exit
#--with-cloog=$PREFIX
make -j$NCPU all-gcc LDFLAGS="$LDFLAGS" || exit
make install-gcc LDFLAGS="$LDFLAGS" || exit
cd ..

setphase "AUTOCONF NEWLIB-XOMB"
cd newlib-${NEWLIB_VER}/newlib/libc/sys
autoconf || exit
cd ${OSNAME}
autoreconf || exit
cd ../../../../..

setphase "CONFIGURE NEWLIB"
cp ../newlib-files/syscalls.c newlib-${NEWLIB_VER}/newlib/libc/sys/${OSNAME}/syscalls.c
cd newlib-obj
../newlib-${NEWLIB_VER}/configure $CROSSCONFIG --target=$TARGET --with-gmp=$PREFIX --with-mpfr=$PREFIX -enable-newlib-hw-fp || exit

setphase "COMPILE NEWLIB"
make -j$NCPU || exit
make install || exit
cd ..

setphase "PASS-2 COMPILE GCC"
cd gcc-obj
#make all-target-libgcc
#make install-target-libgcc
make -j$NCPU all-target-libstdc++-v3 LDFLAGS="$LDFLAGS" || exit
make install-target-libstdc++-v3 LDFLAGS="$LDFLAGS" || exit
make -j$NCPU all LDFLAGS="$LDFLAGS" || exit
make install LDFLAGS="$LDFLAGS" || exit
cd ..
