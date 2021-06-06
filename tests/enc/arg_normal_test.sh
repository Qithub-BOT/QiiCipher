#shellcheck shell=sh

file_compare() {
    openssl rsautl -decrypt \
        -inkey "${PATH_DIR_TEST}/.ssh/openssh/no_pass/id_rsa.pem" \
        -in "${PATH_DIR_WORK}/sample001.txt.enc" \
        -out "${PATH_DIR_WORK}/sample001.txt.dec"
    cmp -s \
        "${PATH_DIR_WORK}/sample001.txt.dec" \
        "${PATH_DIR_TEST}/data/sample001/sample001.txt" \
        && echo "successful" || echo "failure"
}

cleanup() {
    rm -f "${PATH_DIR_WORK}/sample001.txt.enc" "${PATH_DIR_WORK}/sample001.txt.dec"
}

Describe 'enc with args'
    After "cleanup"

    Mock curl
        cat "${PATH_DIR_TEST}/.ssh/openssh/no_pass/id_rsa.pub"
    End

    It 'should make crypt with status 0'
        When call "${PATH_DIR_BIN}/enc" Qithub-BOT "${PATH_DIR_TEST}/data/sample001/sample001.txt" "${PATH_DIR_WORK}/sample001.txt.enc"

        The output should include "暗号化を完了しました。"
        The status should be success

        Path file_enc="${PATH_DIR_WORK}/sample001.txt.enc"
        The path file_enc should be exist

        The result of "file_compare()" should equal "successful"
    End
End
