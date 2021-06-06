#shellcheck shell=sh

cleanup() {
    rm -rf "${PATH_DIR_REPO}/private_data-archive"
}

Describe 'archive with args'
    After "cleanup"

    It 'should create archive file with status 0'
        When call "${PATH_DIR_BIN}/archive" "${PATH_DIR_TEST}/.ssh/openssh/test_data/private_data"

        The output should include "ファイルの圧縮・暗号化が完了しました。"
        The error should include "deprecated key derivation used." # TODO
        The status should be success

        Path file_archive="${PATH_DIR_REPO}/private_data-archive/private_data.tar.gz.aes"
        The path file_archive should be exist

        Path file_password="${PATH_DIR_REPO}/private_data-archive/private_data.tar.gz.aes.passwd"
        The path file_password should be exist

    End
End
