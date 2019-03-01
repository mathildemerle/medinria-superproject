echo '-- ffmpeg-configure shell - extract --'
cd $(cygpath -u $1)
tar -zxf ffmpeg.tar.gz
#rm -fr ffmpeg
#cvs -z9 -d:pserver:anonymous@mplayerhq.hu:/cvsroot/ffmpeg co ffmpeg
cd ffmpeg
#cvs -q update -dAP -D 2006-1-30

echo '-- ffmpeg-configure shell - configure --'
# 4.1
#./configure --target-os=mingw32 --enable-shared --disable-static --disable-x86asm --prefix=$(cygpath -u $2) --enable-cross-compile --disable-doc --disable-ffplay --disable-decoders --disable-network
#./configure --target-os=mingw32 --enable-shared --disable-static --prefix=$(cygpath -u $2) --enable-cross-compile --disable-vhook --disable-network --disable-zlib --disable-ffserver --disable-ffplay --disable-decoders 
#./configure --target-os=mingw32 --enable-shared --disable-static --prefix=$(cygpath -u $2) --enable-cross-compile --disable-network --disable-zlib --disable-ffserver --disable-ffplay --disable-decoders --arch=x86_64 --disable-yasm
# sources
#./configure --enable-shared --disable-static --prefix=$(cygpath -u $2) --disable-audio-beos --disable-network --disable-zlib --disable-ffserver --disable-ffplay --disable-decoders --disable-vhook #--disable-yasm
./configure --prefix=$(cygpath -u $2) --enable-shared

echo '-- ffmpeg-configure shell - cleaning --'
#make clean

echo '-- ffmpeg-configure shell - make --'
make

echo '-- ffmpeg-configure shell - install --'
make install