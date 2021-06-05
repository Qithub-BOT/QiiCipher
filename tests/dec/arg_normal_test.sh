#shellcheck shell=sh

file_compare() {
    cmp -s \
        "${PATH_DIR_WORK}/private_data.dec" \
        "${PATH_DIR_TEST}/.ssh/openssh/test_data/private_data" \
        && echo "successful" || echo "failure"
}

cleanup() {
    rm -f "${PATH_DIR_WORK}/private_data.dec"
}

Describe 'dec with args'
    After "cleanup"

    It 'should make decrypt with status 0'
        When call "${PATH_DIR_BIN}/dec" "${PATH_DIR_TEST}/.ssh/openssh/no_pass/id_rsa.pem" "${PATH_DIR_TEST}/.ssh/openssh/test_data/private_data.enc" "${PATH_DIR_WORK}/private_data.dec"

        The output should include "ファイルを復号しました。"
        The status should be successful

        Path file_enc="${PATH_DIR_WORK}/private_data.dec"
        The path file_enc should be exist

        The result of "file_compare()" should equal "successful"
    End
End
