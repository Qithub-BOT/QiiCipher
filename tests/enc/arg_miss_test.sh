#shellcheck shell=sh

Describe 'enc with miss args'

    It 'should file not found with status non-zero'
        Mock curl
            exit 1
        End
        When call "${PATH_DIR_BIN}/enc" \
            Qithub-BOT \
            "not-exist.txt" \
            "${PATH_DIR_WORK}/sample001.txt.enc"

        The error should include "暗号化したいファイル not-exist.txt が見つかりません。"
        The status should be failure
    End

    It 'should not be able to get the public key with status non-zero'
        Mock curl
            # invalid user name
            exit 1
        End

        When call "${PATH_DIR_BIN}/enc" \
            Qithub-BOT-NOT-EXIST \
            "${PATH_DIR_TEST}/data/sample001/sample001.txt" \
            "${PATH_DIR_WORK}/sample001.txt.enc"

        The output should include "Qithub-BOT-NOT-EXIST の GitHub 上の公開鍵を取得中 ... "
        The error should include "NG：公開鍵を取得できませんでした。"
        The status should be failure
    End

    It 'should be empty the public key with status non-zero'
        Mock curl
            # empty public key
            exit 0
        End

        When call "${PATH_DIR_BIN}/enc" \
            Qithub-BOT-EMPTY \
            "${PATH_DIR_TEST}/data/sample001/sample001.txt" \
            "${PATH_DIR_WORK}/sample001.txt.enc"

        The output should include "Qithub-BOT-EMPTY の GitHub 上の公開鍵を取得中 ... "
        The error should include "NG：公開鍵が存在しませんでした"
        The status should be failure
    End

End
