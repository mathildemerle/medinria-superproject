echo '-- ffmpeg-configure shell - configure --'
cd $(cygpath -u $1)
./configure --target-os=mingw32 --enable-shared --disable-static --disable-x86asm --prefix=$(cygpath -u $2) --enable-cross-compile --disable-doc --disable-ffplay --disable-decoders --disable-network
#./configure --target-os=mingw32 --enable-shared --disable-static --prefix=$(cygpath -u $2) --enable-cross-compile --disable-vhook --disable-network --disable-zlib --disable-ffserver --disable-ffplay --disable-decoders 
#./configure --target-os=mingw32 --enable-shared --disable-static --prefix=$(cygpath -u $2) --enable-cross-compile --disable-network --disable-zlib --disable-ffserver --disable-ffplay --disable-decoders 
echo '-- ffmpeg-configure shell - cleaning --'
make clean
echo '-- ffmpeg-configure shell - install --'
make install