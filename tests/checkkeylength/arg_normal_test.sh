#shellcheck shell=sh

Describe 'checkkeylength with args'
    Mock curl
        cat "${PATH_DIR_TEST}/.ssh/openssh/no_pass/id_rsa.pub"
    End
    It 'should print key length with status 0'
        When call "${PATH_DIR_BIN}/checkkeylength" Qithub-BOT

        The output should include "4096 SHA256:vCih7no5L4xAaAv1MZ7d2NwbccciXA5zU0JQL0xdLUQ your_email@example.com (RSA)"
        The output should include "上記の鍵長を確認してください。"
        The status should be success
    End
End
