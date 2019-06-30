setlocal
set SCRIPT_DIR="%~d0%~p0"
cd %SCRIPT_DIR%
cd ..
echo "%cd%" & set ROOT_DIR="%cd%"

echo SCRIPT_DIR=%SCRIPT_DIR%
echo ROOT_DIR=%ROOT_DIR%
cd  /d %ROOT_DIR%
call :main
exit /b


:build_it
setlocal
rem --below is extra gn args "--args" --
rem treat_warnings_as_errors = false
rem fatal_linker_warnings = false
rem target_cpu = ""x86""
rem target_cpu = ""x64""
if "%1"=="release" (
    set out_dir=release
    set gn_args=" is_debug = false"
) else (
    set out_dir=debug
    set gn_args=" is_debug = true"
)


echo on
if "%1"=="debug" (
echo build project==========
call gn --args=%gn_args% --ide=vs --sln=all_helloworld gen out\win_proj
)
echo on
echo build %1==========
call gn --args=%gn_args% --ide=vs --sln=all_helloworld gen out\win_%out_dir%
if %errorlevel% neq 0 exit /b %errorlevel%
echo on
call ninja -v -v -C out\win_%out_dir%
if %errorlevel% neq 0 exit /b %errorlevel%


exit /b






:main
call :build_it debug
if %errorlevel% neq 0 exit /b %errorlevel%
call :build_it release
if %errorlevel% neq 0 exit /b %errorlevel%
goto:EOF
