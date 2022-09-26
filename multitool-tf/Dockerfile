FROM nyvanga/multitool

ARG TERRAFORM_VERSION=NO-VERSION

RUN curl -sS "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_$(dpkg --print-architecture).zip" -o "terraform.zip" && \
    unzip terraform.zip && \
    mv terraform /usr/local/bin/terraform && \
    rm terraform.zip

COPY entrypoint.sh /usr/local/bin/

ENTRYPOINT ["entrypoint.sh"]