FROM python:3.11-slim as base-image
WORKDIR /root
RUN echo "now building..." && \
    apt update && apt upgrade -y && \
    apt install -y build-essential libreadline-dev libffi-dev git pkg-config gcc-arm-none-eabi libnewlib-arm-none-eabi


FROM base-image as clone-mpython
WORKDIR /usr/local/src
RUN git clone --recurse-submodules https://github.com/micropython/micropython.git


FROM clone-mpython as build-mpython
WORKDIR /usr/local/src/micropython/mpy-cross/
RUN make
WORKDIR /usr/local/src/micropython/ports/unix/
RUN make && make install


FROM python:3.11-slim as install-mpython
WORKDIR /tmp
COPY --from=build-mpython /usr/local/micropython /tmp/micropython
RUN install -d /usr/local/bin && install /tmp/micropython /usr/local/bin/micropython

CMD /usr/local/bin/micropython
