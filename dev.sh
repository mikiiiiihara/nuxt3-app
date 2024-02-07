#!/bin/bash
set -e

# ビルドターゲットを環境変数から取得
TARGET=${1:-parent}

function restore {
  echo "Restoring original pages structure..."
  if [ -d ".temp/pages" ]; then
    # 退避させたpagesディレクトリを削除
    rm -rf pages
    # 元のpagesディレクトリを復元
    mv .temp/pages pages
    # childディレクトリをpages下に戻す
    if [ -d ".temp/child" ]; then
      mv .temp/child pages/child
    fi
    rmdir .temp
  fi
}

trap restore EXIT

if [ "$TARGET" = "child" ]; then
  echo "Setting up environment for child development..."
  # pagesディレクトリを一時的に退避
  mkdir -p .temp
  mv pages .temp
  # 新しいpagesディレクトリを作成し、childの内容を移動
  mkdir pages
  mv .temp/pages/child/* pages/
  # childディレクトリ内のサブディレクトリも移動（存在する場合）
  if [ -d ".temp/pages/child" ]; then
    mv .temp/pages/child/.temp/child pages/
  fi
fi

# 開発サーバー起動
yarn dev
