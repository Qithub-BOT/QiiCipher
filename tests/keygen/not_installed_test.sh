#shellcheck shell=sh

Describe 'keygen without openssl installed'

    It 'should print error and exit with status non-zero'

# mock for built-in command
type() {
    if [ "$1" = "ssh-keygen" ]; then
        return 1
    fi
    return 0
}
        When run source "${PATH_DIR_BIN}/keygen" qiiciper@example.com testkey

        The error should include "ssh-keygen コマンド(openssh)がインストールされていません。"
        The status should be failure
    End

End
