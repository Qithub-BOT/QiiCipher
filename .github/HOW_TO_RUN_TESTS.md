# How To Run Tests

## 基本テストについて

QiiCipher では、Pull Request されたブランチに `push` があると、以下の 3 種類のテストが自動的に走るように設定されています。最低限、この 3 つのテストをパスしないとレビューされないため、マージもされません。

1. `shfmt`: シェル・スクリプトの構文・文法の [`lint`](https://ja.wikipedia.org/wiki/Lint#%E3%80%8Clint%E3%80%8D%E3%81%AE%E6%B4%BE%E7%94%9F%E7%94%A8%E6%B3%95) チェック
2. `shellcheck`: シェル・スクリプトの[静的解析](https://ja.wikipedia.org/wiki/%E9%9D%99%E7%9A%84%E3%82%B3%E3%83%BC%E3%83%89%E8%A7%A3%E6%9E%90)
3. `shellspec`: シェル・スクリプトの[ユニット・テスト](https://ja.wikipedia.org/wiki/%E5%8D%98%E4%BD%93%E3%83%86%E3%82%B9%E3%83%88)

これらの自動テストは GitHub Actions の Workflow で動かしています。トリガー設定は `on workflow_dispatch`（手動） か `on pull_request`（PR 時の `push`）です。

- [shellcheck_linux.yml](./workflows/shellcheck_linux.yml)（対象 OS: linux）
- [shellspec_linux.yml](./workflows/shellspec_linux.yml)（対象 OS: Linux, macOS）

## Fork 先のリポジトリで実行する

作業ブランチを自分のリポジトリに `push` しておくと、GitHub 上で `Actions` から `push` 済みのコミットを手動で実行できます。

<kbd>![](https://user-images.githubusercontent.com/11840938/121191980-713f4e80-c8a7-11eb-9f2c-a4ca96ead88a.png)</kbd>

- 【注意】自分のリポジトリの `master` に PR（`origin master` への PR）してのテスト実行はお薦めしません。間違えて `master` にマージしてしまうと、本家（`upstream` の `master`）に追随する場合にコンフリクトを起こしやすくなるためです。**`push` するごとにテストを走らせたい**場合は、本家（`upstream` の `master`）に [Draft PR](./.github/HOW_TO_PULL_REQUEST.md#draft-pr-%E3%81%AE%E3%82%B9%E3%82%B9%E3%83%A1) してしまうことをオススメします。

## ローカルでの実行方法

以下のいずれかで、テストを事前にローカルで実行して確認できます。

- ローカルにテスト用のコマンド（後述）をインストールしてテスト・スクリプトを実行する。
- Docker のコンテナ上でテスト・スクリプトを実行する。
- VSCode + Docker の `Remote-Container` 上でテスト・スクリプトを実行する。
    - `../.devcontainer` に VSCode の `Remote-Container` 向けの Dockerfile があります。Alpine Linux ベースです。テストや開発に必要なものが一通り入っています。

### テスト・スクリプト

- [`.github/run-lint.sh`](./run-lint.sh): 構文チェックと静的解析（`shfmt`, `shellcheck`）
- [`.github/run-test.sh`](./run-test.sh): ユニット・テスト（`shellspec`）

### テストに使われるコマンド

各種テストには以下の 3 つのコマンドが使われています。各々 Linux、macOS、Windows の WSL にインストールできるので別途インストールするか、[Docker のコンテナ](../.devcontainer/Dockerfile)をご利用ください。

- `shfmt`（構文・文法チェック）
    - 実行方法: `$ shfmt --help`
    - フォーマット・ルール: [../.editorconfig](../.editorconfig)
    - `shfmt` オフィシャル・サイト
    - 重要
        - 現在は `bash` の構文チェックですが、POSIX 移行中のため `POSIX` 互換でお願いします。
        - リポジトリのルートから `$ shfmt -d -ln=posix ./path/to/your/script.sh` で `POSIX` 準拠か確認できます。
- `shellcheck`（静的解析）
    - シェル・スクリプトの静的解析には `shellcheck` を利用しています。
    - 実行方法: `$ shellcheck --help`
    - 解析ルール: [../.shellcheckrc](../.shellcheckrc)
    - `shellcheck` オフィシャル・サイト
    - 重要
        - 現在は `bash` の構文チェックですが、POSIX 移行中のため `POSIX` 互換でお願いします。
        - リポジトリのルートから `$ shellcheck --shell=sh ./path/to/your/script.sh` で `POSIX` 準拠か確認できます。
- `shellspec`（ユニット・テスト）
    - シェル・スクリプトのユニット・テストには `shellspec` を利用しています。
    - 実行方法: `$ shellspec --help`
    - テスト・ルール: [../.shellspec](../.shellspec)
    - `shellspec` オフィシャル・サイト
