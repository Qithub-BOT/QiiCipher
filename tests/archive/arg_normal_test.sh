#shellcheck shell=sh

cleanup() {
    rm -rf "${PATH_DIR_REPO}/sample001.txt-archive"
}

Describe 'archive with args'
    After "cleanup"

    It 'should create archive file with status 0'
        When call "${PATH_DIR_BIN}/archive" "${PATH_DIR_TEST}/data/sample001/sample001.txt" "sample001.txt.tar.gz.aes"

        The output should include "ファイルの圧縮・暗号化が完了しました。"
        The error should include "deprecated key derivation used." # TODO
        The status should be success

        Path file_archive="${PATH_DIR_REPO}/sample001.txt-archive/sample001.txt.tar.gz.aes"
        The path file_archive should be exist

        Path file_password="${PATH_DIR_REPO}/sample001.txt-archive/sample001.txt.tar.gz.aes.passwd"
        The path file_password should be exist

    End
End
