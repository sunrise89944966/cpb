# 自動上傳至 GitHub 的腳本 (由 Antigravity 產生)
$gitPath = "C:\Program Files\Git\cmd\git.exe"

Write-Host "--- 正在開始自動上傳流程 ---" -ForegroundColor Cyan

# 1. 暫存變更
& $gitPath add .
Write-Host "[1/3] 已將檔案加入暫存區" -ForegroundColor Green

# 2. 提交變更 (使用時間戳記作為訊息)
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
& $gitPath commit -m "自動更新: $timestamp"
Write-Host "[2/3] 已完成提交 (訊息: 自動更新: $timestamp)" -ForegroundColor Green

# 3. 推送到 GitHub
Write-Host "[3/3] 正在推送到 GitHub，請稍候..." -ForegroundColor Yellow
& $gitPath push -u origin master

if ($LASTEXITCODE -eq 0) {
    Write-Host "--- 上傳完成！ ---" -ForegroundColor Green
} else {
    Write-Host "--- 上傳過程中出現問題，請檢查錯誤訊息 ---" -ForegroundColor Red
}

read-host "按下 Enter 鍵關閉視窗..."
