#!/usr/bin/env bash
# 9lick.me — 配布用ビルド
#
# 9lick.html は Artifact 用の「断片」。Artifact は公開時に doctype と
# <head>（charset / viewport）を自動で付けるため、こちらには書けない。
# GitHub Pages では素の HTML がそのまま配信されるので、viewport メタが
# ないとスマホでブレークポイントが一切効かない。そのため配布用には
# 完全な文書としてラップして書き出す。
set -euo pipefail

SRC="${1:?usage: build.sh <src.html> <out.html>}"
OUT="${2:?usage: build.sh <src.html> <out.html>}"

{
  cat <<'HEAD'
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="9lick.me は短縮URLとクリック計測のサービスです。キャンペーンURLの短縮から、押された数の計測まで。">
<meta name="theme-color" content="#FF6BBB">
<meta property="og:title" content="9lick.me">
<meta property="og:description" content="長いURLを、4文字にする。短縮URL・クリック計測サービス">
<meta property="og:image" content="kv-space-2026.png">
<meta property="og:type" content="website">
<link rel="icon" href="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 32 32'%3E%3Ccircle cx='16' cy='16' r='13' fill='%23FF6BBB'/%3E%3C/svg%3E">
<style>
  *{box-sizing:border-box}
  html{color-scheme:light}
  body{margin:0;font-family:system-ui,sans-serif;background:#FFFBFA}
  img{max-width:100%}
  [hidden]{display:none!important}
</style>
</head>
<body>
HEAD
  cat "$SRC"
  cat <<'FOOT'
</body>
</html>
FOOT
} > "$OUT"

echo "built: $OUT ($(wc -c < "$OUT") bytes)"
