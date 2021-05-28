# OpenSSH 形式の秘密鍵について

OpenSSH 7.8 以降では、デフォルトの秘密鍵のフォーマットが変更になりました。

参考: [【OpenSSH 7.8】秘密鍵を生成する形式が変更になった件について](https://dev.classmethod.jp/articles/openssh78_potentially_incompatible_changes/)

ただしこの新しい OpenSSH 形式(新形式)は、現時点では OpenSSL では使用できません(2021年5月時点)。

QiiCipher では OpenSSH と OpenSSL の両方を使用しているため、そのどちらでも使用可能な PEM 形式(旧形式)の秘密鍵のみ使用可能です。

## 秘密鍵の形式の見分け方

既に作成済みの秘密鍵の１行目を確認してください。

* `-----BEGIN OPENSSH PRIVATE KEY-----` となっていれば OpenSSH 形式(新形式)です。
* `-----BEGIN RSA PRIVATE KEY-----` となっていれば PEM 形式(旧形式)です。

## PEM 形式(旧形式)での秘密鍵の作り方

新規に鍵ペア（公開鍵と秘密鍵）を作成する場合に PEM 形式(旧形式)にするには、以下のように `-m pem` を指定してください。

```shell
ssh-keygen -t rsa -b 4096 -m pem
```

* 鍵長は任意です（基本的に長い方が安全です。一般的には 2048 か 4096 が使われると思われます）

鍵ペアは QiiCipher の `bin/keygen` を使って作ることもできます。

## OpenSSH 形式(新形式)の秘密鍵を、PEM形式(旧形式)に変換する方法

既に作成済の OpenSHH 形式(新形式)の秘密鍵がある場合には、以下のコマンドで PEM 形式(旧形式)に **書き換え** ができます。

```shell
ssh-keygen -p -m pem -f id_rsa
```

* 新しいパスフレーズを聞かれます。空エンターでパスフレーズ無しになります（パスフレーズをつけると `-m pem` を指定しても OpenSSH 形式になってしまうので注意してください）。
* **既存のファイルが書き換わる** ので、必要であれば **事前にコピーを取る** 必要があります。

```shell
cp id_rsa id_rsa.pem
ssh-keygen -p -m pem -f id_rsa.pem
```

* コピーしたファイルについても読み込み権限には注意してください（group と other には読み込み権限をつけないようにしてください）
