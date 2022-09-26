FROM nyvanga/multitool

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-$(arch).zip" -o "awscliv2.zip" && \
	unzip awscliv2.zip && \
	./aws/install && \
	rm -rf awscliv2.zip aws/

COPY entrypoint.sh /usr/local/bin/

ENTRYPOINT ["entrypoint.sh"]