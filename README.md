# liff-terraform
LIFF Terraform

## バージョン
- Terraform v1.8.4
- hashicorp/aws 5.61.0

## Terraformのインストール
- [公式サイト](https://developer.hashicorp.com/terraform/install)に従ってインストール
```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

- インストールできたか確認
```bash
terraform version
```
```
Terraform v1.9.5
on darwin_arm64
```
### 参考
https://zenn.dev/take_tech/articles/32188cd3607721


## 使い方
- AWS CLIのプロファイルを指定
```bash
export AWS_PROFILE=プロファイル名
```
プロファイルは登録済みであることが前提。https://zenn.dev/aiiro/articles/3ebaaf1ddc1312

- 初回は以下のコマンドを実行
```bash
cd resource
```
```bash
terraform init
```
初回は実行必須。
.tf ファイルで利用している plugin（先述の例でいうと aws provider など）のダウンロード処理などが走る。

- コードを変更したら以下のコマンドを実行
```bash
terraform plan
```
変更した内容によってどのようなリソースが 作成/修正/削除 されるかが出力される。
意図した変更になっているか確認。

- 以下のコマンドを実行しリソースを作成
```bash
terraform apply
```
変更内容をもとに実際にリソースが作成される。
terraform.stateで状態管理しており、差分の内容だけが反映されるようになっている。

## ディレクトリ設計
- リソース種類ごとに1ファイル
  - 例えばS3の定義は全てs3.tfに記述している。
  - モジュール化すれば保守性は良くなりそうだが、リソースの数も限られているので現状はこの設計で問題ないかと思われる。