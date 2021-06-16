#shellcheck shell=sh

Describe 'sign with miss args'

    It 'should input file not found with status non-zero'
        Mock curl
            exit 1
        End
        When call "${PATH_DIR_BIN}/sign" \
            Qithub-BOT \
            "${PATH_DIR_TEST}/.ssh/openssh/no_pass/id_rsa.pem" \
            "not-exist.txt" \
            "${PATH_DIR_WORK}/sample001.txt.sig"

        The error should include "署名したいファイル not-exist.txt が見つかりません。"
        The status should be failure
    End

    It 'should private key not found with status non-zero'
        Mock curl
            exit 1
        End
        When call "${PATH_DIR_BIN}/sign" \
            Qithub-BOT \
            "not-exist.txt" \
            "${PATH_DIR_TEST}/data/sample001/sample001.txt" \
            "${PATH_DIR_WORK}/sample001.txt.sig"

        The error should include "秘密鍵ファイル not-exist.txt が見つかりません。"
        The status should be failure
    End

    It 'should be invalid private key with status non-zero'
        Mock curl
            cat "${PATH_DIR_TEST}/.ssh/openssh/no_pass/id_rsa.pub"
        End
        When call "${PATH_DIR_BIN}/sign" \
            Qithub-BOT \
            "${PATH_DIR_TEST}/.ssh/openssh/no_pass/id_rsa.pub" \
            "${PATH_DIR_TEST}/data/sample001/sample001.txt" \
            "${PATH_DIR_WORK}/sample001.txt.sig"

        The error should include "秘密鍵ファイル ${PATH_DIR_TEST}/.ssh/openssh/no_pass/id_rsa.pub がサポートしていないフォーマットです。"
        The status should be failure
    End

    It 'should not be able to get the public key with status non-zero'
        Mock curl
            # invalid user name
            exit 1
        End

        When call "${PATH_DIR_BIN}/sign" \
            Qithub-BOT-NOT-EXIST \
            "${PATH_DIR_TEST}/.ssh/openssh/no_pass/id_rsa.pem" \
            "${PATH_DIR_TEST}/data/sample001/sample001.txt" \
            "${PATH_DIR_WORK}/sample001.txt.sig"

        The output should include "Qithub-BOT-NOT-EXIST の GitHub 上の公開鍵を取得中 ... "
        The error should include "NG：公開鍵を取得できませんでした。"
        The status should be failure
    End

    It 'should be empty the public key with status non-zero'
        Mock curl
            # empty public key
            exit 0
        End

        When call "${PATH_DIR_BIN}/sign" \
            Qithub-BOT-EMPTY \
            "${PATH_DIR_TEST}/.ssh/openssh/no_pass/id_rsa.pem" \
            "${PATH_DIR_TEST}/data/sample001/sample001.txt" \
            "${PATH_DIR_WORK}/sample001.txt.sig"

        The output should include "Qithub-BOT-EMPTY の GitHub 上の公開鍵を取得中 ... "
        The error should include "NG：公開鍵が存在しませんでした"
        The status should be failure
    End

End
