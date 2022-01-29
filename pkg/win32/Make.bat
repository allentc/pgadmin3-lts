@echo on

REM
REM Setup the following values as required for the installation
REM

SET APPVENDOR=The pgAdmin Development Team
SET APPNAME=pgAdmin III
SET APPKEYWORDS=PostgreSQL, pgAdmin
SET APPCOMMENTS=PostgreSQL Tools
SET APPDESCRIPTION=Management and administration tools for the PostgreSQL DBMS
IF "%WIX%"=="" GOTO ERR_NOWIX

SET BUILDTREE="../.."

SET BRANDED=0
SET BRANDINGDIR="../../branding"

REM
REM END OF CONFIG SECTION
REM

if NOT "%1"=="" GOTO REGEN_GUIDS

GOTO ERR_USAGE



:REGEN_GUIDS

if NOT "%1"=="REGENGUIDS" GOTO BUILD_PACKAGE

echo.

echo Regenerating GUIDs in src/pgadmin3.wxs...
perl utils\regenguids.pl src/pgadmin3.wxs
move src\pgadmin3.wxs.out src\pgadmin3.wxs

echo Regenerating GUIDs in src/i18ndata.wxs...
perl utils\regenguids.pl ./src/i18ndata.wxs
move src\i18ndata.wxs.out src\i18ndata.wxs

echo.
echo Done!

GOTO EXIT



:BUILD_PACKAGE

if (%3)==() GOTO ERR_USAGE

echo.
echo Building %APPNAME% Installer...

"%WIX%\bin\candle" -nologo -dLIBSSH2DIR="%LIBSSH2DIR%" -dWXDIR="%WXWIN%" -dPLATFORM_TOOLSET_VERSION=%2 -dVC_TOOLS_REDIST_INSTALL_DIR=%3 -dPGDIR="%PGDIR%" -dBUILDTREE="%BUILDTREE%" -dBRANDED=%BRANDED% -dBRANDINGDIR="%BRANDINGDIR%" -dAPPVENDOR="%APPVENDOR%" -dAPPNAME="%APPNAME%" -dAPPKEYWORDS="%APPKEYWORDS%" -dAPPCOMMENTS="%APPCOMMENTS%" -dAPPDESCRIPTION="%APPDESCRIPTION%" -dAPPVERSION="%1" -dSYSTEM32DIR="%SystemRoot%\System32" -dPFILESDIR="%ProgramFiles%" src/pgadmin3.wxs
IF ERRORLEVEL 1 GOTO ERR_HANDLER

"%WIX%\bin\light" -sice:ICE03 -sice:ICE25 -sice:ICE82 -sw1101 -nologo -ext WixUIExtension -cultures:en-us pgadmin3.wixobj
IF ERRORLEVEL 1 GOTO ERR_HANDLER

echo.
echo Done!
GOTO EXIT

:ERR_HANDLER
echo.
echo Aborting build!
GOTO EXIT

:ERR_USAGE
echo Invalid command line options.
echo Usage: "Make.bat <Major.Minor version number> <Platform toolset version> <VCToolsRedistInstallDir>"
echo        "Make.bat REGENGUIDS"
echo.
GOTO EXIT

:ERR_NOWIX
echo WiX directory not configured!
echo Please make sure the environment variable WIX points to the correct location.
GOTO EXIT



:EXIT