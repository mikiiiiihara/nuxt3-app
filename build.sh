#!/bin/bash
set -e

# ビルドターゲットを環境変数から取得
TARGET=${1:-parent}

if [ "$TARGET" = "child" ]; then
  # child用のビルドを実行する場合の処理

  # 一時的にpagesディレクトリを退避
  mv pages pages_temp
  
  # childディレクトリをpagesにリネームして移動
  mv pages_temp/child pages

  # ビルド実行
  yarn generate

  # ビルド後、元の状態に復元
  mv pages pages_temp/child
  mv pages_temp pages
else
  # parent用のビルドを実行する場合の処理
  
  # 一時的にchildディレクトリを退避
  mkdir -p .temp
  mv pages/child .temp/child
  
  # ビルド実行
  yarn build

  # 復元処理: childディレクトリを復元
  mv .temp/child pages/child
  rmdir .temp
fi
