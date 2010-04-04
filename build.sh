export TARGET=x86_64-pc-xomb
export PREFIX=`pwd`/local

mkdir -p build
mkdir -p local
cd build

BINUTILS_VER=2.20
GCC_VER=4.4.3
GMP_VER=5.0.1
MPFR_VER=2.4.2
NEWLIB_VER=1.18.0

WFLAGS=-c

export PATH=$PREFIX/bin:$PATH

# Fetch each package

echo "FETCH BINUTILS"
wget $WFLAGS http://ftp.gnu.org/gnu/binutils/binutils-${BINUTILS_VER}.tar.gz 
tar -xf binutils-${BINUTILS_VER}.tar.gz

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

echo "FETCH NEWLIB"
wget $WFLAGS ftp://sources.redhat.com/pub/newlib/newlib-${NEWLIB_VER}.tar.gz
tar -xf newlib-${NEWLIB_VER}.tar.gz

# Patch and push new code into each package

echo "PATCH BINUTILS"
patch -p0 -d binutils-${BINUTILS_VER} < ../binutils-xomb.patch || exit
cp -r ../binutils-files/* binutils-${BINUTILS_VER}/.

echo "PATCH GCC"
patch -p0 -d gcc-${GCC_VER} < ../gcc-xomb.patch || exit
cp -r ../gcc-files/* gcc-${GCC_VER}/.

echo "PATCH NEWLIB"
patch -p0 -d newlib-${NEWLIB_VER} < ../newlib-xomb.patch || exit
cp -r ../newlib-files/* newlib-${NEWLIB_VER}/.

echo "MAKE OBJECT DIRECTORIES"
mkdir -p binutils-obj
mkdir -p gcc-obj
mkdir -p newlib-obj
mkdir -p gmp-obj
mkdir -p mpfr-obj

# Compile all packages

echo "COMPILE BINUTILS"
cd binutils-obj
../binutils-${BINUTILS_VER}/configure --target=$TARGET --prefix=$PREFIX || exit
make || exit
make install || exit
cd ..

echo "COMPILE GMP"
cd gmp-obj
../gmp-${GMP_VER}/configure --prefix=$PREFIX --disable-shared || exit
make || exit
make check || exit
make install || exit
cd ..

echo "COMPILE MPFR"
cd mpfr-obj
../mpfr-${MPFR_VER}/configure --prefix=$PREFIX --with-gmp=$PREFIX --disable-shared
make || exit
make check || exit
make install || exit
cd ..

echo "AUTOCONF GCC"
cd gcc-${GCC_VER}/libstdc++-v3
#autoconf || exit
cd ../..

echo "COMPILE GCC"
cd gcc-obj
../gcc-${GCC_VER}/configure --target=$TARGET --prefix=$PREFIX --enable-languages=c,c++,fortran --disable-libssp --with-gmp=$PREFIX --with-mpfr=$PREFIX --disable-nls --with-newlib || exit
make all-gcc || exit
make install-gcc || exit
cd ..

echo "AUTOCONF NEWLIB-XOMB"
cd newlib-${NEWLIB_VER}/newlib/libc/sys
autoconf || exit
cd xomb
autoreconf || exit
cd ../../../../..

echo "CONFIGURE NEWLIB"
cd newlib-obj
../newlib-${NEWLIB_VER}/configure --target=$TARGET --prefix=$PREFIX --with-gmp=$PREFIX --with-mpfr=$PREFIX || exit

echo "COMPILE NEWLIB"
make || exit
make install || exit
cd ..

echo "PASS-2 COMPILE GCC"
cd gcc-obj
#make all-target-libgcc
#make install-target-libgcc
make || exit
make install || exit
cd ..
