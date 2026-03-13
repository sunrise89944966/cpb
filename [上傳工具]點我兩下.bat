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

:: 預先處理可能的檔案衝突（僅針對根目錄下的檔案執行，排除任何資料夾）
"%GIT_PATH%" add *.html *.webp *.jpg *.png *.pdf *.docx *.svg .gitignore >nul 2>&1
"%GIT_PATH%" commit -m "Auto-sync support: root files only" >nul 2>&1

:: 嘗試同步雲端資料
echo.
echo  [系統] 正在同步雲端資料，請稍候...
"%GIT_PATH%" pull origin main --rebase
if %errorlevel% neq 0 (
    echo.
    echo  [錯誤] 同步失敗！請檢查是否存在手動修改的衝突。
    pause
    goto MENU
)

:: 根據使用者選擇準備 HTML 檔案
if /i "%choice%"=="A" (
    echo 正在準備所有 HTML 檔案...
    "%GIT_PATH%" add *.html
) else (
    for %%c in (%choice%) do (
        for /f "tokens=2 delims==" %%v in ('set file%%c') do (
            echo 正在準備: %%v
            "%GIT_PATH%" add "%%v"
        )
    )
)

:COMMIT
:: 額外確保其他根目錄檔案也被包含（但不包含子資料夾）
"%GIT_PATH%" add *.webp *.jpg *.png *.pdf *.docx *.svg .gitignore >nul 2>&1
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
