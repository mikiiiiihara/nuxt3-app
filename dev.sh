#!/bin/bash
set -e

# ビルドターゲットを環境変数から取得
TARGET=${1:-parent}

function restore {
  echo "Restoring original pages structure..."
  if [ -d ".temp" ]; then
    # 退避させたchild以外のpagesディレクトリを復元
    rm -rf pages
    mv .temp/pages pages
    # childディレクトリ内のファイルを復元
    if [ -d "pages/child" ]; then
      # 元々のchildディレクトリが存在する場合は、一度削除
      rm -rf pages/child
    fi
    # 退避させたchildディレクトリを復元
    mv pages/* .temp/pages/child/
    rm -rf pages
    mv .temp/pages pages
    # 一時フォルダを削除
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
  mkdir -p pages
  mv .temp/pages/child/* pages/
fi

# 開発サーバー起動
yarn dev
