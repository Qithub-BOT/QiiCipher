
# PR (Pull Request) について

typo, ドキュメント改善、リファクタ、不具合修正など、どんな PR でも歓迎です。PR に馴染みがない方も、遠慮なく試してみてください。何か失敗しても、みんなで直して行きましょう。

- PR 先: `master` ブランチ

## 作業を始める前に

PR（[プルリク](https://docs.github.com/ja/github/getting-started-with-github/quickstart/github-glossary#pull-request)）の作業に入る前に、過去の PR や Issue や Discussion を確認してください。

なぜなら、途中まで実装するも諸事情により諦めた過去の PR があるかもしれないからです。引き継げるなら（流用できるなら）それに越したことはありません。

もしくは、同じ内容の提案や実装をするも却下されたものもあるかもしれません。せっかく PR しても同じ理由で却下されないためにも、確認をお願いします。

## Draft PR のススメ

このリポジトリでは [Draft PR](https://github.blog/jp/2019-02-19-introducing-draft-pull-requests/) を用いた PR を推奨しています。もちろん、小さな PR や、PR に慣れた方は、この限りではありません。

Draft PR とは、何かの作業を始める前に `Draft` で PR を上げてから作業を開始する方法です。

一応の作業が終わり、`Draft` が外れ、一連の必須テストをパスして初めてレビューが開始されます。

> <sub><sup>🐒 [レビュー](https://docs.github.com/ja/github/getting-started-with-github/quickstart/github-glossary#review)とは、自分が作成・修正したスクリプトやドキュメントを手離れ・独り立ちさせるための儀式です。<br>具体的には、コントリビュータが「PR 内容」の確認と「気になる点」を指摘することを言います。レビュー数が多いほど、また修正をするほど、均質性と、その後のメンテナンス性が増します。ここで言う均質性とは、リポジトリ内の他のスクリプトやドキュメントが持つ「方言」的なものとの馴染みやすさを言います。これにより、[マージ](https://docs.github.com/ja/github/getting-started-with-github/quickstart/github-glossary#merge)直後から手離れしやすくなります。もちろん「マージ後に気付いたこと」が出てくることが多いので、その場合は別途修正の PR がされて成長して行きます。<br>なお、QiiCipher のコントリビュータになるには、過去に 1 度でも、QiiCipher のリポジトリに PR/Issue/Discussion にコントリビュート（投稿、参加）していれば自動的に[コントリビュータ一覧](https://github.com/Qithub-BOT/QiiCipher/graphs/contributors)に追加されます。</sup></sub>

さて、従来の PR 方法（成果物のみを PR する方法）と比べ、Draft PR によるメリットは以下の通りです。

1. 別の人が同じ内容の作業を進めていないか確認できる。
2. 作業経過が見えることで、他の人が次のステップの PR の準備を進めやすい。
3. 必須テストが Upstream（本家 QiiCipher のリポジトリ上）で勝手に走るので、実 PR 前に最低限の要件チェックができる。
4. 作業内容が見えることで、コントリビュータがレビューの情報を予め知ることができる。
    - 基本的にコントリビュータは `Draft` が外れるまで口を出しません。かといって `Draft` 作業中も必ずチェックしているというわけでもありません。
5. 作業を途中で降りることが気軽にできる。
    - `Draft` です。力尽きたり、時間がなかったり、作業が苦しくなったり、思っていたより作業量が多かったなど、**諸事情ある場合は、遠慮なく Draft PR を `close` してください**。気に病む必要はありません。
6. 作業を引き継ぐことができる。
    - `Draft` PR を行うことにより作業内容が残ることになります。これは、他のコントリビュータの参考情報となり、流用可能な作業内容を引き継げるということでもあります。おそらく、これが 1 番のメリットかも知れません。

### 理想的な PR の流れ

[PR (Pull Request)](https://docs.github.com/ja/desktop/contributing-and-collaborating-using-github-desktop/working-with-your-remote-repository-on-github-or-github-enterprise/creating-an-issue-or-pull-request#creating-a-pull-request) に慣れている方は、この限りではありませんが、理想的な PR のフローは以下の通りです。

1. 準備
    1. QiiCipher の本家リポジトリを自分の GitHub アカウントに [Fork](https://docs.github.com/ja/github/getting-started-with-github/quickstart/fork-a-repo) する。
        - Fork とは、GitHub 内で他者のリポジトリを、自分のアカウントにリポジトリを `clone` する [GitHub 用語](https://docs.github.com/ja/github/getting-started-with-github/quickstart/github-glossary#fork)です。`Fork` したリポジトリから見ると本家のリポジトリが `Origin` となります。
    2. Fork した GitHub リポジトリをローカル（自分の環境）に `clone` する。
        - これにより `Fork` したリポジトリが、ローカルから見たときの `Origin`（起源） となります。
        - ローカルから見たときの `Upstream`（上流）は `Origin` の `Origin` つまり、本家のリポジトリを指します。
    3. ローカルの `master` ブランチから作業用のブランチを作成する。
    4. 作業に使う空のファイルやハリボテの関数もしくは実装予定のテストを作成し、コミットと作業用ブランチを Fork に `push` する。
        - 現在 QiiCipher は [TDD](https://ja.wikipedia.org/wiki/%E3%83%86%E3%82%B9%E3%83%88%E9%A7%86%E5%8B%95%E9%96%8B%E7%99%BA) にチャレンジしています。詳しくは後述する「テストについて」をご覧ください。
2. 通知
    1. 未実装の状態で作業ブランチを Upstream（QiiCipher の本家リポジトリ）の `master` に `Draft` で PR を送る。
        - PR 時に GitHub 上で `Draft` を設定できます。<br>![](https://user-images.githubusercontent.com/11840938/120753083-99484e00-c545-11eb-836a-afafa9bee29a.png)
        - PR のタイトルやコメントは、「どのような実装か」「後日検索しても引っかかりやすい」「わかりやすい情報」を念頭に書いてください。たった 1 つの不具合修正、たった 1 つの機能実装など、PR 内容の粒が小さければ、小さいほど助かります。
3. 実作業／実装
    1. 作業ブランチに変更とコミットを続け、適度なタイミングで結果を Fork したリポジトリに `push` する。
        - QiiCipher では [`squash`](https://docs.github.com/ja/github/getting-started-with-github/quickstart/github-glossary#squash) してから（コミットを 1 つにまとめてから） `master` へマージする運用になっています。そのため、試行錯誤のコミットであっても問題ありません。思う存分試行錯誤してください。
    2. リポジトリに `push` されると `Draft` で PR されているため Upstream 上で必須テストが走ります。
        - 必須テストは： [lint](https://ja.wikipedia.org/wiki/Lint#%E3%80%8Clint%E3%80%8D%E3%81%AE%E6%B4%BE%E7%94%9F%E7%94%A8%E6%B3%95)（文法・構文チェック）、スクリプトの[静的解析](https://ja.wikipedia.org/wiki/%E9%9D%99%E7%9A%84%E3%82%B3%E3%83%BC%E3%83%89%E8%A7%A3%E6%9E%90)、[ユニット・テスト](https://ja.wikipedia.org/wiki/%E5%8D%98%E4%BD%93%E3%83%86%E3%82%B9%E3%83%88)です。

4. レビュー依頼（本 PR 化 = `Draft` を外す）
    1. 実装が終わり、テストがパスした場合は、`Draft` を外し、レビュー依頼を PR 画面でコメントします。（過去の PR を参考にしてください）
    2. コントリビュータのボランティアにより、レビューが始まります。指摘を受けた場合は、それらを修正して追いコミットを `push` します。（テストも自動で走ります）
    3. 修正内容が確認されると、各指摘に「レビュー済み」フラグが立てられて行きます。
    4. 指摘の修正が全て無事に終わると、レビュアー（レビューした人）が PR を `Approve`（承認）し、コメント欄に `LGTM` (`Looks Good To Me`) します。
5. マージ作業
    1. リポジトリ管理者が `LGTM` もしくは `Approved` を確認すると `master` ブランチへのマージ作業をはじめます。
        - テストがパスしており、複数レビュアーからの `Approve` が付いた場合は、自動的にマージされます。（現在は未設定）
    1. マージが完了すると Upstream にある PR 時の作業ブランチは自動削除されます。Fork 先のリポジトリおよびローカルにある作業ブランチは残りますので、自動削除設定するか手動で削除してください。
        - この時、ローカルもしくは `Fork` したリポジトリの `master` ブランチに作業ブランチはマージしないでください。次のステップで変更を適用します。
6. 本家に追随
    1. ローカルの `master` ブランチに、`Upstream` の `master` ブランチの変更（先にマージされた PR の変更）をマージします。これにより、`Upstream` の変更に追随することになります。
    2. ローカルの `master` に `Upstream` の変更をマージした場合は、`Origin`（Fork したリポジトリ）に `push` します。逆に、`Origin` 側で（GitHub 上で）マージした場合は、ローカルに変更を `pull` します。
