#shellcheck shell=sh

cleanup() {
    rm -f "${PATH_DIR_WORK}/sample001.txt.sig"
}

Describe 'sign with args'
    After "cleanup"

    Mock curl
        cat "${PATH_DIR_TEST}/.ssh/openssh/no_pass/id_rsa.pub"
    End

    It 'should sign result with status 0'
        When call "${PATH_DIR_BIN}/sign" Qithub-BOT "${PATH_DIR_TEST}/.ssh/openssh/no_pass/id_rsa.pem" "${PATH_DIR_TEST}/data/sample001/sample001.txt" "${PATH_DIR_WORK}/sample001.txt.sig"

        The output should include "署名を完了しました。"
        The status should be success

        Path file_enc="${PATH_DIR_WORK}/sample001.txt.sig"
        The path file_enc should be exist
    End
End
