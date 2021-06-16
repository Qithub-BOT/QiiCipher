# =============================================================================
#  QiiCipher for Docker
# =============================================================================
# QiiCipher のコマンドだけを含めた Alpine イメージです。
# マルチステージ・ビルドでテストを実行し、成功した場合のみ QiiCipher のコマンドだけを含めた
# シンプルなイメージを作成します。docker-compose.test.yml により Docker Hub からのダウ
# ンロード（`docker pull`）が可能になります。

# -----------------------------------------------------------------------------
#  Test Stage
# -----------------------------------------------------------------------------
FROM shellspec/shellspec:latest AS testbuild

# Install miminum requirements for QiiCipher
RUN apk add --no-cache \
    openssl \
    openssh \
    ca-certificates && update-ca-certificates

# Install requirements for testing
RUN apk add --no-cache \
    git \
    shellcheck \
    shfmt

# Copy the hole repo
COPY . /app
WORKDIR /app

# Run tests
RUN \
    /app/.github/run-lint.sh \
    && /app/.github/run-test.sh

# -----------------------------------------------------------------------------
#  Final Stage
# -----------------------------------------------------------------------------
FROM alpine

RUN apk add --no-cache \
    openssl \
    openssh \
    ca-certificates && update-ca-certificates

COPY --from=testbuild /app/bin /usr/local/sbin

CMD ["/bin/ls","/usr/local/sbin"]
