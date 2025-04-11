@rem build_w32vc.bat
@echo off
setlocal enabledelayedexpansion

if not exist "%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" goto no_vswhere
for /f "usebackq tokens=*" %%i in (`"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -latest -prerelease -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath`) do (
  set InstallDir=%%i
)
if not exist "%InstallDir%\Common7\Tools\vsdevcmd.bat" goto no_vswhere
call "%InstallDir%\Common7\Tools\vsdevcmd.bat" %*
goto have_vc

:no_vswhere
rem This file builds and tests CCCC under Microsoft Visual Studio.
rem Path to Microsoft Visual Studio standard edition release 6.0
set VCDIR=c:\Program Files\Microsoft Visual Studio\vc98
if not exist "%VCDIR%\bin\vcvars32.bat" goto no_vc

call "%VCDIR%\bin\vcvars32.bat"
:have_vc
if not exist pccts\bin mkdir pccts\bin

cd pccts\dlg
if exist *.obj del *.obj
nmake -nologo -f DlgMS.mak
copy dlg.exe ..\bin
cd ..\..

cd pccts\antlr
if exist *.obj del *.obj
nmake -nologo -f AntlrMS.mak
copy antlr.exe ..\bin
cd ..\..

cd cccc
if exist *.obj del *.obj
if exist *.cpp del *.cpp
nmake -nologo -f w32vc.mak
cd ..

cd test
nmake -nologo -f w32vc.mak
cd ..

rem vswhere is a vs2017+ thing, ancient vcaddin won't compile.
if exist "%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" goto end
cd vcaddin
nmake -nologo -f CcccDevStudioAddIn.mak CFG="CcccDevStudioAddIn - Win32 Release"
cd ..


goto end

:no_vc
echo This script expects MS Visual C++ to be in %VCDIR%
echo Please modify the script if the location is different.



:end
rem show "Press any key to continue" if build_w32vc.bat was run from exlorer
IF %0 == "%~0" pause
