#shellcheck shell=sh

Describe 'checkkeylength with no arg'
    It 'should print help with status 1'
        When call "${PATH_DIR_BIN}/checkkeylength"

        The output should include "使い方"
        The status should be failure # status is 1-255
    End
End
