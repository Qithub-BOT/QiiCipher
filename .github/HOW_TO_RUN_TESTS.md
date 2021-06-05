# テストについて

## TL; DR <sub><sup><sub><sup>（今北産業）</sup></sub></sup></sub>

1. QiiCipher では、Pull Request されたブランチに `push` があると、以下の 3 種類のテストが自動的に走るように設定されています。最低限、この 3 つのテストをパスしないとレビューされないため、マージもされません。
    1. `shfmt`: シェル・スクリプトの構文・文法チェック（ [./workflows/shellcheck_linux.yml](./workflows/shellcheck_linux.yml) ）
    2. `shellcheck`: シェル・スクリプトの静的解析（ [./workflows/shellcheck_linux.yml](./workflows/shellcheck_linux.yml) ）
    3. `shellspec`: シェル・スクリプトのユニット・テスト（ [./workflows/shellspec_linux.yml](./workflows/shellcheck_linux.yml) ）

2. `../.devcontainer` に VSCode の `Remote-Container` 向けの Dockerfile があります。Alpine Linux ベースです。テストや開発に必要なものが一通り入っています。
3. `.github` ディレクトリにある `./run-lint.sh` の実行で構文チェックと静的解析、`./run-test.sh` の実行でユニット・テストを走らせることができます。（相対パスでの実行対応しています）

## TS; DR

### テストに使われるコマンドについて

各種テストには以下のコマンドが使われています。各々 Linux、macOS、Windows の WSL にインストールできるので、別途インストールしてください。

ローカルにインストールしづらい場合は `.devcontainer` ディレクトリに Dockerfile を用意しました。

#### `shfmt`（構文・文法チェック）

シェル・スクリプトの `linter` には `shfmt` を利用しています。

- 実行方法: `$ shfmt --help`
- フォーマット・ルール: [../.editorconfig](../.editorconfig)
- `shfmt` オフィシャル・サイト
- 重要
    - 現在は `bash` の構文チェックですが、POSIX 移行中のため `POSIX` 互換でお願いします。
    - リポジトリのルートから `$ shfmt -d -ln=posix ./path/to/your/script.sh` で `POSIX` 準拠か確認できます。

#### `shellcheck`（静的解析）

シェル・スクリプトの静的解析には `shellcheck` を利用しています。

- 実行方法: `$ shellcheck --help`
- 解析ルール: [../.shellcheckrc](../.shellcheckrc)
- `shellcheck` オフィシャル・サイト
- 重要
    - 現在は `bash` の構文チェックですが、POSIX 移行中のため `POSIX` 互換でお願いします。
    - リポジトリのルートから `$ shellcheck --shell=sh ./path/to/your/script.sh` で `POSIX` 準拠か確認できます。

#### `shellspec`（ユニット・テスト）

シェル・スクリプトのユニット・テストには `shellspec` を利用しています。

- 実行方法: `$ shellspec --help`
- テスト・ルール: [../.shellspec](../.shellspec)
- `shellspec` オフィシャル・サイト

### ユニット・テストについて

QiiCipher では TDD にチャレンジしております。

つまり、実装前に「期待する出力結果をチェックする」テストを先に作成し、（未実装なので）テストが失敗する状態から徐々に実装していく、という手法です。

コマンド内の関数ごとのテストを作るか、コマンド自体のテストを作るかは決まっていません。しかし、不具合報告があった場合に「現象が再現するテスト」を作成してから

