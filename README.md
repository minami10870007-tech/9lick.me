# 9lick.me

短縮URL・クリック計測サービス **9lick.me** のコーポレートサイト。

デザインシステム（Color / Typography / Button Component）に準拠して構築しています。

## ファイル構成

| ファイル | 内容 |
|---|---|
| `index.html` | 配信用の完成HTML。**直接編集しない**（`build.sh` が生成する） |
| `src/page.html` | 編集する本体。HTML・CSS・JavaScript をすべて内包 |
| `build.sh` | `src/page.html` に doctype と `<head>` を付けて `index.html` を書き出す |
| `kv-space-2026.png` | トップページのキービジュアル（1672×941） |

### なぜビルド手順があるのか

`src/page.html` は `<head>` を持たない断片です。Claude の Artifact として公開する場合は doctype と `<head>`（charset / viewport）が自動で付与されるため、こちらに書くと二重になります。一方 GitHub Pages では素のHTMLがそのまま配信されるので、**viewport メタが無いとスマートフォンでレスポンシブが一切効きません**。この2つの要求を両立させるため、断片を正本とし、配信用を生成する形にしています。

### 編集の手順

```bash
# src/page.html を編集したあと
bash build.sh src/page.html index.html
```

## デザインシステム

### Color

| 用途 | 値 |
|---|---|
| Primary | `#FF6BBB` |
| Primary Light | `#FFB6C1` |
| Primary Bg | `#FFF0F4` |
| Text | `#2D2D2D` |
| Text Sub | `#6B7280` |
| Border | `#F0E6EA` |
| Surface | `#FFFFFF` |
| Background | `#FFFBFA` |
| Success | `#9FD8B1` |
| Warning | `#FFC6BB` |

状態表現のため `--primary-pressed` `--primary-faint` `--primary-bg-deep` の3色を派生させています。いずれも同系統のピンクです。

### Typography

Noto Sans JP / Bold・Medium・Regular / 本文 14・16・18px。
補助ラベル用に `--fs-xs`（12px）、見出し用に `--fs-d1` `--fs-d2` `--fs-d3` を拡張しています。

### Button

4種（Primary / Secondary / Tertiary / Ghost）× 4状態（Default / Hover / Pressed / Disabled）× 4サイズ（Large 48px / Default 40px / Small 32px / Tiny 24px）。すべてピル型。Loading・With Icon・Icon Only・Button Group を実装しています。

## ページ構成

1枚のHTMLの中で5ページを切り替えます。切り替えはJavaScriptが担当し、URLのハッシュ（`#/service` など）は共有用のディープリンクとして同期されます。Artifact は iframe 内で動作しハッシュ遷移が阻害されることがあるため、ハッシュに依存しない実装にしています。

- `#/home` — キービジュアル、実績数値、動く短縮デモ、特徴、3ステップ
- `#/service` — 機能一覧、計測ダッシュボードの例、API、信頼性
- `#/pricing` — 4プラン（月払い／年払い切替）、FAQ
- `#/company` — ミッション、価値観、会社情報
- `#/contact` — お問い合わせフォーム、連絡先

## JavaScript が無効な場合

意図的に、JavaScriptが無くても内容がすべて読める作りにしています。ナビゲーションは折り返して常時表示、FAQの回答はすべて開いた状態、実績数値は実測値がそのままHTMLに入っています。アニメーションと開閉機能のみが無効になります。`prefers-reduced-motion` を有効にしている場合も、動きだけを止めて内容は保ちます。

## 公開する場合

GitHub Pages: Settings → Pages → Source で `main` ブランチのルート（`/`）を選択すると `https://minami10870007-tech.github.io/9lick.me/` で配信されます。独自ドメイン（9lick.me）を使う場合は同じ画面の Custom domain に設定し、DNS側にCNAMEレコードを追加してください。

## 公開前に差し替えが必要な箇所

いずれも仮の内容です。`src/page.html` を編集して `build.sh` を実行してください。

**会社概要の未記入項目** — 運営会社の正式名称、代表者、設立、所在地、資本金、従業員数。ページ上では「未記入」と表示されます。

**実績数値** — 累計リダイレクト数 4.2億、応答 p95 38ms、稼働率 99.99%、導入 1,400社。

**料金** — Starter 1,480円／Pro 4,800円などの価格と各プランの上限値。

**連絡先** — `contact@9lick.me`、`support@9lick.me`、`status.9lick.me`。

**お問い合わせフォーム** — 送信先が未接続です。送信すると入力内容を検証したうえで、メールでの連絡を案内する表示になります。実際に送信できるようにするには、`src/page.html` 末尾のフォーム送信処理に送信先エンドポイントを追加してください。

## 既知の制約

デザインシステムで定義された Primary `#FF6BBB` は、白文字との対比が **2.60:1** で、WCAG AA の基準（通常文字 4.5:1、大きな文字 3:1）を満たしていません。ピンク文字を白背景に置いた場合も同じ値です。ブランドの根幹に関わる色のため変更していませんが、アクセシビリティを満たすには Primary を `#C9327E` 程度まで濃くする必要があります。

なお、フォーカスリングだけは視認性の確保が必須のため、ピンクではなくインク色（`#2D2D2D`）で描いています。
