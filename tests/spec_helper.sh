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
PATH_DIR_WORK="${SHELLSPEC_TMPDIR:?'SHELLSPEC_TMPDIR not set'}"

# 静的解析(shellcheck)の未使用エラー回避のため export
export PATH_DIR_REPO
export PATH_DIR_BIN
export PATH_DIR_TEST
export PATH_DIR_WORK
