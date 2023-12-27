timeout 10


ECHO ON

set server_root_drive=D:
set path_server_root=%server_root_drive%\WU\wus.U5R2.2206
set Brittain22_server_path=%path_server_root%\Brittain22

set db_path_backups=G:\My Drive\WUS.pvp\wus.U5R2.2206\.bu's\.latest

set path_7z=C:\Program Files\7-Zip


for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"

REM set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"
set "datetimef=%YY%%MM%%DD%_%HH%%Min%_%Sec%"


%server_root_drive%
PUSHD %path_server_root%
    CD 


    DEL /S /F /Q  backup\Brittain22\sqlite\

    REM see also: https://ss64.com/nt/for_r.html
    FOR /R  Brittain22\sqlite\  %%G  in  (*.db)  DO  sqlite3 %%G ".backup backup\\Brittain22\\sqlite\\%%~nG.db"


    ROBOCOPY  mods  backup\mods  *.*  /xf *.jar  /e  /MIR


    "%path_7z%\7z.exe" a  "%db_path_backups%\U5R2.backup.%datetimef%.7z"  -r  backup\*.*
POPD
CD 


timeout 55
