@echo off

REM ================================
REM CREATE FOLDERS
REM ================================
if not exist "%USERPROFILE%\.openclaw\agents\main\agent" (
    mkdir "%USERPROFILE%\.openclaw\agents\main\agent"
)

REM ================================
REM CREATE auth-profiles.json
REM ================================
(
echo {
echo   "profiles": {
echo     "gg": {
echo       "type": "api_key",
echo       "provider": "google",
echo       "key": "AIzaSyAbtN2oQc5RAH1hL9Sy_tShOv4--BfGS6Q"
echo     }
echo   }
echo }
) > "%USERPROFILE%\.openclaw\agents\main\agent\auth-profiles.json"

echo Created:
echo %USERPROFILE%\.openclaw\agents\main\agent\auth-profiles.json

REM ================================
REM CREATE .openclaw folder
REM ================================
if not exist "%USERPROFILE%\.openclaw" (
    mkdir "%USERPROFILE%\.openclaw"
)

REM ================================
REM CREATE openclaw.json
REM ================================
powershell -Command "$workspace = ($env:USERPROFILE -replace '\\', '/') + '/openclaw-workspace'; @{agents=@{defaults=@{workspace=$workspace;model=@{primary='google/gemini-2.5-flash'}}};gateway=@{mode='local';auth=@{token='chatbot'}}} | ConvertTo-Json -Depth 10 | Out-File -FilePath \"$env:USERPROFILE\.openclaw\openclaw.json\" -Encoding utf8"

echo.
echo DONE!
echo Created config:
echo %USERPROFILE%\.openclaw\openclaw.json

pause
