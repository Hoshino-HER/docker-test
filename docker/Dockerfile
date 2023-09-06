FROM python:3.11-slim as base-image
WORKDIR /root
RUN echo "now building..." && \
    apt update && apt upgrade -y && \
    apt install -y build-essential libreadline-dev libffi-dev git pkg-config gcc-arm-none-eabi libnewlib-arm-none-eabi


FROM base-image as clone-mpython
WORKDIR /usr/local/src
RUN git clone --recurse-submodules https://github.com/micropython/micropython.git


FROM clone-image as build-mpython
WORKDIR /usr/local/src/micropython/mpy-cross/
RUN make
WORKDIR /usr/local/src/micropython/ports/unix/
RUN make


FROM python:3.11-slim
RUN mkdir -p /usr/local/src
COPY --from=build-mpython /usr/local/src/micropython/ /usr/local/src/micropython/
WORKDIR /usr/local/src/micropython/ports/unix/
RUN make install
WORKDIR /usr/local
RUN rm -r /usr/local/src

CMD /usr/local/bin/micropython