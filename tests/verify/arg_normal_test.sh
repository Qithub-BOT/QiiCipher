#shellcheck shell=sh

Describe 'verify with args'
    Mock curl
        cat "${PATH_DIR_TEST}/.ssh/openssh/no_pass/id_rsa.pub"
    End
    It 'should print "no problem" with status 0'
        When call "${PATH_DIR_BIN}/verify" "${PATH_DIR_TEST}/.ssh/openssh/test_data/private_data" Qithub-BOT "${PATH_DIR_TEST}/.ssh/openssh/test_data/private_data.sig"

        The output should include "このファイルは正しく署名されています。"
        The status should be success
    End
End
