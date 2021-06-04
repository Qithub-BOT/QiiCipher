# Contributing to QiiCipher

## PR (Pull Request) 先

- `master` ブランチ

typo, ドキュメント改善、リファクタ、不具合修正など、どんな PR も歓迎です。PR に馴染みがない方も、遠慮なく試してみてください。何か失敗しても、みんなで直して行きましょう。

PR の作業に入る前に、過去の PR や Issue や Discussion を確認してください。

なぜなら、過去に途中まで実装するも諸事情により諦めた PR があるかもしれないからです。引き継げるなら（流用できるなら）それに越したことはありません。もしくは、同じ内容の提案や実装をするも却下されたものがあるかもしれませんので、せっかく PR しても同じ理由で却下されないためです。

### Draft PR のススメ

このリポジトリでは [Draft PR](https://github.blog/jp/2019-02-19-introducing-draft-pull-requests/) を用いた PR を推奨しています。もちろん、小さな PR や PR に慣れた方は、この限りではありません。

Draft PR とは、何かの作業を始める前に `Draft` で PR を上げてから作業を開始する方法です。

一応の作業が終わり、`Draft` が外れ、一連の必須テストをパスして初めてレビューが開始されます。

> <sub><sup>🐒 レビューとは、[コントリビューター（改善・改良に貢献してくださってるボランティアの方々）](https://github.com/Qithub-BOT/QiiCipher/graphs/contributors)が PR の内容の確認と、気になる点を指摘することです。</sup></sub>

Draft PR によるメリットは以下の通りです。

1. 同じ内容の作業を別の人が進めていないか確認できる。
2. 作業経過が見えることで、他の人が次のステップの PR の準備を進めやすい。
3. 作業内容が見えることで、コントリビュータがレビューの情報を予め知ることができる。
    - 基本的にコントリビュータは `Draft` が外れるまで口を出しません。かといって `Draft` 作業中も必ずチェックしているというわけでもありません。
4. 作業を途中で降りることが気軽にできる。
    - 力尽きたり、時間がなかったり、作業が苦しくなったり、思っていたより作業量が多かったなど、**諸事情ある場合は、遠慮なく Draft PR を `close` してください**。気に病む必要はありません。
5. 作業を引き継ぐことができる。
    - `Draft` PR を行うことにより作業内容が残ることになりきます。これは、他のコントリビューターの参考情報となり、流用可能な作業内容を引き継げるということです。

### 理想的な PR の流れ

1. QiiCipher のリポジトリを自分の GitHub アカウントに [Fork](https://docs.github.com/ja/github/getting-started-with-github/quickstart/fork-a-repo) する。
    - Fork とは、GitHub 内で他社のリポジトリを自分のアカウントにリポジトリを `clone` する [GitHub 用語](https://docs.github.com/ja/github/getting-started-with-github/quickstart/github-glossary#fork)です。
2. Fork した GitHub リポジトリをローカル（自分の環境）に `clone` する。
3. ローカルの `master` ブランチから作業用のブランチを作成する。
4. 作業ブランチに変更とコミットを続け、完了したら結果を Fork したリポジトリに `push` する。
5. GitHub 上で Fork したリポジトリから Origin（QiiCipher のリポジトリ）の `master` に [PR (Pull Request)](https://docs.github.com/ja/desktop/contributing-and-collaborating-using-github-desktop/working-with-your-remote-repository-on-github-or-github-enterprise/creating-an-issue-or-pull-request#creating-a-pull-request) を送る。
6. GitHub 上で [lint](https://ja.wikipedia.org/wiki/Lint#%E3%80%8Clint%E3%80%8D%E3%81%AE%E6%B4%BE%E7%94%9F%E7%94%A8%E6%B3%95)（文法・構文チェック）、スクリプトの[静的解析](https://ja.wikipedia.org/wiki/%E9%9D%99%E7%9A%84%E3%82%B3%E3%83%BC%E3%83%89%E8%A7%A3%E6%9E%90)、[ユニット・テスト](https://ja.wikipedia.org/wiki/%E5%8D%98%E4%BD%93%E3%83%86%E3%82%B9%E3%83%88)が走ります。
7. テストが失敗した場合は、そのエラー内容を修正し、追いコミットを `push` します。成功した場合は、`Draft` を外し、レビュー依頼を PR 画面でコメントします。（過去の PR を参考にしてください）
8. レビューが始まり、指摘を受けた場合は、それらを修正して追いコミットを `push` します。
9. 修正内容の確認によりレビュー済みフラグが立てられるか、無事 `LGTM` (`Looks Good To Me`) がもらえたらリポジトリ管理者により `master` ブランチへのマージ作業がはじまります。
    - テストがパスしており、レビュー済みフラグが複数付いた場合は、自動的にマージされます。（現在は未設定）
10. PR に使われた作業ブランチは、Fork 先のリポジトリの設定で自動削除が有効になっていない場合は残りますので、自動削除設定するか手動で削除してください。（Origin の QiiCipher のリポジトリでは PR 時の作業ブランチは自動削除されます）
11. ローカルの `master` ブランチに、Origin の `master` ブランチの変更（先にマージされた PRの変更）をマージします。これにより、Origin の変更に追随することになります。

## 不具合報告先

- [Issues](https://github.com/Qithub-BOT/QiiCipher/issues)

Issues は、基本的に不具合がある（期待する動きと違う）場合の報告先です。

**可能な限り再現性のある情報提供**をお願いします。

一番ベストな方法は、「期待する出力」のテストを作成し、それが失敗するパターンを明示した issue です。コントリビューターの方々も、たいへん対応しやすくなります。

- テストの例: https://github.com/Qithub-BOT/QiiCipher/tree/master/tests/issues

typo やドキュメントの記述改善などは、直接 PR するか [Discussions](https://github.com/Qithub-BOT/QiiCipher/discussions) で提案してください。

情報が少なく、コントリビューターが作成したテストがパス（正常終了）した場合は、その Issue はクローズされる可能性があることをご承知おきください。

## 改善提案先・質問先

- [Discussions](https://github.com/Qithub-BOT/QiiCipher/discussions)

「PR したいが意見や情報が欲しい」「不具合なのかわからない」「●●● 機能が欲しい」など、不具合報告以外に関する掲示板です。
