# --- resources ---
function title {
		echo -en "\033]0;$@\007"
}

function setphase {
		title $1
		echo ">>>>>>> $1"
}

# --- Argument processing ---
#prcessArgs {
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
#}

# --- patching ---

function toUpper {
		UPPER=`echo $1 | tr '[:lower:]' '[:upper:]'`
}


function doPatch {
		toUpper $1
		setphase "PATCH $UPPER"

		local VERSION=${UPPER}_VER
		eval VER=\${$VERSION}
		patch -p0 -d $1-$VER < ../patches/$1.patch || exit
}
