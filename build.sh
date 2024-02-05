#!/bin/bash
set -e

# ビルドターゲットを環境変数から取得
TARGET=${1:-parent}

if [ "$TARGET" = "child" ]; then
  # child用のビルドを実行する場合の処理
  # pages/childを一時ディレクトリに移動
  mv pages/child pages_child_temp
  
  # 一時ディレクトリからpages/childに戻す前に、pagesディレクトリを確実に作成
  mkdir -p pages
  mv pages_child_temp pages/child

  # ビルド実行
  yarn build

  # ビルド後、childを元の位置に戻す
  # この時点で、pagesディレクトリは既に存在するはずなので、直接移動を行う
  mv pages/child pages_child_temp
  mv pages_child_temp pages/child
else
  # parent用のビルドを実行する場合の処理
  # childディレクトリを一時的に移動
  mv pages/child pages_child_temp
  
  # ビルド実行
  yarn build

  # 復元処理: childディレクトリを復元
  # ここでも、pagesディレクトリを確実に作成
  mkdir -p pages
  mv pages_child_temp pages/child
fi
