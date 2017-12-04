ARCHS=(arm arm64 x86 x86_64)
OARCHS=(arm64-v8a armeabi-v7a x86 x86_64)
TOOLS=(arm-linux-androideabi aarch64-linux-android i686-linux-android x86_64-linux-android)
LIBPATH=~/AndroidStudioProjects/hello-custom-lib/distribution/test/lib/
export LDFLAGS="-pie"
for a in `seq 1 "${#ARCHS[@]}"`
do
    i=$(($a - 1))
    echo "$CFLAGS"
    toolchain-"${ARCHS[$i]}"/bin/"${TOOLS[$i]}"-gcc $CFLAGS -c test.c
    mkdir -p $LIBPATH/${OARCHS[$i]}
    toolchain-"${ARCHS[$i]}"/bin/"${TOOLS[$i]}"-ar rcs $LIBPATH/${OARCHS[$i]}/libtest.a test.o
done
    



