FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /miner

# Install build tools and dependencies
RUN apt-get update && apt-get install -y \
    build-essential autoconf automake libtool pkg-config \
    libcurl4-openssl-dev libjansson-dev libgomp1 zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

COPY . /miner

RUN chmod +x ./autogen.sh || true
RUN ./autogen.sh || true

RUN CFLAGS="-O2 -static-libgcc -static-libstdc++" \
    CXXFLAGS="-O2 -static-libgcc -static-libstdc++" \
    LDFLAGS="-static-libgcc -static-libstdc++" \
    ./configure --disable-cuda --disable-opencl || true

RUN make -j$(nproc) || make -j1

CMD ["bash"]
