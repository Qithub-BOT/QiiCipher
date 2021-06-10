# QiiCipher のコマンドだけを含めた Alpine イメージです
FROM alpine

RUN apk add --no-cache \
    bash \
    curl \
    openssl \
    ca-certificates && update-ca-certificates

COPY ./bin /usr/local/sbin

CMD ["/bin/ls","/bin/local/sbin"]
