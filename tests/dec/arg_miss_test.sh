#shellcheck shell=sh

Describe 'dec with miss args'

    It 'should input file not found with status non-zero'
        When call "${PATH_DIR_BIN}/dec" \
            "${PATH_DIR_TEST}/.ssh/openssh/no_pass/id_rsa.pem" \
            "not-exist.txt" \
            "${PATH_DIR_WORK}/sample001.txt.dec"

        The error should include "暗号化されたファイル not-exist.txt が見つかりません。"
        The status should be failure
    End

    It 'should private key not found with status non-zero'
        When call "${PATH_DIR_BIN}/dec" \
            "not-exist.txt" \
            "${PATH_DIR_TEST}/data/sample001/sample001.txt.enc" \
            "${PATH_DIR_WORK}/sample001.txt.dec"

        The error should include "秘密鍵ファイル not-exist.txt が見つかりません。"
        The status should be failure
    End

    It 'should be invalid private key with status non-zero'
        When call "${PATH_DIR_BIN}/dec" \
            "${PATH_DIR_TEST}/.ssh/openssh/no_pass/id_rsa.pub" \
            "${PATH_DIR_TEST}/data/sample001/sample001.txt.enc" \
            "${PATH_DIR_WORK}/sample001.txt.dec"

        The error should include "秘密鍵ファイル ${PATH_DIR_TEST}/.ssh/openssh/no_pass/id_rsa.pub がサポートしていないフォーマットです。"
        The status should be failure
    End

End
