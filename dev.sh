#!/bin/bash
set -e

# ビルドターゲットを環境変数から取得
TARGET=${1:-parent}

function restore {
  echo "Restoring original pages structure..."
  if [ -d ".temp/pages" ]; then
    # .tempに退避した全てのディレクトリを復元
    if [ -d ".temp/pages/child" ]; then
      # childディレクトリが退避されている場合のみ復元
      mkdir -p pages/child
      mv .temp/pages/child/* pages/child/
      # 隠しファイルの移動に失敗しないようにする
      mv .temp/pages/child/.[!.]* pages/child/ 2> /dev/null || true
    fi
    # その他の全てのファイルを復元
    mv .temp/pages/* pages/
    mv .temp/pages/.[!.]* pages/ 2> /dev/null || true
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
elif [ "$TARGET" = "parent" ]; then
  echo "Setting up environment for parent development..."
  # childディレクトリを一時的に退避
  mkdir -p .temp/pages
  mv pages/child .temp/pages/child
fi

# 開発サーバー起動
nuxt dev
