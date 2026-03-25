---
description: 部署最新變更至 GitHub Pages 並同步 index.html
---

# 部署工作流 (Deploy Workflow)

注意：此工作流**僅適用於**「日盛國際聯合稅務記帳士事務所」或「創新國際」的網站 HTML 檔案上傳。其確保每次更新編號檔案時，GitHub Pages 的首頁 (index.html) 也會同步更新。

1. 修改原始編號檔案 (例如 `SUN102.html`)。
2. 將修改後的檔案複製為 `index.html`。
   - `copy SUN102.html index.html`
3. 將兩個檔案一併提交至 Git。
   - `git add SUN102.html index.html`
   - `git commit -m "Update site content and sync index.html"`
4. 推送至遠端倉庫。
   - `git push`
