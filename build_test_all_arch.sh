ARCHS=(arm arm64 x86 x86_64)
OARCHS=(armeabi-v7a arm64-v8a x86 x86_64)
TOOLS=(arm-linux-androideabi aarch64-linux-android i686-linux-android x86_64-linux-android)
TARGETS=(armv7-none-linux-androideabi aarch64-none-linux-android i686-none-linux-android x86_64-none-linux-android)
LIBPATH=./lib
INCPATH=./include
# --target=aarch64-none-linux-android

#-latomic


case $1 in
    build)
        mkdir -p ${LIBPATH}
        mkdir -p ${INCPATH}
        cp test.h "${INCPATH}"/test.h
        export LDFLAGS="-pie"
        for a in `seq 1 "${#ARCHS[@]}"`
        do
            i=$(($a - 1))
#            export CFLAGS="--sysroot=/Users/audiblereality001/Library/Android/sdk/ndk-bundle/sysroot /
#                -Dgperf_EXPORTS  -isystem /
#                /Users/audiblereality001/Library/Android/sdk/ndk-bundle/sysroot/usr/include/${TOOLS[$i]} /
#                -D__ANDROID_API__=21 -g -DANDROID -ffunction-sections -funwind-tables /
#                -fstack-protector-strong -no-canonical-prefixes -Wa,--noexecstack -Wformat /
#                -Werror=format-security  -O0 -fno-limit-debug-info  -fPIC"
#  -D__ANDROID_API__=21 -g -DANDROID
            export CFLAGS='-fPIE -fPIC'
#-Wl,--exclude-libs,libgcc.a 
#            export SOFLAGS="-Wl,--exclude-libs,libatomic.a --sysroot /
#                /Users/audiblereality001/Library/Android/sdk/ndk-bundle/platforms/android-21/arch-${ARCHS[$i]} /
#                -Wl,--build-id -Wl,--warn-shared-textrel -Wl,--fatal-warnings -Wl,--no-undefined /
#                -Wl,-z,noexecstack -Qunused-arguments -Wl,-z,relro -Wl,-z,now -shared /
#                -Wl,-soname,libgperf.so"
            export SOFLAGS='-shared -Wl,-soname,libtest.so'
            rm -f test.o
            rm $LIBPATH/${OARCHS[$i]}/libtest.so
            toolchain-"${ARCHS[$i]}"/bin/"${TOOLS[$i]}"-clang \
                $CFLAGS -c test.c
            mkdir -p $LIBPATH/${OARCHS[$i]}
            toolchain-"${ARCHS[$i]}"/bin/"${TOOLS[$i]}"-clang ${CFLAGS} ${SOFLAGS} \
                -o $LIBPATH/${OARCHS[$i]}/libtest.so test.o
        done
        ;;
    clean)
        rm -r ${LIBPATH} ${INCPATH}
        ;;
    *)
        echo "Pass build or clean as argument"
esac
