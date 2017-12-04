ARCHS=(arm arm64 x86 x86_64)
for arch in "${ARCHS[@]}";
do
    $NDK/build/tools/make_standalone_toolchain.py \
          --arch $arch \
            --api 21 \
              --stl=libc++ \
                --install-dir=toolchain-$arch
done
