FROM python:3.11-slim

RUN echo "now building..."
RUn apt update
RUN apt install build-essential libreadline-dev libffi-dev git pkg-config gcc-arm-none-eabi libnewlib-arm-none-eabi

WORKDIR /usr/local/src
RUN git clone --recurse-submodules https://github.com/micropython/micropython.git

WORKDIR /usr/local/src/micropython/mpy-cross/
RUN make

WORKDIR /usr/local/src/micropython/mpy-cross/ports/unix/
RUN make
RUN make install
