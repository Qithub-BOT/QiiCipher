#shellcheck shell=sh

Describe 'sign with unexisting key'
    name_file_to_sign="dummy.txt"
    path_file_sig_out="${SHELLSPEC_TMPDIR}/${name_file_to_sign}.sig"

    It 'should print err with status 1 and should not create .enc file'
        When call "${PATH_DIR_BIN}"/sign KEINOS '/path/to/unknown/key.pub' "$name_file_to_sign" "$path_file_sig_out"

        The stdout should include '署名ファイルを生成できませんでした'
        The stderr should include 'No such file or directory'
        The status should be failure # status is 1-255

        Path file_sig="$path_file_sig_out"
        The path file_sig should not be exist
    End
End
