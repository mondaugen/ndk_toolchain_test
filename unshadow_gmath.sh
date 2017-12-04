ARCHS=(arm arm64 x86 x86_64)
OARCHS=(arm64-v8a armeabi-v7a x86 x86_64)
TOOLS=(arm-linux-androideabi aarch64-linux-android i686-linux-android x86_64-linux-android)
LIBPATH=~/AndroidStudioProjects/hello-libs1/distribution/gmath
if [ -f $LIBPATH/include/gmath_.h ]; then
    rm "${LIBPATH}"/include/gmath.h
    mv "${LIBPATH}"/include/gmath_.h "${LIBPATH}"/include/gmath.h 
fi
#cp test.h "${LIBPATH}"/include/gmath.h
export LDFLAGS="-pie"
for a in `seq 1 "${#ARCHS[@]}"`
do
    i=$(($a - 1))
    #toolchain-"${ARCHS[$i]}"/bin/"${TOOLS[$i]}"-gcc $CFLAGS -c test.c
    #mkdir -p $LIBPATH/${OARCHS[$i]}
    if [ -f $LIBPATH/lib/${OARCHS[$i]}/libgmath_.a ]; then
        rm $LIBPATH/lib/${OARCHS[$i]}/libgmath.a
        mv $LIBPATH/lib/${OARCHS[$i]}/libgmath_.a \
            $LIBPATH/lib/${OARCHS[$i]}/libgmath.a
            
    fi
    #toolchain-"${ARCHS[$i]}"/bin/"${TOOLS[$i]}"-ar rcs \
    #    $LIBPATH/lib/${OARCHS[$i]}/libgmath.a test.o
done
    



