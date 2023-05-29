FROM n8nio/n8n
RUN apk update
RUN mkdir -p /data/n8n/tts/
RUN chmod 777 /data/n8n/tts/
RUN apk add  build-base yasm gnutls-dev lame-dev opus-dev libtheora-dev libvpx-dev libwebp-dev x264-dev x265-dev libass-dev libva-dev libvdpau-dev libvorbis-dev opencore-amr-dev dav1d-dev aom-dev libdrm-dev pulseaudio-dev  librist-dev soxr-dev libssh-dev libsrt-dev svt-av1-dev v4l-utils-dev vidstab-dev xvidcore-dev zeromq-dev libxcb-dev libva-dev libvdpau-dev vulkan-loader-dev && \
wget https://ffmpeg.org/releases/ffmpeg-6.0.tar.gz && \
tar -zxvf ffmpeg-6.0.tar.gz && \
cd ffmpeg-6.0 && \
./configure --prefix=/usr --enable-avfilter  --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-libfontconfig --enable-libfreetype --enable-libfribidi --enable-gnutls --enable-gpl --enable-libass --enable-libmp3lame --enable-libpulse --enable-libvorbis --enable-libvpx --enable-libxvid --enable-libx264 --enable-libx265 --enable-libtheora --enable-libv4l2 --enable-libdav1d --enable-lto --enable-postproc --enable-pic --enable-pthreads --enable-shared --enable-libxcb --enable-librist --enable-libsrt --enable-libssh --enable-libvidstab --disable-stripping --disable-static --disable-librtmp --disable-lzma --enable-libaom --enable-libopus --enable-libsoxr --enable-libwebp --enable-vaapi --enable-vdpau --enable-vulkan --enable-libdrm --enable-libzmq --optflags=-O2 --disable-debug --enable-libsvtav1 --enable-version3 && \
make && \
make install 

ARG PGPASSWORD
ARG PGHOST
ARG PGPORT
ARG PGDATABASE
ARG PGUSER

ARG USERNAME
ARG PASSWORD

ENV DB_TYPE=postgresdb
ENV DB_POSTGRESDB_DATABASE=$PGDATABASE
ENV DB_POSTGRESDB_HOST=$PGHOST
ENV DB_POSTGRESDB_PORT=$PGPORT
ENV DB_POSTGRESDB_USER=$PGUSER
ENV DB_POSTGRESDB_PASSWORD=$PGPASSWORD

ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_BASIC_AUTH_USER=$USERNAME
ENV N8N_BASIC_AUTH_PASSWORD=$PASSWORD
EXPOSE 5678
CMD ["n8n", "start"]
