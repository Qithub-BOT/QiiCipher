#shellcheck shell=sh

Describe 'dec without required'

    It 'not installed openssl'

# mock for built-in command
type() {
    if [ "$1" = "openssl" ]; then
        return 1
    fi
    return 0
}
        When run source "${PATH_DIR_BIN}/dec" \
            "${PATH_DIR_TEST}/.ssh/openssh/no_pass/id_rsa.pem" \
            "${PATH_DIR_TEST}/data/sample001/sample001.txt.enc" \
            "${PATH_DIR_WORK}/sample001.txt.dec"

        The error should include "openssl コマンドがインストールされていません。"
        The status should be failure
    End

End
