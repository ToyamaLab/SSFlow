# SSFlow

SuperSQL利用者のためのブロック型No-Codeツール

## Getting Started

[Dockerでビルド出来るようにする #26](https://github.com/ToyamaLab/SSFlow/issues/26) 完了後に追記予定です。

### direnv設定
このリポジトリでは、リポジトリ内の環境変数の設定として [direnv](https://github.com/direnv/direnv)を使用しています。リポジトリclone後にはdirenvの設定が必要となります。

1. [Basic Installation](https://github.com/direnv/direnv#basic-installation)に従ってdirenvをインストールする
   1. MacOSではbrewが使えるので `$ brew install direnv` でインストールが可能です。
2. [hook direnv into your shell](https://github.com/direnv/direnv/blob/master/docs/hook.md)に従って、shellでの設定を行う。なお、この時にshellに `export EDITOR=emacs`などとすると `direnv edit .`の時にそのエディターが起動します。
3. SSFlowリポジトリのルートディレクトリで `direnv allow .`を行うことでルート直下の `.envrc`が読み込まれる。
4. ここまでを行うと、このリポジトリに移動してきたタイミングで自動的に `.envrc`の中身が読み込まれることになる。

## 開発者に向けて
### Git関連
#### ブランチ命名規則

- featureブランチ
  - feature/issue-<issue_id>_issue-brief-explanation

#### コミットメッセージ

- [Semantic Commit Messages](https://gist.github.com/joshbuchea/6f47e86d2510bce28f8e7f42ae84c716)に従う
  - 例：issue-123 feat: add login feature
