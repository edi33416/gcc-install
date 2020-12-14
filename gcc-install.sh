# Download and compile gcc
GCC_VERSION=10.2.0
ROOT=~/gcc

mkdir -p "${ROOT}/gcc-${GCC_VERSION}"
cd "${ROOT}/gcc-${GCC_VERSION}"
wget https://ftp.gnu.org/gnu/gcc/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.gz
tar xvf gcc-${GCC_VERSION}.tar.gz

mv gcc-${GCC_VERSION} src-gcc-${GCC_VERSION}
mkdir obj-gcc-${GCC_VERSION}
mkdir bin-gcc-${GCC_VERSION}

SRC_PATH=${ROOT}/gcc-${GCC_VERSION}/src-gcc-${GCC_VERSION}
BIN_PATH=${ROOT}/gcc-${GCC_VERSION}/bin-gcc-${GCC_VERSION}
OBJ_PATH=${ROOT}/gcc-${GCC_VERSION}/obj-gcc-${GCC_VERSION}

cd ${SRC_PATH}
./contrib/download_prerequisites
cd ${OBJ_PATH}
${SRC_PATH}/configure --disable-multilib --enable-languages=c,c++ --prefix=${BIN_PATH}/
make -j $(nproc)
make install

# Create `activate` script
case $(uname -m) in
    x86_64|amd64) ARCH=x86_64; MODEL=64;;                                                                                                                                                        i*86) ARCH=x86; MODEL=32;;
    *)
        fatal "Unsupported Arch $(uname -m)"
        ;;
esac

cd ${BIN_PATH}
cat > "activate" <<EOF
deactivate() {
    export PATH="\$_OLD_D_PATH"
    export LIBRARY_PATH="\$_OLD_D_LIBRARY_PATH"
    export LD_LIBRARY_PATH="\$_OLD_D_LD_LIBRARY_PATH"
    export PS1="\$_OLD_D_PS1"

    unset _OLD_D_PATH
    unset _OLD_D_LIBRARY_PATH
    unset _OLD_D_LD_LIBRARY_PATH
    unset _OLD_D_PS1
    unset -f deactivate
}

_OLD_D_PATH="\${PATH:-}"
_OLD_D_LIBRARY_PATH="\${LIBRARY_PATH:-}"
_OLD_D_LD_LIBRARY_PATH="\${LD_LIBRARY_PATH:-}"
_OLD_D_PS1="\${PS1:-}"

export PATH="${BIN_PATH}/bin/:\${PATH:-}"
export LIBRARY_PATH="${BIN_PATH}/lib${MODEL}:\${LIBRARY_PATH:-}"
export LD_LIBRARY_PATH="${BIN_PATH}/lib${MODEL}:\${LD_LIBRARY_PATH:-}"
export PS1="(gcc-${GCC_VERSION})\${PS1:-}"
EOF
