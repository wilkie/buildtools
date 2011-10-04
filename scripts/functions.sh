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


