#shellcheck shell=sh

Describe 'verify without required'

    It 'not installed openssl'

# mock for built-in command
type() {
    if [ "$1" = "openssl" ]; then
        return 1
    fi
    return 0
}
        When run source "${PATH_DIR_BIN}/verify" \
            "${PATH_DIR_TEST}/data/sample001/sample001.txt" \
            Qithub-BOT \
            "${PATH_DIR_TEST}/data/sample001/sample001.txt.sig"

        The error should include "openssl コマンドがインストールされていません。"
        The status should be failure
    End

    It 'not installed openssh'

# mock for built-in command
type() {
    if [ "$1" = "ssh-keygen" ]; then
        return 1
    fi
    return 0
}
        When run source "${PATH_DIR_BIN}/verify" \
            "${PATH_DIR_TEST}/data/sample001/sample001.txt" \
            Qithub-BOT \
            "${PATH_DIR_TEST}/data/sample001/sample001.txt.sig"

        The error should include "ssh-keygen コマンド(openssh)がインストールされていません。"
        The status should be failure
    End

End
