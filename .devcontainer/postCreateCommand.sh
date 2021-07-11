#!/bin/bash
# =============================================================================
#  postCreateCommand for devcontainer.json
# =============================================================================
#  このファイルは Dev Container がビルドされた後、コンテナ内で実行されるスクリプトです。

PATH_DIR_ROOT_REPO="$(dirname "$(cd "$(dirname "$0")" && pwd)")"
PATH_FILE_WELCOME="${PATH_DIR_ROOT_REPO}/.devcontainer/welcome_msg.sh"
PATH_FILE_LINT="${PATH_DIR_ROOT_REPO}/.github/run-lint.sh"
PATH_FILE_TEST="${PATH_DIR_ROOT_REPO}/.github/run-test.sh"

# カレント・ユーザの .bashrc に追記
{
    # コマンドのエイリアス
    echo "alias welcome='${PATH_FILE_WELCOME}'"
    echo "alias run-lint='${PATH_FILE_LINT}'"
    echo "alias run-test='${PATH_FILE_TEST}'"

    # ウェルカム・メッセージの表示
    echo "$PATH_FILE_WELCOME"

    # リポジトリのルートディレクトリのパスを環境変数にセット
    # shellcheck disable=SC2016
    echo "export PATH_DIR_ROOT_REPO=\"${PATH_DIR_ROOT_REPO}\""
} >>"${HOME}/.bashrc"
