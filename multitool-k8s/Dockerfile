FROM nyvanga/multitool

ARG KUBERNETES_VERSION=NO-VERSION

ADD https://dl.k8s.io/release/v${KUBERNETES_VERSION}/bin/linux/amd64/kubectl /usr/local/bin/kubectl

RUN chmod +x /usr/local/bin/kubectl && \
	kubectl completion bash > /etc/bash_completion.d/kubectl

ENTRYPOINT ["/usr/local/bin/kubectl", "proxy"]