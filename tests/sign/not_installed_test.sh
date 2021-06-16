#shellcheck shell=sh

Describe 'sign without required command'

    It 'should print error openssl is missing and exit with status non-zero'

# mock for built-in command
type() {
    if [ "$1" = "openssl" ]; then
        return 1
    fi
    return 0
}
        When run source "${PATH_DIR_BIN}/sign" \
            Qithub-BOT \
            "${PATH_DIR_TEST}/.ssh/openssh/no_pass/id_rsa.pem" \
            "${PATH_DIR_TEST}/data/sample001/sample001.txt" \
            "${PATH_DIR_WORK}/sample001.txt.sig"

        The error should include "openssl コマンドがインストールされていません。"
        The status should be failure
    End

    It 'should print error ssh-keygen is missing and exit with status non-zero'

# mock for built-in command
type() {
    if [ "$1" = "ssh-keygen" ]; then
        return 1
    fi
    return 0
}
        When run source "${PATH_DIR_BIN}/sign" \
            Qithub-BOT \
            "${PATH_DIR_TEST}/.ssh/openssh/no_pass/id_rsa.pem" \
            "${PATH_DIR_TEST}/data/sample001/sample001.txt" \
            "${PATH_DIR_WORK}/sample001.txt.sig"

        The error should include "ssh-keygen コマンド(openssh)がインストールされていません。"
        The status should be failure
    End

End
