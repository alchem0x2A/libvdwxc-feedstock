if [ "$(uname)" == "Darwin" ]; then
    ENABLE_FORTRAN=OFF
fi
if [ "$(uname)" == "Linux" ]; then
    ENABLE_FORTRAN=ON
fi

echo "At directory" `pwd`
ls

autoreconf -i

echo ${BUILD_PREFIX}
ls ${BUILD_PREFIX}/include
# which $CC
# export CFLAGS="-I${BUILD_PREFIX}/include"
# export LDFLAGS="-L${BUILD_PREFIX}/lib"
./configure \
    --with-mpi=${BUILD_PREFIX} \
    CC=$CC FC=$FC \
    --with-fftw3=${BUILD_PREFIX} \
    --prefix=${PREFIX}

# ${BUILD_PREFIX}/bin/cmake \
#     -H${SRC_DIR} \
#     -Bbuild \
#     -DCMAKE_INSTALL_PREFIX=${PREFIX} \
#     -DCMAKE_BUILD_TYPE=Release \
#     -DCMAKE_C_COMPILER=${CC} \
#     -DCMAKE_C_FLAGS="${CFLAGS}" \
#     -DCMAKE_INSTALL_LIBDIR=lib \
#     -DNAMESPACE_INSTALL_INCLUDEDIR="/" \
#     -DBUILD_SHARED_LIBS=ON \
#     -DENABLE_FORTRAN=${ENABLE_FORTRAN} \
#     -DENABLE_XHOST=OFF \
#     -DBUILD_TESTING=ON

# cd build
make -j${CPU_COUNT}

make install

# ctest
