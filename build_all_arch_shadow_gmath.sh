ARCHS=(arm arm64 x86 x86_64)
OARCHS=(armeabi-v7a arm64-v8a x86 x86_64)
TOOLS=(arm-linux-androideabi aarch64-linux-android i686-linux-android x86_64-linux-android)
TARGETS=(armv7-none-linux-androideabi aarch64-none-linux-android i686-none-linux-android x86_64-none-linux-android)
LIBPATH=~/AndroidStudioProjects/hello-libs1/distribution/gmath
if [ ! -f $LIBPATH/${OARCHS[$i]}/include/gmath_.h ]; then
    mv "${LIBPATH}"/include/gmath.h "${LIBPATH}"/include/gmath_.h
fi
cp test.h "${LIBPATH}"/include/gmath.h
export CFLAGS="-D__ANDROID_API__=21 -g -DANDROID -ffunction-sections -funwind-tables -fPIE -fPIC"
export LDFLAGS="-pie"
for a in `seq 1 "${#ARCHS[@]}"`
do
    i=$(($a - 1))
    toolchain-"${ARCHS[$i]}"/bin/"${TOOLS[$i]}"-clang \
        --target=${TARGETS[$i]} $CFLAGS -c test.c
    mkdir -p $LIBPATH/${OARCHS[$i]}
    if [ ! -f $LIBPATH/lib/${OARCHS[$i]}/libgmath_.a ]; then
        mv $LIBPATH/lib/${OARCHS[$i]}/libgmath.a \
            $LIBPATH/lib/${OARCHS[$i]}/libgmath_.a
    else
        rm $LIBPATH/lib/${OARCHS[$i]}/libgmath.a 
    fi
    toolchain-"${ARCHS[$i]}"/bin/"${TOOLS[$i]}"-ar qc \
        $LIBPATH/lib/${OARCHS[$i]}/libgmath.a test.o
    toolchain-"${ARCHS[$i]}"/bin/"${TOOLS[$i]}"-ranlib \
        $LIBPATH/lib/${OARCHS[$i]}/libgmath.a
done
    



