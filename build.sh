export TARGET=x86_64-pc-xomb
export PREFIX=`pwd`

BINUTILS_VER=2.20
GCC_VER=4.3.3
GMP_VER=5.0.1
MPFR_VER=2.4.2
NEWLIB_VER=1.18.0

# Fetch each package

# FETCH BINUTILS
wget http://ftp.gnu.org/gnu/binutils/binutils-${BINUTILS_VER}.tar.gz 
tar -xf binutils-${BINUTILS_VER}.tar.gz

# FETCH GCC
wget http://ftp.gnu.org/gnu/gcc/gcc-${GCC_VER}/gcc-core-${GCC_VER}.tar.gz
tar -xf gcc-core-${GCC_VER}.tar.gz
wget http://ftp.gnu.org/gnu/gcc/gcc-${GCC_VER}/gcc-g++-${GCC_VER}.tar.gz
tar -xf gcc-g++-${GCC_VER}.tar.gz
wget http://ftp.gnu.org/gnu/gcc/gcc-${GCC_VER}/gcc-fortran-${GCC_VER}.tar.gz
tar -xf gcc-fortran-${GCC_VER}.tar.gz

# FETCH GMP
wget http://ftp.gnu.org/gnu/gmp/gmp-${GMP_VER}.tar.gz
tar -xf gmp-${GMP_VER}.tar.gz

# FETCH MPFR
wget http://ftp.gnu.org/gnu/mpfr/mpfr-${MPFR_VER}.tar.gz
tar -xf mpfr-${MPFR_VER}.tar.gz

# FETCH NEWLIB
wget ftp://sources.redhat.com/pub/newlib/newlib-${NEWLIB_VER}.tar.gz
tar -xf newlib-${NEWLIB_VER}.tar.gz

# Patch and push new code into each package

# PATCH BINUTILS
cp binutils.ld-emulparams.tar.bz2 binutils-${BINUTILS_VER}
cd binutils-${BINUTILS_VER}
tar -xf binutils.ld-emulparams.tar.bz2
cd ..

patch -p0 -d binutils-${BINUTILS_VER} < binutils-xomb.patch

# PATCH GCC
patch -p0 -d gcc-${GCC_VER} < gcc-xomb.patch
cp -r gcc-xomb/* gcc-${GCC_VER}/.

# PATCH NEWLIB
patch -p0 -d newlib-${GCC_VER} < newlib-xomb.patch
cp -r newlib-xomb/* newlib-${NEWLIB_VER}/.

# MAKE OBJECT DIRECTORIES
mkdir -p binutils-obj
mkdir -p gcc-obj
mkdir -p newlib-obj
mkdir -p gmp-obj
mkdir -p mpfr-obj

# Compile all packages

# COMPILE BINUTILS
cd binutils-obj
../binutils-${BINUTILS_VER}/configure --target=$TARGET --prefix=$PREFIX
make
make install
cd ..

# COMPILE GMP
cd gmp-obj
../gmp-${GMP_VER}/configure --prefix=$PREFIX --disable-shared
make
make check
make install
cd ..

# COMPILE MPFR
cd mpfr-obj
../mpfr-${MPFR_VER}/configure --prefix=$PREFIX --with-gmp=$PREFIX --disable-shared
make
make check
make install
cd ..

# COMPILE GCC
cd gcc-obj
../gcc-${GCC_VER}/configure --target=$TARGET --prefix=$PREFIX --enable-languages=c,c++,fortran --disable-libssp --with-gmp=$PREFIX --with-mpfr=$PREFIX --disable-nls --with-headers=$PREFIX/include --with-newlib
make all-gcc
make all-target-libgcc
make install-gcc
make install-target-libgcc
cd ..

# COMPILE NEWLIB-XOMB
cd newlib-${NEWLIB_VER}/newlib/libc/sys
./configure
cd ../../../..

# COMPILE NEWLIB
cd newlib-obj
../newlib-src/configure --target=$TARGET --prefix=$PREFIX
make all
make install
cd ..
