#!/bin/bash
set -e

# ビルドターゲットを環境変数から取得
TARGET=${1:-parent}

function restore {
  echo "Restoring original pages structure..."
  if [ -d ".temp/pages" ]; then
    # 一時的に移動したファイルをpages/childに戻す
    mkdir -p pages/child
    if [ -d "pages" ]; then
      # childディレクトリ内のファイルを復元
      mv pages/* .temp/pages/child/ 2> /dev/null || true
      # .temp/pages/childに残る隠しファイルも移動
      mv pages/.* .temp/pages/child/ 2> /dev/null || true
    fi
    # 退避させたディレクトリを削除
    rm -rf pages
    # 元のpagesディレクトリを復元
    mv .temp/pages pages
    # 一時フォルダを削除
    rmdir .temp
  fi
}

trap restore EXIT

if [ "$TARGET" = "child" ]; then
  echo "Setting up environment for child development..."
  # 全てのpagesディレクトリを一時的に退避
  mkdir -p .temp
  mv pages .temp/
  # childディレクトリ内の内容を新しいpagesディレクトリに移動
  mkdir -p pages
  mv .temp/pages/child/* pages/
  mv .temp/pages/child/.* pages/ 2> /dev/null || true
fi

# 開発サーバー起動
nuxt dev
