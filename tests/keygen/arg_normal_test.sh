#shellcheck shell=sh

cleanup() {
    rm -rf "${PATH_DIR_WORK}/.ssh"
}

Describe 'keygen with args'
    After "cleanup"

    It 'should create key pair with status 0'
        When call env HOME="${PATH_DIR_WORK}" "${PATH_DIR_BIN}/keygen" qiiciper@example.com testkey

        The output should include "This is the generated pubkey"
        The status should be successful

        Path file_private="${PATH_DIR_WORK}/.ssh/testkey"
        The path file_private should be exist

        Path file_public="${PATH_DIR_WORK}/.ssh/testkey.pub"
        The path file_public should be exist
    End
End
