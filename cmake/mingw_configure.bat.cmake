@echo off
for %%X in (msys2_shell.cmd) do (set FOUND=%%~$PATH:X)
if defined FOUND goto startmsys2

:notfound
echo Cannot find the msys2_shell -- aborting.
pause
exit 1

:startmsys2
cmd /C msys2_shell.cmd -mingw32 -here -full-path -no-start -defterm -shell sh -l @CMAKE_CURRENT_BINARY_DIR@/EP_@MSVC_PROJNAME@_configure.sh

:EOF
