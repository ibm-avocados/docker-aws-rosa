FROM fedora:latest

RUN dnf upgrade -y
RUN dnf install -y \
    wget \
    openssl \
    unzip 

# install AWS cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    sudo ./aws/install
# install rosa cli
RUN curl "https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/rosa/latest/rosa-linux.tar.gz" -o "rosa-linux.tar.gz" && \
    tar -xzvf rosa-linux.tar.gz && \
    mv rosa /usr/local/bin/

WORKDIR /
RUN mkdir /scripts
COPY scripts/run.sh /scripts/run.sh

ENTRYPOINT ["/scripts/run.sh"]
