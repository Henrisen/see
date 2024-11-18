@echo off
setlocal enabledelayedexpansion

echo Installation Started... This May Take a few Minutes
set LOGFILE=%cd%\see-installer.log
echo [%date% %time%] Installation Started > %LOGFILE%

if exist "%tmp%\see_install\" (
   rmdir /s /q "%tmp%\see_install"
   echo [%date% %time%] Removed previous see_install directory >> %LOGFILE%
)
mkdir %tmp%\see_install
set "_cd=%cd%"
cd %tmp%\see_install

goto :get7z

:finish7z
echo [%date% %time%] Finished extracting 7z >> %LOGFILE%
goto :installLess

:finishedLess
echo [%date% %time%] Finished installing Less >> %LOGFILE%
goto :installPygments

:finishPygments
echo [%date% %time%] Finished installing Pygments >> %LOGFILE%
goto :installSed

:finishSed
echo [%date% %time%] Finished installing Sed >> %LOGFILE%
goto :installNlAndWc

:finishNlAndWc
echo [%date% %time%] Finished installing Nl and Wc >> %LOGFILE%
goto :installAwk

:finishAwk
echo [%date% %time%] Finished installing Awk >> %LOGFILE%
goto :runInstall

:finishInstall
echo [%date% %time%] Installation finished >> %LOGFILE%
goto :cleanup

:finishClenup
cd %_cd%
rmdir /s /q %tmp%\see_install
endlocal
echo [%date% %time%] Cleanup finished >> %LOGFILE%
echo Installation Finished! >> %LOGFILE%
echo You may have to restart any running Terminals.
exit /b 0

:get7z
   curl -sOL https://www.7-zip.org/a/7zr.exe
   echo [%date% %time%] Downloaded 7zr.exe >> %LOGFILE%
   curl -sOL https://www.7-zip.org/a/7z2408-extra.7z
   echo [%date% %time%] Downloaded 7z2408-extra.7z >> %LOGFILE%
   .\7zr.exe x 7z2408-extra.7z -o./7z -y >> %LOGFILE%
   echo [%date% %time%] Extracted 7z2408-extra.7z >> %LOGFILE%
   del .\7zr.exe .\7z2408-extra.7z
   echo [%date% %time%] Deleted 7zr.exe and 7z2408-extra.7z >> %LOGFILE%
   move .\7z\7za.exe .\7za.exe >> %LOGFILE%
   echo [%date% %time%] Moved 7za.exe to current directory >> %LOGFILE%
   rmdir .\7z /s /q
   echo [%date% %time%] Removed temporary 7z directory >> %LOGFILE%
   goto :finish7z

:installPygments
   set "_STRING=%*"
   if not defined _STRING set "_STRING=%PROCESSOR_ARCHITECTURE%"
   set "_UCASE=ABCDEFGHIJKLMNOPQRSTUVWXYZ"
   set "_LCASE=abcdefghijklmnopqrstuvwxyz"

   for /l %%a in (0,1,25) do (
      call set "_FROM=%%_UCASE:~%%a,1%%"
      call set "_TO=%%_LCASE:~%%a,1%%"
      call set "_STRING=%%_STRING:!_FROM!=!_TO!%%"
   )

   curl -sOL https://www.python.org/ftp/python/3.13.0/python-3.13.0-%_STRING%.exe
   echo [%date% %time%] Downloaded python installer >> %LOGFILE%
   .\python-3.13.0-%_STRING%.exe /quiet InstallAllUsers=0 PrependPath=1 Include_test=0 Include_pip=1 Include_tcltk=0 Include_tools=0 Include_doc=0 Shortcuts=0
   echo [%date% %time%] Installed Python >> %LOGFILE%
   del .\python-3.13.0-%_STRING%.exe
   echo [%date% %time%] Deleted Python installer >> %LOGFILE%

   set "python=%localappdata%\Programs\Python\Python313\python.exe"
   "%python%" -m pip install --no-cache-dir --upgrade pip -qq
   echo [%date% %time%] Upgraded pip >> %LOGFILE%
   "%python%" -m pip install --no-cache-dir --upgrade pygments -qq
   echo [%date% %time%] Installed Pygments >> %LOGFILE%
   goto :finishPygments

:installLess
   curl -sOL https://github.com/jftuga/less-Windows/releases/latest/download/less-x64.zip
   echo [%date% %time%] Downloaded less-x64.zip >> %LOGFILE%
   .\7za.exe x less-x64.zip -o./less -y >> %LOGFILE%
   echo [%date% %time%] Extracted less-x64.zip >> %LOGFILE%
   del .\less-x64.zip
   echo [%date% %time%] Deleted less-x64.zip >> %LOGFILE%
   move .\less\less.exe .\less.exe >> %LOGFILE%
   echo [%date% %time%] Moved less.exe to current directory >> %LOGFILE%
   rmdir .\less /s /q
   echo [%date% %time%] Removed temporary less directory >> %LOGFILE%
   echo [%date% %time%] Installed Less >> %LOGFILE%
   goto :finishedLess

