
# --- Argument processing ---

for arg in $@; do
		case $arg in
				--clean) rm -rf local/ build/*/;;
				--notest) NOTEST=1;;
		esac
done


# --- Variables ---

# EDIT THESE
OSNAME=xomb
NCPU=4

BINUTILS_VER=2.21.1
GCC_VER=4.6.1
GMP_VER=5.0.2
MPFR_VER=3.0.1
NEWLIB_VER=1.19.0
MPC_VER=0.9
# NO M0AR EDITS PLZ

TARGET=x86_64-pc-${OSNAME}
PREFIX=`pwd`/local

export PATH=$PREFIX/bin:$PATH

WFLAGS=-c


# --- Directory creation ---

mkdir -p build
mkdir -p local
cd build

echo "MAKE OBJECT DIRECTORIES"
mkdir -p binutils-obj
mkdir -p gcc-obj
mkdir -p newlib-obj
mkdir -p gmp-obj
mkdir -p mpfr-obj
mkdir -p mpc-obj


# --- Fetch and extract each package ---

echo "FETCH BINUTILS"
wget $WFLAGS http://ftp.gnu.org/gnu/binutils/binutils-${BINUTILS_VER}.tar.bz2
tar -xf binutils-${BINUTILS_VER}.tar.bz2

echo "FETCH GCC"
wget $WFLAGS http://ftp.gnu.org/gnu/gcc/gcc-${GCC_VER}/gcc-core-${GCC_VER}.tar.gz
tar -xf gcc-core-${GCC_VER}.tar.gz
wget $WFLAGS http://ftp.gnu.org/gnu/gcc/gcc-${GCC_VER}/gcc-g++-${GCC_VER}.tar.gz
tar -xf gcc-g++-${GCC_VER}.tar.gz
wget $WFLAGS http://ftp.gnu.org/gnu/gcc/gcc-${GCC_VER}/gcc-fortran-${GCC_VER}.tar.gz
tar -xf gcc-fortran-${GCC_VER}.tar.gz

echo "FETCH GMP"
wget $WFLAGS http://ftp.gnu.org/gnu/gmp/gmp-${GMP_VER}.tar.gz
tar -xf gmp-${GMP_VER}.tar.gz

echo "FETCH MPFR"
wget $WFLAGS http://ftp.gnu.org/gnu/mpfr/mpfr-${MPFR_VER}.tar.gz
tar -xf mpfr-${MPFR_VER}.tar.gz

echo "FETCH MPC"
wget $WFLAGS http://www.multiprecision.org/mpc/download/mpc-${MPC_VER}.tar.gz
tar -xf mpc-${MPC_VER}.tar.gz

echo "FETCH NEWLIB"
wget $WFLAGS ftp://sources.redhat.com/pub/newlib/newlib-${NEWLIB_VER}.tar.gz
tar -xf newlib-${NEWLIB_VER}.tar.gz


# --- Patch and push new code into each package ---

# Fix patches with osname
#PERLCMD="s/{{OSNAME}}/${OSNAME}/g"
#perl -pi -e $PERLCMD *.patch
#perl -pi -e $PERLCMD gcc-files/gcc/config/os.h

echo "PATCH BINUTILS"
patch -p0 -d binutils-${BINUTILS_VER} < ../binutils.patch || exit
cp ../binutils-files/ld/emulparams/os_x86_64.sh binutils-${BINUTILS_VER}/ld/emulparams/${OSNAME}_x86_64.sh

echo "PATCH GCC"
patch -p0 -d gcc-${GCC_VER} < ../gcc.patch || exit
cp ../gcc-files/gcc/config/os.h gcc-${GCC_VER}/gcc/config/${OSNAME}.h

echo "PATCH NEWLIB"
patch -p0 -d newlib-${NEWLIB_VER} < ../newlib.patch || exit
mkdir -p newlib-${NEWLIB_VER}/newlib/libc/sys/${OSNAME}
cp -r ../newlib-files/* newlib-${NEWLIB_VER}/newlib/libc/sys/${OSNAME}/.
cp ../newlib-files/vanilla-syscalls.c newlib-${NEWLIB_VER}/newlib/libc/sys/${OSNAME}/syscalls.c


# --- Compile all packages ---

echo "COMPILE BINUTILS"
cd binutils-obj
../binutils-${BINUTILS_VER}/configure --target=$TARGET --prefix=$PREFIX --disable-werror || exit
make -j$NCPU|| exit
make install || exit
cd ..

echo "COMPILE GMP"
cd gmp-obj
../gmp-${GMP_VER}/configure --prefix=$PREFIX --disable-shared || exit
make -j$NCPU || exit
if [ $NOTEST -ne 1 ]; then
		make check || exit
fi
make install || exit
cd ..

echo "COMPILE MPFR"
cd mpfr-obj
../mpfr-${MPFR_VER}/configure --prefix=$PREFIX --with-gmp=$PREFIX --disable-shared
make -j$NCPU || exit
if [ $NOTEST -ne 1 ]; then
		make check || exit
fi
make install || exit
cd ..

echo "COMPILE MPC"
cd mpc-obj
../mpc-${MPC_VER}/configure --target=$TARGET --prefix=$PREFIX --with-gmp=$PREFIX --with-mpfr=$PREFIX --disable-shared || exit
make -j$NCPU || exit
if [ $NOTEST -ne 1 ]; then
		make check || exit
fi
make install || exit
cd ..


echo "AUTOCONF GCC"
cd gcc-${GCC_VER}/libstdc++-v3
#autoconf || exit
cd ../..

echo "COMPILE GCC"
cd gcc-obj
../gcc-${GCC_VER}/configure --target=$TARGET --prefix=$PREFIX --enable-languages=c,c++ --disable-libssp --with-gmp=$PREFIX --with-mpfr=$PREFIX --with-mpc=$PREFIX --disable-nls --with-newlib || exit
make -j$NCPU all-gcc || exit
make install-gcc || exit
cd ..

echo "AUTOCONF NEWLIB-XOMB"
cd newlib-${NEWLIB_VER}/newlib/libc/sys
autoconf || exit
cd ${OSNAME}
autoreconf || exit
cd ../../../../..

echo "CONFIGURE NEWLIB"
cd newlib-obj
../newlib-${NEWLIB_VER}/configure --target=$TARGET --prefix=$PREFIX --with-gmp=$PREFIX --with-mpfr=$PREFIX -enable-newlib-hw-fp || exit

echo "COMPILE NEWLIB"
make -j$NCPU || exit
make install || exit
cd ..

echo "PASS-2 COMPILE GCC"
cd gcc-obj
#make all-target-libgcc
#make install-target-libgcc
make -j$NCPU all-target-libstdc++-v3 || exit
make install-target-libstdc++-v3 || exit
make -j$NCPU || exit
make install || exit
cd ..

echo "PASS-2 COMPILE NEWLIB"
cp ../newlib-files/syscalls.c newlib-${NEWLIB_VER}/newlib/libc/sys/${OSNAME}/syscalls.c

cd newlib-obj
../newlib-${NEWLIB_VER}/configure --target=$TARGET --prefix=$PREFIX --with-gmp=$PREFIX --with-mpfr=$PREFIX || exit
make || exit
make install || exit
cd ..
