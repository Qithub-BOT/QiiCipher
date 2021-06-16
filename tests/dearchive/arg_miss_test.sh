#shellcheck shell=sh

Describe 'dearchive with miss args'

    It 'should input file not found with status non-zero'
        When call "${PATH_DIR_BIN}/dearchive" \
            "not-exist.txt" \
            "${PATH_DIR_WORK}" \
            "${PATH_DIR_TEST}/data/sample002/sample002.txt.tar.gz.aes.passwd"

        The error should include "復号＆解凍したいファイル not-exist.txt が見つかりません。"
        The status should be failure
    End

    It 'should password file not found with status non-zero'
        When call "${PATH_DIR_BIN}/dearchive" \
            "${PATH_DIR_TEST}/data/sample002/sample002.txt.tar.gz.aes" \
            "${PATH_DIR_WORK}" \
            "not-exist.txt"

        The error should include "パスワードファイル not-exist.txt が見つかりません。"
        The status should be failure
    End

    It 'should private key not found with status non-zero'
        When call "${PATH_DIR_BIN}/dearchive" \
            "${PATH_DIR_TEST}/data/sample002/sample002.txt.tar.gz.aes" \
            "${PATH_DIR_WORK}" \
            "${PATH_DIR_TEST}/data/sample002/sample002.txt.tar.gz.aes.passwd.enc" \
            "not-exist.txt"

        The error should include "秘密鍵ファイル not-exist.txt が見つかりません。"
        The status should be failure
    End

    It 'should be invalid private key with status non-zero'
        When call "${PATH_DIR_BIN}/dearchive" \
            "${PATH_DIR_TEST}/data/sample002/sample002.txt.tar.gz.aes" \
            "${PATH_DIR_WORK}" \
            "${PATH_DIR_TEST}/data/sample002/sample002.txt.tar.gz.aes.passwd.enc" \
            "${PATH_DIR_TEST}/.ssh/openssh/no_pass/id_rsa.pub"

        The error should include "秘密鍵ファイル ${PATH_DIR_TEST}/.ssh/openssh/no_pass/id_rsa.pub がサポートしていないフォーマットです。"
        The status should be failure
    End

End
