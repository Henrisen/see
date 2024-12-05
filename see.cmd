@echo off

where awk >nul 2>nul || (echo Error: awk is required but not installed. & exit /b 1)
where less >nul 2>nul || (echo Error: less is required but not installed. & exit /b 1)
where nl >nul 2>nul || (echo Error: nl is required but not installed. & exit /b 1)
if not exist "%localappdata%\Programs\Python\Python313\Scripts\pygmentize.exe"  (
    echo Error: pygmentize is required but not installed.
    exit /b 1
)
where sed >nul 2>nul || (echo Error: sed is required but not installed. & exit /b 1)
where wc >nul 2>nul || (echo Error: wc is required but not installed. & exit /b 1)

if "%1"=="/?" (
    goto :help
)

if "%1"=="/v" (
    goto :version
)

:: Check if file is provided
if "%1"=="" (
    goto :help
    exit /b 1
)

set FILE=%1

:: Check if the file exists
if not exist "%FILE%" (
    echo Error: File "%FILE%" does not exist.
    exit /b 1
)

goto :runSee %FILE%

:endSee
echo SEE v1.2.0 WINDOWS BETA
exit /b 0

:version
    echo See v1.2.0 (WIN) Beta
    echo.
    echo This is an EXPERIMANTAL Windows Build with a reduced
    echo Feature Set
    echo.
    echo Expect Bugs, Crashes OR Simmilar
    exit /b 0

:help
    echo Usage: see [OPTION...] FILE
    echo.
    echo.   /v                      Print version information
    echo.   /?                      Show this screen
    echo.
    echo Mandatory or optional arguments to long options are also mandatory or optional
    echo for any corresponding short options.
    echo.
    echo Report bugs to henri.sendelbach+see@proton.me.
    exit /b 0

:runSee :: %1: filename
    for /f "delims=" %%A in ('wc -l ^< "%1" ^| awk "{print length}"') do set "len_of_lines=%%A"
    "%localappdata%\Programs\Python\Python313\Scripts\pygmentize.exe" -g "%1" | sed "s/^/\x1b[97m/" | nl -ba -w %len_of_lines% -s " | " | sed "s/^/\x1b[90m/" | less -R
    
    goto :endSee
