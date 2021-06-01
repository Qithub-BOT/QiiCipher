<img title="QiiCipher ロゴ" src="https://github.com/Qithub-BOT/QiiCipher/raw/master/images/logo.jpg" width="838px">

# QiiCipher

GitHub 上の公開鍵を使ってファイルの暗号化と署名確認、ローカルの秘密鍵で復号や署名をするシェル・スクリプトです。

[![参加ポリシー](http://img.shields.io/badge/policy-Qithub%203原則-blue.svg)](https://github.com/Qithub-BOT/Qithub-ORG) ![License](https://img.shields.io/badge/license-CC%20BY--SA%204.0-brightgreen.svg) ![日本語ドキュメント](https://img.shields.io/badge/document-ja-brightgreen.svg) ![日本語コミットメッセージ](https://img.shields.io/badge/Commit%20message-ja-brightgreen.svg) ![日本語ソース内コメント](https://img.shields.io/badge/code%20comment-ja-brightgreen.svg)

---

QiiCipher で使えるコマンドは以下の通りです。

|機能|コマンド|使用例|
|:---|:--:|:---|
|暗号化（Encrypt）|`enc`|`$ ./enc KEINOS himitsu.txt`|
|アーカイブ＆暗号化（Archive）|`archive`|[WIP](https://github.com/Qithub-BOT/QiiCipher/blob/master/bin/archive)|
|復号（Decrypt）|`dec`|`$ ./dec ~/.ssh/id_rsa himitsu.txt.enc himitsu.txt`|
|復号＆解凍（DeArchive）|`dearchive`|[WIP](https://github.com/Qithub-BOT/QiiCipher/blob/master/bin/dearchive)|
|動作確認（Check）|`check`|`$ ./check KEINOS ~/.ssh/id_rsa`|
|電子署名（Sign）|`sign`|`$ ./sign KEINOS ~/.ssh/id_rsa himitsu.txt`|
|署名の確認（Verify）|`verify`|`$ ./verify himitsu.txt KEINOS himitsu.txt.sig`|

## Usage

- いずれのスクリプトも引数がない場合はヘルプが表示されます。（例：`$ ./enc`でヘルプ表示）
- 実行前に、ダウンロードしたスクリプト・ファイルのハッシュ値（`SHA512`）と、チェックサムが同じであることを確認してください。
- 実行権限を与えるのを忘れないでください。（例：`chmod 0744 ./enc`）
- ダウンロードしたスクリプト・ファイルを別名保存した場合は、各構文内のスクリプト名も置き換えてください。（`enc.sh`としてダウンロードした場合 `$ ./enc` -> `$ ./enc.sh`）
- 動作確認済み OS と環境はページ下部に記載しています。


### 暗号化スクリプト（`enc.sh`）

このシェル・スクリプトは GitHub 上の公開鍵一覧(`https://github.com/<gihub user>.keys`)から一番最初の公開鍵を使い暗号化ファイルを作成します。

#### 構文

```shellsession
$ ./enc <github user> <input file> [<output file>]
```

##### 引数

- `<github user>`：相手の GitHub アカウント名。（`@KEINOS@GitHub` の場合は `KEINOS`）
- `<input file>` ：暗号化したいファイルのパス。

##### オプション

- `<output file>`：暗号化されたファイルの保存先のパス。指定されていない場合は、同階層に `<input file>.enc` と `.enc` 拡張子を追加して暗号化済みファイルが作成されます。

#### ソース

- [`enc.sh` のソースを見る](https://github.com/Qithub-BOT/QiiCipher/blob/master/bin/enc)
- [`enc.sh` のダウンロード](https://qithub-bot.github.io/QiiCipher/bin/enc)
- [チェックサム (SHA512)](https://github.com/Qithub-BOT/QiiCipher/blob/master/bin/checksum.sha512)
- 詳しい説明「[GitHub の公開鍵でファイルを暗号化するスクリプト](https://qiita.com/KEINOS/items/2abce1e5b15d799ac6d7#comment-a48dd2a66e09ec9d7647)」@ Qiita

---

### 復号スクリプト（`dec.sh`）

このシェル・スクリプトはローカルの秘密鍵を使い暗号ファイルを復号します。

#### 構文

```shellsession
$ ./dec <private key> <input file> <output file>
```

##### 引数

- `<private key>`：復号に使われる秘密鍵のパス。GitHub 上の公開鍵とペアである必要があります。（例：`~/.ssh/id_rsa`）
- `<input file>`：暗号化されたファイルのパス。
- `<output file>`：復号された／平文化されたファイルの出力先のパス。

#### ソース

- [`dec.sh` のソースを見る](https://github.com/Qithub-BOT/QiiCipher/blob/master/bin/dec)
- [`dec.sh` のダウンロード](https://qithub-bot.github.io/QiiCipher/bin/dec)
- [チェックサム (SHA512)](https://github.com/Qithub-BOT/QiiCipher/blob/master/bin/checksum.sha512)

---

### 動作テスト・スクリプト（`check.sh`）

このシェル・スクリプトはカレント・ディレクトリにダミー・ファイルを作成し「暗号化」、「復号」および「比較」のチェックを行います。

#### 構文

```shellsession
$ ./check <github user> <private key>
```

- `<github user>`：自分の GitHub アカウント名。（`@KEINOS@GitHub` の場合は `KEINOS`）
- `<private key>`：復号に使われる秘密鍵のパス。GitHub 上の公開鍵とペアである必要があります。
- [注意]：暗号化で使われる公開鍵は指定ユーザの公開鍵一覧（`https://github.com/<github user>.keys`）で表示される一番上の公開鍵が使われます。

#### ソース

- [`check.sh` のソースを見る](https://github.com/Qithub-BOT/QiiCipher/blob/master/bin/check)
- [`check.sh` のダウンロード](https://qithub-bot.github.io/QiiCipher/bin/check)
- [チェックサム (SHA512)](https://github.com/Qithub-BOT/QiiCipher/blob/master/bin/checksum.sha512)

---

### 署名スクリプト

このシェル・スクリプトは、自分の秘密鍵を使ってファイルの署名を作成します。

#### 構文

```shellsession
$ ./sign <github user> <private key> <input file> [<output file>]
```

- `<github user>`：自分の GitHub アカウント名。（`@KEINOS@GitHub` の場合は `KEINOS`）
- `<private key>`：秘密鍵のパス。署名に使われます。GitHub の公開鍵とペアの秘密鍵である必要があります。
- `<input file>`：署名したいファイルのパス。

##### オプション

- `<output file>`：署名されたファイルの保存先パス。指定されていない場合は、同階層に `<input file>.sig` （`.sig` 拡張子を追加した署名ファイル）が作成されます。

##### 参考文献

- http://blog.livedoor.jp/k_urushima/archives/979220.html

---

### 署名の検証スクリプト

このシェル・スクリプトは、ファイルが正しく署名されたものか検証します。

#### 構文

```shellsession
$ ./verify <verify file> <github user> [<sign file>]
```

- `<verify file>`：署名を確認したいファイルのパス
- `<github user>`：署名者の GitHub アカウント名

##### オプション

- `<sign file>`：署名されたファイルのパス。指定されていない場合は、同階層にある `<verify file>.sig` （`.sig` 拡張子を追加したファイル）が使用されます。

---

## 注意

- これらのスクリプトは [1 ブロックぶんの暗号化](https://qiita.com/kunichiko/items/3c0b1a2915e9dacbd4c1)しか行わないため**軽量のファイル向け**です。パスワードやハッシュ値といった軽量ファイル向けです。
- 各スクリプトはダウンロード後、（0755などの）実行権限が必要です。
- 使用する秘密鍵は OpenSSH 形式ではなく PEM 形式である必要があります。参考 [OpenSSH 形式の秘密鍵について](OPENSSH_PRIVATE_KEY.md)

## 動作検証済み環境

1. macOS HighSierra
    - `OSX 10.13.5`（2018/07/13）
    - `$ openssl version` : `LibreSSL 2.2.7`
    - `$ ssh -V` : `OpenSSH_7.6p1, LibreSSL 2.6.2`
    - `$ bash --version` : `GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin17)`

2. Linux Ubuntu
    - `Ubuntu 20.04.2 LTS`（2021/05/28）
    - `$ openssl version` : `OpenSSL 1.1.1f  31 Mar 2020`
    - `$ ssh -V` : `OpenSSH_8.2p1 Ubuntu-4ubuntu0.2, OpenSSL 1.1.1f  31 Mar 2020`
    - `$ bash --version` : `GNU bash, version 5.0.17(1)-release (x86_64-pc-linux-gnu)`
---

## メンテナ

このスクリプトは [Qiita](https://qiita.com/)/[Qiitadon](https://qiitadon.com/) の同人サークル「[Qithub-ORG](https://github.com/Qithub-BOT/Qithub-ORG)」によってメンテナンスされています。

## コラボレーション（参加）

Qiita/Qiitadon ユーザーであればどなたでも参加できます。

### Issue

不具合・要望・提案・問い合わせなどは [Qithub-ORG の Issue ページ](https://github.com/Qithub-BOT/Qithub-ORG/issues)にてお願いいたします。