:installSed
   curl -sL -o.\sed-4.2.1-bin.zip https://sourceforge.net/projects/gnuwin32/files/sed/4.2.1/sed-4.2.1-bin.zip/download
   echo [%date% %time%] Downloaded sed-4.2.1-bin.zip >> %LOGFILE%
   .\7za.exe x sed-4.2.1-bin.zip -o./sed-bin -y >> %LOGFILE%
   echo [%date% %time%] Extracted sed-4.2.1-bin.zip >> %LOGFILE%
   del .\sed-4.2.1-bin.zip
   echo [%date% %time%] Deleted sed-4.2.1-bin.zip >> %LOGFILE%
   move .\sed-bin\bin\sed.exe .\sed.exe >> %LOGFILE%
   echo [%date% %time%] Moved sed.exe to current directory >> %LOGFILE%
   rmdir .\sed-bin /s /q
   echo [%date% %time%] Removed temporary sed-bin directory >> %LOGFILE%

   curl -sL -o.\sed-4.2.1-dep.zip https://sourceforge.net/projects/gnuwin32/files/sed/4.2.1/sed-4.2.1-dep.zip/download
   echo [%date% %time%] Downloaded sed-4.2.1-dep.zip >> %LOGFILE%
   .\7za.exe x sed-4.2.1-dep.zip -o./sed-dep -y >> %LOGFILE%
   echo [%date% %time%] Extracted sed-4.2.1-dep.zip >> %LOGFILE%
   del .\sed-4.2.1-dep.zip
   echo [%date% %time%] Deleted sed-4.2.1-dep.zip >> %LOGFILE%
   move .\sed-dep\bin\*.dll .\ >> %LOGFILE%
   echo [%date% %time%] Moved DLL files to current directory >> %LOGFILE%
   rmdir .\sed-dep /s /q
   echo [%date% %time%] Removed temporary sed-dep directory >> %LOGFILE%
   echo [%date% %time%] Installed Sed >> %LOGFILE%
   goto :finishSed

:installNlAndWc
   curl -sL -o.\coreutils-5.3.0-bin.zip https://sourceforge.net/projects/gnuwin32/files/coreutils/5.3.0/coreutils-5.3.0-bin.zip/download
   echo [%date% %time%] Downloaded coreutils-5.3.0-bin.zip >> %LOGFILE%
   .\7za.exe x coreutils-5.3.0-bin.zip -o./coreutils-bin -y >> %LOGFILE%
   echo [%date% %time%] Extracted coreutils-5.3.0-bin.zip >> %LOGFILE%
   del .\coreutils-5.3.0-bin.zip
   echo [%date% %time%] Deleted coreutils-5.3.0-bin.zip >> %LOGFILE%
   move .\coreutils-bin\bin\nl.exe .\nl.exe >> %LOGFILE%
   echo [%date% %time%] Moved nl.exe to current directory >> %LOGFILE%
   move .\coreutils-bin\bin\wc.exe .\wc.exe >> %LOGFILE%
   echo [%date% %time%] Moved wc.exe to current directory >> %LOGFILE%
   rmdir .\coreutils-bin /s /q
   echo [%date% %time%] Removed temporary coreutils-bin directory >> %LOGFILE%

   curl -sL -o.\coreutils-5.3.0-dep.zip https://sourceforge.net/projects/gnuwin32/files/coreutils/5.3.0/coreutils-5.3.0-dep.zip/download
   echo [%date% %time%] Downloaded coreutils-5.3.0-dep.zip >> %LOGFILE%
   .\7za.exe x coreutils-5.3.0-dep.zip -o./coreutils-dep -y >> %LOGFILE%
   echo [%date% %time%] Extracted coreutils-5.3.0-dep.zip >> %LOGFILE%
   del .\coreutils-5.3.0-dep.zip
   echo [%date% %time%] Deleted coreutils-5.3.0-dep.zip >> %LOGFILE%
   move .\coreutils-dep\bin\*.dll .\ >> %LOGFILE%
   echo [%date% %time%] Moved DLL files to current directory >> %LOGFILE%
   rmdir .\coreutils-dep /s /q
   echo [%date% %time%] Removed temporary coreutils-dep directory >> %LOGFILE%

   echo [%date% %time%] Installed Nl and Wc >> %LOGFILE%
   goto :finishNlAndWc

:installAwk
   curl -sL -o.\gawk-3.1.6-1-bin.zip https://sourceforge.net/projects/gnuwin32/files/gawk/3.1.6-1/gawk-3.1.6-1-bin.zip/download
   echo [%date% %time%] Downloaded gawk-3.1.6-1-bin.zip >> %LOGFILE%
   .\7za.exe x gawk-3.1.6-1-bin.zip -o./gawk-bin -y >> %LOGFILE%
   echo [%date% %time%] Extracted gawk-3.1.6-1-bin.zip >> %LOGFILE%
   del .\gawk-3.1.6-1-bin.zip
   echo [%date% %time%] Deleted gawk-3.1.6-1-bin.zip >> %LOGFILE%
   move .\gawk-bin\bin\gawk.exe .\awk.exe >> %LOGFILE%
   echo [%date% %time%] Moved gawk.exe to current directory >> %LOGFILE%
   rmdir .\gawk-bin /s /q
   echo [%date% %time%] Removed temporary gawk-bin directory >> %LOGFILE%

   echo [%date% %time%] Installed Awk >> %LOGFILE%
   goto :finishAwk

:runInstall
   curl -sOL https://raw.githubusercontent.com/Henrisen/see/refs/heads/main/see.cmd
   if not exist "%localappdata%\Programs\Henrisen\" (
      mkdir "%localappdata%\Programs\Henrisen"
   )
   if exist "%localappdata%\Programs\Henrisen\see\" (
      rmdir /s /q "%localappdata%\Programs\Henrisen\see"
   )
   mkdir "%localappdata%\Programs\Henrisen\see"
   copy .\* %localappdata%\Programs\Henrisen\see\ >> %LOGFILE%
   del %localappdata%\Programs\Henrisen\see\7za.exe
   setx path "%localappdata%\Programs\Henrisen\see\;%path%" >> %LOGFILE%
   goto :finishInstall

:cleanup
   echo [%date% %time%] Deleting 7za.exe >> %LOGFILE%
   del .\7za.exe
   echo [%date% %time%] Deleted 7za.exe >> %LOGFILE%

   call :finishClenup
