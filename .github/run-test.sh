#!/bin/sh
# =============================================================================
#  ShellSpec による動的／単体テストの実行スクリプト
# =============================================================================

# -----------------------------------------------------------------------------
#  Constants
# -----------------------------------------------------------------------------
PATH_DIR_REPO="$(dirname "$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)")"
PATH_DIR_RETURN="$(cd . && pwd)"
SUCCESS=0
FAILURE=1

echo '==============================================================================='
echo ' Requirement Check for ShellSpec'
echo '==============================================================================='

# ShellSpec のインストールチェック
which shellspec 1>/dev/null 2>/dev/null || {
    echo >&2 "shellspec がインストールされていません"
    echo >&2 "参考文献: https://github.com/shellspec/shellspec#installation"

    exit $FAILURE
}
echo "- ShellCheck $(shellcheck --version | grep version:)"

# -----------------------------------------------------------------------------
#  Functions
# -----------------------------------------------------------------------------

runShellSpec() {
    printf "%s" '- ShellSpec '

    result=$(shellspec 2>&1) || {
        printf >&2 ": NG\n%s" "$result"

        return $FAILURE
    }

     echo "$(echo "$result" | head -n 2 | tail -n 1)" 'OK'
}

# -----------------------------------------------------------------------------
#  Main
# -----------------------------------------------------------------------------
set -eu

cd "$PATH_DIR_REPO" || {
    echo >&2 "Failed to change dir to: ${PATH_DIR_REPO}"

    exit $FAILURE
}

echo '-------------------------------------------------------------------------------'
echo ' Running unit tests'
echo '-------------------------------------------------------------------------------'
runShellSpec

cd "$PATH_DIR_RETURN" || {
    echo >&2 "Failed to change dir to: ${PATH_DIR_RETURN}"

    exit $FAILURE
}

exit $SUCCESS
