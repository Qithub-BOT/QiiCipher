#shellcheck shell=sh

Describe 'verify with miss args'

    It 'should input file not found with status non-zero'
        When call "${PATH_DIR_BIN}/verify" \
            "not-exist.txt" \
            Qithub-BOT \
            "${PATH_DIR_TEST}/data/sample001/sample001.txt.sig"

        The error should include "確認したいファイル not-exist.txt が見つかりません。"
        The status should be failure
    End

    It 'should signature file not found with status non-zero'
        When call "${PATH_DIR_BIN}/verify" \
            "${PATH_DIR_TEST}/data/sample001/sample001.txt" \
            Qithub-BOT \
            "not-exist.txt"

        The error should include "電子署名ファイル not-exist.txt が見つかりません。"
        The status should be failure
    End

    It 'should not be able to get the public key with status non-zero'
        Mock curl
            # invalid user name
            exit 1
        End

        When call "${PATH_DIR_BIN}/verify" \
            "${PATH_DIR_TEST}/data/sample001/sample001.txt" \
            Qithub-BOT-NOT-EXIST \
            "${PATH_DIR_TEST}/data/sample001/sample001.txt.sig"

        The output should include "Qithub-BOT-NOT-EXIST の GitHub 上の公開鍵を取得中 ... "
        The error should include "NG：公開鍵を取得できませんでした。"
        The status should be failure
    End

    It 'should be empty the public key with status non-zero'
        Mock curl
            # empty public key
            exit 0
        End

        When call "${PATH_DIR_BIN}/verify" \
            "${PATH_DIR_TEST}/data/sample001/sample001.txt" \
            Qithub-BOT-EMPTY \
            "${PATH_DIR_TEST}/data/sample001/sample001.txt.sig"

        The output should include "Qithub-BOT-EMPTY の GitHub 上の公開鍵を取得中 ... "
        The error should include "NG：公開鍵が存在しませんでした"
        The status should be failure
    End

End
