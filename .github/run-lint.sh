#!/bin/sh
# =============================================================================
#  ShellCheck & ShellFormat(shfmt) の一括実行スクリプト
# =============================================================================

# -----------------------------------------------------------------------------
#  Constants
# -----------------------------------------------------------------------------
SUCCESS=0
FAILURE=1
NAME_FILE_CHECKSUM='checksum.sha512'

PATH_DIR_REPO="$(dirname "$(cd "$(dirname "$0")" && pwd)")"
PATH_DIR_BIN="${PATH_DIR_REPO}/bin"
PATH_DIR_RETURN="$(cd . && pwd)"
PATH_FILE_CHECKSUM="${PATH_DIR_BIN}/${NAME_FILE_CHECKSUM}"

# 拡張子のないスクリプトファイル一覧（テスト対象リスト）
LIST_SCRIPT_NO_EXT="archive check dec enc keygen sign verify checkkeylength dearchive"

echo '==============================================================================='
echo ' Requirement Check for Linting and Static Analysis'
echo '==============================================================================='

# ShellCheck のインストールチェック
which shellcheck 1>/dev/null 2>/dev/null || {
    echo >&2 "shellcheck がインストールされていません"
    echo >&2 "参考文献: https://github.com/Qithub-BOT/QiiCipher/issues/3"

    exit $FAILURE
}
echo "- ShellCheck $(shellcheck --version | grep version:)"

# shfmt のインストールチェック
which shfmt 1>/dev/null 2>/dev/null || {
    echo >&2 "shfmt がインストールされていません"
    echo >&2 "参考文献: https://github.com/Qithub-BOT/QiiCipher/issues/3"

    exit $FAILURE
}
echo "- shfmt version: $(shfmt --version)"

# -----------------------------------------------------------------------------
#  Functions
# -----------------------------------------------------------------------------
indentStdIn() {
    indent="\t"
    while IFS= read -r line; do
        printf "${indent}%s\n" "${line}"
    done
    echo
}

runShfmt() {
    printf "%s" '- Shellformat ... '

    runShfmtForShExt && runShfmtForNoExt && echo 'OK'
}

# 拡張子 .sh ありのスクリプトの shfmt
runShfmtForShExt() {
    find . -name '*.sh' -type f -print0 | xargs -0 shfmt -d
}

# 拡張子 .sh なしのスクリプトの shfmt
runShfmtForNoExt() {
    result=$SUCCESS

    # shellcheck disable=SC2086
    set -- $LIST_SCRIPT_NO_EXT

    while [ "${1:+none}" ]; do
        path_file_target="${PATH_DIR_BIN}/${1}"

        shfmt -d "$path_file_target" || {
            echo >&2 "shfmt fail: ${path_file_target}"
            result=$FAILURE
        }

        shift
    done

    return $result
}

runShellCheck() {
    printf "%s" '- ShellCheck ... '

    runShellCheckShExt && runShellCheckForNoExt && echo 'OK'
}

# 拡張子 .sh ありのスクリプトの shellcheck
runShellCheckShExt() {
    find . -name '*.sh' -type f -print0 | xargs -0 shellcheck --external-sources
}

# 拡張子 .sh なしのスクリプトの shellcheck
runShellCheckForNoExt() {
    result=$SUCCESS

    # shellcheck disable=SC2086
    set -- $LIST_SCRIPT_NO_EXT

    while [ "${1:+none}" ]; do
        path_file_target="${PATH_DIR_BIN}/${1}"

        shellcheck --external-sources "$path_file_target" || {
            echo >&2 "shellcheck fail: ${path_file_target}"
            result=$FAILURE
        }

        shift
    done

    return $result
}

# -----------------------------------------------------------------------------
#  Main
# -----------------------------------------------------------------------------
set -eu

cd "$PATH_DIR_REPO" || {
    echo >&2 "Failed to change dir to: ${PATH_DIR_REPO}"

    exit $FAILURE
}
trap 'cd "$PATH_DIR_RETURN"' 0

echo '-------------------------------------------------------------------------------'
echo ' Running linters'
echo '-------------------------------------------------------------------------------'
runShfmt
runShellCheck

echo '-------------------------------------------------------------------------------'
echo ' Verifying Checksum File'
echo '-------------------------------------------------------------------------------'

printf "%s" '- Checksum ... '

cd "$PATH_DIR_BIN" || {
    echo >&2 "Failed to change dir to: ${PATH_DIR_BIN}"

    exit $FAILURE
}

result=$(sha512sum -c "$PATH_FILE_CHECKSUM") || {
    echo >&2 "$result"
    echo >&2 "Filed to verify checksum."

    exit $FAILURE
}
echo 'OK'
