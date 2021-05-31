#shellcheck shell=bash

Describe 'enc with no arg'
    It 'should print help with status 1'
        When call enc
        The output should include "使い方"
        The status should be failure # status is 1-255
    End
End

Describe 'encrypt a text file'
    # テスト用ダミー公開・秘密鍵
    path_file_key_public="tests/.ssh/openssh/no_pass/id_rsa.pub"
    path_file_key_secret="tests/.ssh/openssh/no_pass/id_rsa"

    # 暗号化済みファイルと復号ファイルの保存先
    stamp_time="$SHELLSPEC_UNIXTIME"
    path_file_enced="${SHELLSPEC_TMPDIR}/sample_enc.${stamp_time}.txt.enc"
    path_file_actual="${SHELLSPEC_TMPDIR}/sample_enc.${stamp_time}.txt"

    # ターゲットファイル（暗号化するファイルと復号後の比較ファイル）
    path_file_expect="tests/enc/sample.txt"

    # enc コマンド内の cURL のモック
    Mock curl
        # テスト用のダミー公開鍵のパス
        cat "$path_file_key_public"
    End

    It 'should create an enc file'
        # 暗号化
        When run enc KEINOS "$path_file_expect" "$path_file_enced"

        The output should include "暗号化を完了しました。このファイルを相手に送ってください。"
        The stderr should include "$(pwd)"
        The path "$path_file_enced" should be exist
    End
End
