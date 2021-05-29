#shellcheck shell=sh

Describe 'check with no arg'
    It 'should print help with status 1'
        When call check
        The output should include "使い方"
        The status should be failure # status is 1-255
    End
End