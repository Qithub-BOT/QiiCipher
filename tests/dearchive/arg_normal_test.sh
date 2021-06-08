#shellcheck shell=sh

file_compare() {
    cmp -s \
        "${PATH_DIR_WORK}/sample002.txt" \
        "${PATH_DIR_TEST}/data/sample002/sample002.txt" \
        && echo "successful" || echo "failure"
}

cleanup() {
    rm -f "${PATH_DIR_WORK}/sample002.txt"
}

Describe 'dearchive with raw password'
    After "cleanup"

    It 'should dearchive file with status 0'
        When call "${PATH_DIR_BIN}/dearchive" \
            "${PATH_DIR_TEST}/data/sample002/sample002.txt.tar.gz.aes" \
            "${PATH_DIR_WORK}" \
            "${PATH_DIR_TEST}/data/sample002/sample002.txt.tar.gz.aes.passwd"

        The output should include "共通鍵でファイルを復号しています ... OK"
        The error should include "deprecated key derivation used." # TODO
        The status should be success
    End
End

Describe 'dearchive with encrypted password'
    After "cleanup"

    It 'should dearchive file with status 0'
        When call "${PATH_DIR_BIN}/dearchive" \
            "${PATH_DIR_TEST}/data/sample002/sample002.txt.tar.gz.aes" \
            "${PATH_DIR_WORK}" \
            "${PATH_DIR_TEST}/data/sample002/sample002.txt.tar.gz.aes.passwd.enc" \
            "${PATH_DIR_TEST}/.ssh/openssh/no_pass/id_rsa.pem"

        The output should include "ファイルを復号しました。"
        The output should include "共通鍵でファイルを復号しています ... OK"
        The error should include "deprecated key derivation used." # TODO
        The status should be success
    End
End
