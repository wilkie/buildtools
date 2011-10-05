
source scripts/functions.sh

# --- Variables ---

source scripts/nativevars.sh


# --- Directory creation ---

mkdir -p build
mkdir -p $PREFIX
cd build

setphase "MAKE OBJECT DIRECTORIES"
mkdir -p ncurses-obj
mkdir -p slang-obj
mkdir -p nano-obj

NANO_VER=2.3.1
SLANG_VER=2.2.4
NCURSES_VER=5.9

setphase "FETCH NANO"
wget $WFLAGS http://www.nano-editor.org/dist/v2.3/nano-2.3.1.tar.gz
tar -xf nano-2.3.1.tar.gz

setphase FETCH SLANG
wget $WFLAGS ftp://space.mit.edu/pub/davis/slang/v2.2/slang-$SLANG_VER.tar.gz
tar -xf slang-$SLANG_VER.tar.gz

setphase FETCH NCURSES
wget $WFLAGS http://ftp.gnu.org/pub/gnu/ncurses/ncurses-$NCURSES_VER.tar.gz
tar -xf ncurses-$NCURSES_VER.tar.gz


doPatch nano
doPatch slang
doPatch ncurses


setphase "COMPILE NCURSES"
cd ncurses-obj
../ncurses-$NCURSES_VER/configure $CROSSCONFIG --disable-shared ||exit
make || exit
make install || exit
cd ..

#setphase "COMPILE SLANG"
#cd slang-$SLANG_VER
#./configure $CROSSCONFIG --disable-shared ||exit
#make || exit
#make install || exit
#cd ..

setphase "COMPILE NANO"
cd nano-obj
../nano-$NANO_VER/configure $CROSSCONFIG --disable-shared ||exit
#--with-slang
make || exit
make install || exit
cd ..
