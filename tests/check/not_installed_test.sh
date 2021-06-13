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
        When run source "${PATH_DIR_BIN}/check" \
            Qithub-BOT \
            "${PATH_DIR_TEST}/.ssh/openssh/no_pass/id_rsa.pem"

        The error should include "openssl コマンドがインストールされていません。"
        The status should be failure
    End

End
