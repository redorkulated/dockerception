FROM jenkins/jnlp-slave:alpine
USER root

# Add packages
RUN apk add --no-cache \
ca-certificates \
curl \
openssl \
openssl-dev \
g++ \
python3 \
python3-dev \
build-base \
libffi \
libffi-dev \
gcc \
libc-dev \
git

# Setup python
RUN python3 -m ensurepip && \
rm -r /usr/lib/python*/ensurepip && \
pip3 install --upgrade pip setuptools && \
if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi
RUN pip install six pynacl virtualenv

# Setup gcloud/gsutil
RUN curl https://sdk.cloud.google.com | bash -s -- --disable-prompts
RUN ~/google-cloud-sdk/bin/gcloud config set disable_usage_reporting true