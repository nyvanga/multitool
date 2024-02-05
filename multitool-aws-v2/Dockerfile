FROM nyvanga/multitool

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-$(arch).zip" -o "awscliv2.zip" && \
	unzip awscliv2.zip && \
	./aws/install && \
	rm -rf awscliv2.zip aws/

ARG DEBIAN_FRONTEND=noninteractive

RUN set -x && \
    apt-get update -qq && \
    apt-get upgrade -qq && \
    apt-get install -qq --no-install-recommends \
      python3-boto3 && \
    rm -rf /var/lib/apt/lists/*

COPY /bin/* /usr/local/bin/
