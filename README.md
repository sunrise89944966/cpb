# 日盛國際 GitHub 網站專案規範 (Sunrise GitHub Web Project)

本文件紀錄本專案的開發與部署規範，確保網站更新的一致性。

## 1. 檔案命名規範
- HTML 檔案使用 `SUNxxx.html` 的編號格式（例如：SUN101.html, SUN102.html）。
- 新功能開發或大改版時，請遞增編號另存新檔。

## 2. 部署與上傳流程 (僅適用於日盛國際與創新國際)
每次完成「日盛國際」或「創新國際」相關的新版 HTML（如 `SUN102.html`）修改後，**必須執行以下同步動作**：
1. **同步至首頁**：將最新的編號檔案（例如 `SUN102.html`）直接複製並覆蓋 `index.html`。
   - `copy SUNxxx.html index.html`
2. **上傳 Git**：同時上傳「編號檔案」與「首頁檔案」。
   - `git add SUNxxx.html index.html`
   - `git commit -m "描述變更內容"`
   - `git push`

## 3. GitHub Pages 網址
- 首頁：https://sunrise89944966.github.io/cpb/index.html
- 特定版本頁面：https://sunrise89944966.github.io/cpb/SUNxxx.html
