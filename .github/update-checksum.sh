#!/bin/sh
# =============================================================================
#  Update CheckSUM
# =============================================================================
#  このスクリプトは bin ディレクトリの各コマンドの SHA512 ハッシュの値を checksum.sha512
#  に出力するスクリプトです。署名はされません。

# -----------------------------------------------------------------------------
#  Constants
# -----------------------------------------------------------------------------
SUCCESS=0
FAILURE=1
LIST_SCRIPT_BIN="archive check dec enc keygen sign verify checkkeylength dearchive"
NAME_FILE_CHECKSUM="checksum.sha512"

PATH_DIR_REPO="$(dirname "$(cd "$(dirname "$0")" && pwd)")"
PATH_DIR_RETURN="$(cd . && pwd)"
PATH_DIR_BIN="${PATH_DIR_REPO}/bin"
PATH_FILE_CHECKSUM="${PATH_DIR_BIN}/${NAME_FILE_CHECKSUM}"

# -----------------------------------------------------------------------------
#  Setup
# -----------------------------------------------------------------------------
cd "$PATH_DIR_BIN" || {
    echo >&2 "ディレクトリの移動に失敗しました。bin ディレクトリに移動できません。"

    exit $FAILURE
}
trap 'cd "$PATH_DIR_RETURN"' 0

# -----------------------------------------------------------------------------
#  Function
# -----------------------------------------------------------------------------
# appendChecksum は LIST_SCRIPT_BIN
appendChecksum() {
    # shellcheck disable=SC2086
    set -- $LIST_SCRIPT_BIN

    # LIST_SCRIPT_BIN のループごとにチェックサムを追記
    while [ "${1:+none}" ]; do
        path_file_target="${1}"

        if [ ! -r "$path_file_target" ]; then
            echo >&2 "圧縮＆暗号化したいファイル ${path_file_target} が見つかりません。"

            return $FAILURE
        fi

        # ハッシュ値を取得
        hashCurrent="$(openssl sha512 "$path_file_target" 2>&1)" || {
            echo >&2 "ファイルのハッシュ値取得に失敗しました。ファイル: ${path_file_target}"
            echo >&2 "$hashCurrent"

            return $FAILURE
        }

        # 更新（追記）
        echo "$hashCurrent" >>"$PATH_FILE_CHECKSUM"

        shift
    done

    return $SUCCESS
}

verifyChecksum() {
    result=$(sha512sum -c "$PATH_FILE_CHECKSUM") || {
        echo >&2 "$result"

        return $FAILURE
    }

    return $SUCCESS
}

# -----------------------------------------------------------------------------
#  Main
# -----------------------------------------------------------------------------
# チェックサムファイルの初期化
cat /dev/null >"$PATH_FILE_CHECKSUM"

# ハッシュ値の更新
printf "%s" "- ハッシュ値を更新します ... "
appendChecksum || {
    echo >&2 "* エラー：ハッシュ値の更新に失敗しました。"

    exit $FAILURE
}
echo 'OK'

# ハッシュ値の照合
printf "%s" "- ハッシュ値を照合します ... "
verifyChecksum || {
    echo >&2 "* エラー：ハッシュ値の照合に失敗しました。"

    exit $FAILURE
}
echo 'OK'

echo 'OK: チェックサム用のハッシュ値の更新が完了しました。'
