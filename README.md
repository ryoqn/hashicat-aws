# hashicat-aws
Hashicat: A terraform built application for use in Hashicorp workshops

Includes "Meow World" website.

[![CircleCI](https://circleci.com/gh/hashicorp/hashicat-aws.svg?style=svg)](https://circleci.com/gh/hashicorp/hashicat-aws)


## API駆動サンプルメモ
Terraform Cloud には豊富な API があり、GUI でできることはすべて、それ以上のことが可能。

下記例では、API のみで、hashicat-aws のワークスペースで3つの変数を設定し、Terraform の実行をトリガーする。  
設定する必要のある3つの変数は以下の通り。

* placeholder 画像のプレースホルダーの URL
* height 画像の高さをピクセルで指定。600に設定。
* width 画像の幅をピクセル単位で指定。800に設定。

### Setup for The Challenge;
下記コマンドを実行してトークンを取得し、環境変数 TOKEN に格納。

```bash
export TOKEN=$(grep token /root/.terraform.d/credentials.tfrc.json | cut -d '"' -f4)
```

MYORGNAME を対象の Organization 名に置き換えて、以下のコマンドで ORG 変数を設定。

```bash
export ORG="MYORGNAME"
```

ワークスペース ID を取得。GUIからコピペでも可。
```bash
curl -s --header "Authorization: Bearer $TOKEN" --header "Content-Type: application/vnd.api+json" https://app.terraform.io/api/v2/organizations/$ORG/workspaces/hashicat-aws | jq -r .data.id
```

出力されたワークスペース ID を変数 WS_ID に設定。

```bash
export WS_ID="WORKSPACEID"
```

### The Challenge:
json ディレクトリにある4つの *.json ファイルを使って、変数を作成し、Terraform の plan / apply を実行する。  
※JSON ファイル名の前に @ を必ず入れること。

placeholder 変数の設定:
```bash
curl \
  --header "Authorization: Bearer $TOKEN" \
  --header "Content-Type: application/vnd.api+json" \
  --request POST \
  --data @var-placeholder.json \
  https://app.terraform.io/api/v2/workspaces/$WS_ID/vars | jq
```

height 変数の設定:
```bash
curl \
  --header "Authorization: Bearer $TOKEN" \
  --header "Content-Type: application/vnd.api+json" \
  --request POST \
  --data @var-height.json \
  https://app.terraform.io/api/v2/workspaces/$WS_ID/vars | jq
```

width 変数の設定:

```bash
curl \
  --header "Authorization: Bearer $TOKEN" \
  --header "Content-Type: application/vnd.api+json" \
  --request POST \
  --data @var-width.json \
  https://app.terraform.io/api/v2/workspaces/$WS_ID/vars | jq
```

Terraform Cloud の UI からワークスペースの Variables タブで環境変数が設定されている事を確認する。

最後に、Terraform Run を実行。

```bash
curl \
  --header "Authorization: Bearer $TOKEN" \
  --header "Content-Type: application/vnd.api+json" \
  --request POST \
  --data @apply.json \
  https://app.terraform.io/api/v2/runs | jq
```