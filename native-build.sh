
# --- resources ---
function title {
		echo -en "\033]0;$@\007"
}

function setphase {
		title $1
		echo ">>>>>>> $1"
}

# --- Argument processing ---
NOTEST=1
EXTRAS=1
CLEAN=0
for arg in $@; do
		case $arg in
				--clean)  CLEAN=1;;
				--notest) NOTEST=1;;
				--extras) EXTRA=1;;
		esac
done


# --- Variables ---

# EDIT THESE
OSNAME=xomb
NCPU=4

BINUTILS_VER=2.21.1
GCC_VER=4.6.1
GMP_VER=5.0.2
MPFR_VER=3.1.0
NEWLIB_VER=1.19.0
MPC_VER=0.9
PPL_VER=0.11.2
CLOOG_VER=0.16.3
# NO M0AR EDITS PLZ

TARGET=x86_64-pc-${OSNAME}
PREFIX=`pwd`/${OSNAME}-local

if [ $CLEAN -eq 1 ]; then
		rm -rf $PREFIX build/*/
fi

#export PATH=$PREFIX/bin:$PATH

WFLAGS=-c


XOMBPATH=/home/wolfwood/repos/xomb
CROSSPATH=/home/wolfwood/repos/buildtools/local

if [ ! -d $XOMBPATH ]; then
		XOMBPATH=`pwd`/../xomb
fi

if [ ! -f $XOMBPATH/app/build/elf.ld ]; then
		echo "cannot find xomb $XOMBPATH"
		exit
fi


#export LIBS="-l:drt0.a -l:syscall.a -l:mindrt.a"
export SHAREDLDFLAGS="-T$XOMBPATH/app/build/elf.ld"
# -L$XOMBPATH/user/c/lib -L$XOMBPATH/runtimes/mindrt"
export LDFLAGS="-static $SHAREDLDFLAGS -L$CROSSPATH/$TARGET"

export CPPFLAGS="-I$CROSSPATH/$TARGET/include/c++ -I$CROSSPATH/$TARGET/include/c++/$GCC_VER"

export CFLAGS="-static -O2 $CPPFLAGS"
export CXXFLAGS="$CFLAGS -lsupc++ -lstdc++ -L$CROSSPATH/$TARGET"


export CC=$TARGET-gcc
export CXX=$TARGET-g++

export AR=$TARGET-ar
export AS=$TARGET-as
#DLLTOOL
export LD=$TARGET-ld
#LIPO
export NM=$TARGET-nm
export RANLIB=$TARGET-ranlib
export STRIP=$TARGET-strip
#WINDRES
#WINDMC
export OBJCOPY=$TARGET-objcopy
export OBJDUMP=$TARGET-objdump


export CC_FOR_TARGET=$TARGET-gcc
export CXX_FOR_TARGET=$TARGET-g++

export AR_FOR_TARGET=$TARGET-ar
export AS_FOR_TARGET=$TARGET-as
#DLLTOOL
export LD_FOR_TARGET=$TARGET-ld
#LIPO
export NM_FOR_TARGET=$TARGET-nm
export RANLIB_FOR_TARGET=$TARGET-ranlib
export STRIP_FOR_TARGET=$TARGET-strip
#WINDRES
#WINDMC
export OBJCOPY_FOR_TARGET=$TARGET-objcopy
export OBJDUMP_FOR_TARGET=$TARGET-objdump


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

setphase "FETCH BINUTILS"
wget $WFLAGS http://ftp.gnu.org/gnu/binutils/binutils-${BINUTILS_VER}.tar.bz2
tar -xf binutils-${BINUTILS_VER}.tar.bz2

setphase "FETCH GCC"
wget $WFLAGS http://ftp.gnu.org/gnu/gcc/gcc-${GCC_VER}/gcc-core-${GCC_VER}.tar.gz
tar -xf gcc-core-${GCC_VER}.tar.gz
wget $WFLAGS http://ftp.gnu.org/gnu/gcc/gcc-${GCC_VER}/gcc-g++-${GCC_VER}.tar.gz
tar -xf gcc-g++-${GCC_VER}.tar.gz
wget $WFLAGS http://ftp.gnu.org/gnu/gcc/gcc-${GCC_VER}/gcc-fortran-${GCC_VER}.tar.gz
tar -xf gcc-fortran-${GCC_VER}.tar.gz

setphase "FETCH GMP"
wget $WFLAGS http://ftp.gnu.org/gnu/gmp/gmp-${GMP_VER}.tar.gz
tar -xf gmp-${GMP_VER}.tar.gz

setphase "FETCH MPFR"
wget $WFLAGS http://ftp.gnu.org/gnu/mpfr/mpfr-${MPFR_VER}.tar.gz
tar -xf mpfr-${MPFR_VER}.tar.gz

setphase "FETCH MPC"
wget $WFLAGS http://www.multiprecision.org/mpc/download/mpc-${MPC_VER}.tar.gz
tar -xf mpc-${MPC_VER}.tar.gz

setphase "FETCH NEWLIB"
wget $WFLAGS ftp://sources.redhat.com/pub/newlib/newlib-${NEWLIB_VER}.tar.gz
tar -xf newlib-${NEWLIB_VER}.tar.gz

if [ $EXTRAS -eq 1 ]; then
setphase "FETCH PPL"
wget $WFLAGS ftp://ftp.cs.unipr.it/pub/ppl/releases/${PPL_VER}/ppl-${PPL_VER}.tar.bz2
tar -xf ppl-${PPL_VER}.tar.bz2

setphase "FETCH CLooG"
wget $WFLAGS http://www.bastoul.net/cloog/pages/download/count.php3?url=./cloog-${CLOOG_VER}.tar.gz -O cloog-${CLOOG_VER}.tar.gz
tar -xf cloog-${CLOOG_VER}.tar.gz
fi

# --- Patch and push new code into each package ---

# Fix patches with osname
#PERLCMD="s/{{OSNAME}}/${OSNAME}/g"
#perl -pi -e $PERLCMD *.patch
#perl -pi -e $PERLCMD gcc-files/gcc/config/os.h

# diff -rupN


setphase "PATCH BINUTILS"
patch -p0 -d binutils-${BINUTILS_VER} < ../binutils.patch || exit
cp ../binutils-files/ld/emulparams/os_x86_64.sh binutils-${BINUTILS_VER}/ld/emulparams/${OSNAME}_x86_64.sh

setphase "PATCH GMP"
patch -p1 -d gmp-${GMP_VER} < ../gmp.patch || exit

setphase "PATCH MPFR"
patch -p0 -d mpfr-${MPFR_VER} < ../mpfr.patch || exit

setphase "PATCH MPC"
patch -p0 -d mpc-${MPC_VER} < ../mpc.patch || exit

if [ $EXTRAS -eq 1 ]; then
setphase "PATCH PPL"
patch -p0 -d ppl-${PPL_VER} < ../ppl.patch || exit

setphase "PATCH CLOOG"
patch -p0 -d cloog-${CLOOG_VER} < ../cloog.patch || exit
fi

setphase "PATCH GCC"
patch -p0 -d gcc-${GCC_VER} < ../gcc.patch || exit
cp ../gcc-files/gcc/config/os.h gcc-${GCC_VER}/gcc/config/${OSNAME}.h

setphase "PATCH NEWLIB"
patch -p0 -d newlib-${NEWLIB_VER} < ../newlib.patch || exit
mkdir -p newlib-${NEWLIB_VER}/newlib/libc/sys/${OSNAME}
cp -r ../newlib-files/* newlib-${NEWLIB_VER}/newlib/libc/sys/${OSNAME}/.
cp ../newlib-files/vanilla-syscalls.c newlib-${NEWLIB_VER}/newlib/libc/sys/${OSNAME}/syscalls.c


# --- Compile all packages ---

# relevant thread for building static bin utils (and dealing with ppl :)
# http://sources.redhat.com/ml/binutils/2011-08/msg00182.html
setphase "COMPILE _static_ BINUTILS"
cd binutils-obj
#--enable-plugins:  Building BFD with plugin support requires a host that supports -ldl.
../binutils-${BINUTILS_VER}/configure --host=$TARGET --prefix=$PREFIX --enable-gold --disable-werror || exit
make configure-host || exit
make -j$NCPU all-gold LDFLAGS="-all-static $SHAREDLDFLAGS" || exit
make -j$NCPU LDFLAGS="-all-static $SHAREDLDFLAGS" || exit
make install || exit
cd ..

setphase "COMPILE GMP"
cd gmp-obj
../gmp-${GMP_VER}/configure --host=$TARGET --prefix=$PREFIX --enable-cxx --disable-shared || exit
make -j$NCPU || exit
if [ $NOTEST -ne 1 ]; then
		make check || exit
fi
make install || exit
cd ..

setphase "COMPILE MPFR"
cd mpfr-obj
../mpfr-${MPFR_VER}/configure --host=$TARGET --prefix=$PREFIX --with-gmp=$PREFIX --disable-shared
make -j$NCPU || exit
if [ $NOTEST -ne 1 ]; then
		make check || exit
fi
make install || exit
cd ..

setphase "COMPILE MPC"
cd mpc-obj
../mpc-${MPC_VER}/configure --host=$TARGET --prefix=$PREFIX --with-gmp=$PREFIX --with-mpfr=$PREFIX --disable-shared || exit
make -j$NCPU || exit
if [ $NOTEST -ne 1 ]; then
		make check || exit
fi
make install || exit
cd ..

if [ $EXTRAS -eq 1 ]; then
setphase "COMPILE PPL"
cd ppl-obj
../ppl-${PPL_VER}/configure --host=$TARGET --prefix=$PREFIX --with-gmp-prefix=$PREFIX --disable-shared || exit
make -j$NCPU || exit
if [ $NOTEST -ne 1 ]; then
		make check || exit
fi
make install || exit
cd ..

setphase "COMPILE CLOOG"
cd cloog-obj
../cloog-${CLOOG_VER}/configure --host=$TARGET --prefix=$PREFIX --with-gmp-prefix=$PREFIX --disable-shared || exit
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
../gcc-${GCC_VER}/configure --prefix=$PREFIX --host=$TARGET --enable-languages=c,c++ --disable-libssp --with-gmp=$PREFIX --with-mpfr=$PREFIX --with-mpc=$PREFIX  --with-ppl=$PREFIX --enable-cloog-backend=isl --disable-nls --with-newlib  --without-headers --disable-shared || exit
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
../newlib-${NEWLIB_VER}/configure --target=$TARGET --host=$TARGET --prefix=$PREFIX --with-gmp=$PREFIX --with-mpfr=$PREFIX -enable-newlib-hw-fp || exit

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
