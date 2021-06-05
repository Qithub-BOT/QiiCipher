#shellcheck shell=sh

Describe 'check with args'
    Mock curl
        cat "${PATH_DIR_TEST}/.ssh/openssh/no_pass/id_rsa.pub"
    End
    It 'should print "no problem" with status 0'
        When call "${PATH_DIR_BIN}/check" Qithub-BOT "${PATH_DIR_TEST}/.ssh/openssh/no_pass/id_rsa.pem"

        The output should include "問題なさそうです。"
        The status should be successful
    End
End
