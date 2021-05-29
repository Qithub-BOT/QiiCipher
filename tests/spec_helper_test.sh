#shellcheck shell=sh

# Simple example of shellspec usage
Describe 'echo command'
    It 'should print ok'
        When call echo 'ok'
        The output should eq 'ok'
    End
End

# テスト中に使われるグローバル変数のテスト
Describe 'Global Variable'
    It 'check PATH_DIR_REPO is defined and a valid path'
        The value "$PATH_DIR_REPO" should be defined
        The path "$PATH_DIR_REPO" should be exist
    End
    It 'check PATH_DIR_BIN is defined and a valid path'
        The value "$PATH_DIR_BIN" should be defined
        The path "$PATH_DIR_BIN" should be exist
    End
    It 'check PATH_DIR_TEST is defined and a valid path'
        The value "$PATH_DIR_TEST" should be defined
        The path "$PATH_DIR_TEST" should be exist
    End
End
