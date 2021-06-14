#shellcheck shell=sh

Describe 'dearchive without openssl installed'

    It 'should print error and exit with status non-zero'

# mock for built-in command
type() {
    if [ "$1" = "openssl" ]; then
        return 1
    fi
    return 0
}
        When run source "${PATH_DIR_BIN}/dearchive" \
            "${PATH_DIR_TEST}/data/sample002/sample002.txt.tar.gz.aes" \
            "${PATH_DIR_WORK}" \
            "${PATH_DIR_TEST}/data/sample002/sample002.txt.tar.gz.aes.passwd.enc" \
            "${PATH_DIR_TEST}/.ssh/openssh/no_pass/id_rsa.pem"

        The error should include "openssl コマンドがインストールされていません。"
        The status should be failure
    End

End
