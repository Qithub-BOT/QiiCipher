# =============================================================================
#  QiiCipher for Docker
# =============================================================================
# QiiCipher のコマンドだけを含めた Alpine イメージです。
# マルチステージ・ビルドでテストを実行し、最終的に QiiCipher のコマンドだけを含めたシンプル
# なイメージを作成します。
#
# ビルド例
#   $ docker build -t qiic .
# 実行例
#   $ docker run --rm -it qiic /bin/sh

# -----------------------------------------------------------------------------
#  Test Stage
# -----------------------------------------------------------------------------
FROM alpine:latest AS testbuild

# Install miminum requirements for QiiCipher
RUN apk add --no-cache \
    openssl \
    openssh \
    coreutils \
    ca-certificates && update-ca-certificates

# Install requirements for testing
RUN apk add --no-cache \
    curl \
    git \
    shellcheck \
    shfmt \
    && curl -fsSL https://git.io/shellspec | sh -s -- --yes --prefix /usr/local

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

# Install miminum requirements for QiiCipher
RUN apk add --no-cache \
    openssl \
    openssh \
    coreutils \
    ca-certificates && update-ca-certificates

COPY --from=testbuild /app/bin /usr/local/sbin

WORKDIR /app

CMD ["/bin/ls","/usr/local/sbin"]
