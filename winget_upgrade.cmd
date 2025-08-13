@echo off

echo.
echo upgrading winget...
winget upgrade --accept-source-agreements --accept-package-agreements

echo upgrading installed programs via winget ...
winget upgrade --all --accept-source-agreements --accept-package-agreements

echo Done! All programs ar up to date.
pause
