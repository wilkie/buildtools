source scripts/config.sh

PREFIX=`pwd`/${OSNAME}-local

CROSSCONFIG="--prefix=${PREFIX} --host=${TARGET} --bindir=${PREFIX}/binaries --sysconfdir=${PREFIX}/config --libdir=${PREFIX}/lib --includedir=${PREFIX}/include"

if [ $CLEAN -eq 1 ]; then
		rm -rf $PREFIX build/*/
fi

XOMBPATH=`pwd`/../xomb
CROSSPATH=`pwd`/local

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
export CXXFLAGS="$CFLAGS"
# -lsupc++ -lstdc++ -L$CROSSPATH/$TARGET"\


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
