#shellcheck shell=sh

Describe 'check with miss args'

    It 'should file not found with status non-zero'
        When call "${PATH_DIR_BIN}/check" \
            Qithub-BOT \
            "not-exist.txt"

        The error should include "秘密鍵ファイル not-exist.txt が見つかりません。"
        The status should be failure
    End

    It 'should be invalid private key with status non-zero'
        Mock curl
            cat "${PATH_DIR_TEST}/.ssh/openssh/no_pass/id_rsa.pub"
        End
        When call "${PATH_DIR_BIN}/check" \
            Qithub-BOT \
            "${PATH_DIR_TEST}/.ssh/openssh/no_pass/id_rsa.pub"

        The error should include "秘密鍵ファイル ${PATH_DIR_TEST}/.ssh/openssh/no_pass/id_rsa.pub がサポートしていないフォーマットです。"
        The status should be failure
    End

    It 'should not be able to get the public key with status non-zero'
        Mock curl
            # invalid user name
            exit 1
        End

        When call "${PATH_DIR_BIN}/check" \
            Qithub-BOT-NOT-EXIST \
            "${PATH_DIR_TEST}/.ssh/openssh/no_pass/id_rsa.pem"

        The output should include "サンプル・ファイルを暗号化しています"
        The error should include "NG：公開鍵を取得できませんでした。"
        The status should be failure
    End

    It 'should be empty the public key with status non-zero'
        Mock curl
            # empty public key
            exit 0
        End

        When call "${PATH_DIR_BIN}/check" \
            Qithub-BOT-EMPTY \
            "${PATH_DIR_TEST}/.ssh/openssh/no_pass/id_rsa.pem"

        The output should include "サンプル・ファイルを暗号化しています"
        The error should include "NG：公開鍵が存在しませんでした"
        The status should be failure
    End

End
