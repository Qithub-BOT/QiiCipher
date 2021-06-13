#shellcheck shell=sh

Describe 'archive with miss args'

    It 'should file not found with status non-zero'
        When call "${PATH_DIR_BIN}/archive" \
            "not-exist.txt" \
            "sample001.txt.tar.gz.aes"

        The error should include "圧縮＆暗号化したいファイル not-exist.txt が見つかりません。"
        The status should be failure
    End
End
