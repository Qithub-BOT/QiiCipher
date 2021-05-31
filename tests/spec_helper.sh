#shellcheck shell=sh
# =============================================================================
#  spec_helper.sh は各テストの実行前に呼び出されるスクリプトです
# =============================================================================
#  See: https://github.com/shellspec/shellspec#spec_helper

# set -eu

# テスト中に利用可能なグローバル変数
PATH_DIR_REPO="$(cd "$(dirname "${SHELLSPEC_SPECDIR:?'SHELLSPEC_SPECDIR not set'}")" && pwd)"
PATH_DIR_BIN="${PATH_DIR_REPO}/bin"
PATH_DIR_TEST="${PATH_DIR_REPO}/tests"

export PATH_DIR_REPO
export PATH_DIR_BIN
export PATH_DIR_TEST

# -----------------------------------------------------------------------------
#  テスト中パスが通っていないため引数を丸ごと渡す同名の代替関数を定義
# -----------------------------------------------------------------------------

archive() {
    "${PATH_DIR_BIN}/archive" "$@"
}

check() {
    "${PATH_DIR_BIN}/check" "$@"
}

dec() {
    "${PATH_DIR_BIN}/dec" "$@"
}

enc() {
    "${PATH_DIR_BIN}/enc" "$@"
}

keygen() {
    "${PATH_DIR_BIN}/keygen" "$@"
}

sign() {
    "${PATH_DIR_BIN}/sign" "$@"
}

verify() {
    "${PATH_DIR_BIN}/verify" "$@"
}
