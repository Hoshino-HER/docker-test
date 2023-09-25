# Create build image
FROM python:3.11-slim as base-image 

WORKDIR /root
RUN <<EOS
echo "now building..."
apt update
apt install -y build-essential libreadline-dev libffi-dev git make
EOS

ENTRYPOINT [ "echo" ]
CMD ["ABCDE"]
