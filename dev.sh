#!/bin/bash
set -e

# ビルドターゲットを環境変数から取得
TARGET=${1:-parent}

function restore {
  echo "Restoring original pages structure..."
  if [ -d ".temp/pages" ]; then
    # 移動したchildの内容を退避させた元の場所に戻す
    if [ -d "pages/child" ]; then
      # childディレクトリを一時的に別の場所に移動
      mv pages/child .temp/pages/child
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
  # .temp/pages/childに残る隠しファイルも移動（存在する場合）
  mv .temp/pages/child/.* pages/ 2> /dev/null || true
fi

# 開発サーバー起動
nuxt dev
