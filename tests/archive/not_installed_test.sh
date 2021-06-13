#shellcheck shell=sh

Describe 'archive without required'

    It 'not installed openssl'

# mock for built-in command
type() {
    if [ "$1" = "openssl" ]; then
        return 1
    fi
    return 0
}
        When run source "${PATH_DIR_BIN}/archive" \
            "${PATH_DIR_TEST}/data/sample001/sample001.txt" \
            "sample001.txt.tar.gz.aes"

        The error should include "openssl コマンドがインストールされていません。"
        The status should be failure
    End
End
