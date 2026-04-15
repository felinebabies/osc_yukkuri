# osc_yukkuri

OSCメッセージを受け取り、AquesTalkPiでゆっくり音声を再生するRubyスクリプトです。

## 機能

- OSCサーバーとして指定ポートで待ち受けます。
- `/jihou` を受け取ると、現在日時を読み上げます。
- `/freetext` を受け取ると、OSC引数として渡された文字列を読み上げます。

## 動作環境

- Ruby
- Bundler
- AquesTalkPi
- `aplay` コマンド

Raspberry Piなど、AquesTalkPiとALSAの音声出力が使える環境を想定しています。

## セットアップ

依存gemをインストールします。

```sh
bundle install
```

必要に応じて `.env` を作成し、待ち受けポートやAquesTalkPiのパスを設定します。

```env
PORT=3333
AQUESTALK_PATH=/home/pi/tool/aquestalkpi/AquesTalkPi
```

環境変数を設定しない場合は、以下の既定値が使われます。

| 変数 | 既定値 | 説明 |
| --- | --- | --- |
| `PORT` | `3333` | OSCサーバーの待ち受けポート |
| `AQUESTALK_PATH` | `/home/pi/tool/aquestalkpi/AquesTalkPi` | AquesTalkPi実行ファイルのパス |

## 起動方法

```sh
bundle exec ruby osc_yukkuri.rb
```

起動後、指定したOSCポートでメッセージを待ち受けます。

## OSCアドレス

### `/jihou`

現在日時を読み上げます。引数は不要です。

```sh
oscsend localhost 3333 /jihou
```

読み上げ例:

```text
現在は、2026年4月16日1時30分です。
```

### `/freetext`

OSC引数として渡した文字列を読み上げます。

```sh
oscsend localhost 3333 /freetext s "こんにちは"
```

複数の引数を渡した場合は、引数を連結した文字列として読み上げます。

## トラブルシュート

音が出ない場合は、先にAquesTalkPiと`aplay`が単体で動作するか確認してください。

```sh
/home/pi/tool/aquestalkpi/AquesTalkPi "テストです" | aplay
```

OSCメッセージを受信できない場合は、`PORT`の値、送信先ホスト、ファイアウォール設定を確認してください。
