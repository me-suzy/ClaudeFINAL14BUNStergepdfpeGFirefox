@echo off
REM Script pentru pornirea Firefox cu profilul tău real (FĂRĂ banner "remote control")
REM Apoi rulează scriptul Python care își pornește propria instanță Firefox

echo ========================================
echo Pornire Firefox + Script Python
echo ========================================
echo.

REM Calea către Firefox
set FIREFOX_PATH="C:\Program Files\Mozilla Firefox\firefox.exe"

REM Verifică dacă Firefox există
if not exist %FIREFOX_PATH% (
    echo ❌ Firefox nu a fost găsit la: %FIREFOX_PATH%
    echo 💡 Verifică calea către Firefox
    pause
    exit /b 1
)

REM Calea către profilurile Firefox
set PROFILES_PATH=%APPDATA%\Mozilla\Firefox\Profiles

REM Caută profilul default-release (cel mai comun)
for /d %%p in ("%PROFILES_PATH%\*.default-release") do (
    set PROFILE_PATH=%%p
    goto :found_profile
)

REM Dacă nu găsește default-release, caută default
for /d %%p in ("%PROFILES_PATH%\*.default") do (
    set PROFILE_PATH=%%p
    goto :found_profile
)

REM Dacă nu găsește niciun profil, folosește primul găsit
for /d %%p in ("%PROFILES_PATH%\*") do (
    set PROFILE_PATH=%%p
    goto :found_profile
)

:found_profile
if defined PROFILE_PATH (
    echo ✅ Profil găsit: %PROFILE_PATH%
    echo.
    echo 🚀 Pornesc Firefox cu profilul găsit...
    echo.
    
    REM Pornește Firefox NORMAL (fără -marionette = fără banner "remote control")
    start "" %FIREFOX_PATH% -profile "%PROFILE_PATH%"
    
    echo ✅ Firefox pornit cu succes!
    echo.
    echo 📝 Profil folosit: %PROFILE_PATH%
    echo.
) else (
    echo ⚠ Nu am găsit niciun profil Firefox!
    echo 💡 Căutare în: %PROFILES_PATH%
    echo.
    echo 🚀 Pornesc Firefox cu profilul implicit...
    start "" %FIREFOX_PATH%
)

echo.
echo ========================================
echo.

REM Așteaptă 3 secunde să pornească Firefox
echo ⏳ Aștept 3 secunde să pornească Firefox...
timeout /t 3 /nobreak >nul

echo.
echo ========================================
echo 🚀 Pornesc scriptul Python...
echo    (Python va folosi propria instanță Firefox pentru automatizare)
echo ========================================
echo.

REM Setează directorul de lucru
cd /d "D:\TEST"

REM Setează encoding UTF-8 pentru Python
set PYTHONIOENCODING=utf-8

REM Rulează scriptul Python
python "D:\TEST\Claude-FINAL 14 - BUN Sterge pdf pe G Firefox.py"

echo.
echo ========================================
echo ✅ Script finalizat!
echo ========================================
pause

