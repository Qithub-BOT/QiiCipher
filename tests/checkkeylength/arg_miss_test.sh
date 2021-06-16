#shellcheck shell=sh

Describe 'checkkeylength with miss args'

    It 'should not be able to get the public key with status non-zero'
        Mock curl
            # invalid user name
            exit 1
        End

        When call "${PATH_DIR_BIN}/checkkeylength" \
            Qithub-BOT-NOT-EXIST

        The output should include "Qithub-BOT-NOT-EXIST の GitHub 上の公開鍵を取得中 ... "
        The error should include "NG：公開鍵を取得できませんでした。"
        The status should be failure
    End

    It 'should be empty the public key with status non-zero'
        Mock curl
            # empty public key
            exit 0
        End

        When call "${PATH_DIR_BIN}/checkkeylength" \
            Qithub-BOT-EMPTY

        The output should include "Qithub-BOT-EMPTY の GitHub 上の公開鍵を取得中 ... "
        The error should include "NG：公開鍵が存在しませんでした"
        The status should be failure
    End

End
