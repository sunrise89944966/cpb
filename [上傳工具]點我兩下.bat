@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
set "GIT_PATH=C:\Program Files\Git\cmd\git.exe"

:MENU
cls
echo ==========================================
echo    GitHub 互動式上傳工具 (修復版)
echo ==========================================
echo.
echo 正在掃描 HTML 檔案...
echo.

set i=0
for %%f in (*.html) do (
    if /i not "%%f"=="index.html" (
        if /i not "%%f"=="invoice-helper.html" (
            set /a i+=1
            set "file!i!=%%f"
            echo !i!. %%f
        )
    )
)

if %i%==0 (
    echo 找不到任何可上傳的 HTML 檔案！
    pause
    exit
)

echo.
echo  A. 上傳全部
echo  Q. 退出
echo.
set /p "choice=請輸入編號 (例如 1,3): "

if /i "%choice%"=="Q" exit

:: 預先處理可能的檔案衝突（將未追蹤的影像納入管理）
"%GIT_PATH%" add . >nul 2>&1
"%GIT_PATH%" commit -m "Pre-sync: tracking images" >nul 2>&1

:: 嘗試同步雲端資料
echo.
echo  [系統] 正在同步雲端資料，請稍候...
"%GIT_PATH%" pull origin main --rebase
if %errorlevel% neq 0 (
    echo.
    echo  [錯誤] 同步失敗！可能是雲端有新的變更需要手動確認。
    echo  [解決] 請嘗試先手動在 GitHub 頁面處理衝突，或將本地檔案備份後刪除再執行。
    pause
    goto MENU
)

if /i "%choice%"=="A" (
    echo 正在準備所有 HTML 檔案...
    "%GIT_PATH%" add *.html
    goto COMMIT
)

:: 簡化選擇邏輯，避免巢狀展開錯誤
for %%c in (%choice%) do (
    for /f "tokens=2 delims==" %%v in ('set file%%c') do (
        echo 正在準備: %%v
        "%GIT_PATH%" add "%%v"
    )
)

:COMMIT
if exist .gitignore "%GIT_PATH%" add .gitignore
if exist allpic "%GIT_PATH%" add allpic/
set "timestamp=%date% %time%"
"%GIT_PATH%" commit -m "Manual upload via Batch: %timestamp%"
echo.
:: 推送到雲端
"%GIT_PATH%" push origin main

if %errorlevel% equ 0 (
    echo.
    echo --- 上傳成功！ ---
) else (
    echo.
    echo --- 上傳失敗，請檢查網路或權限 ---
)

pause
goto MENU
