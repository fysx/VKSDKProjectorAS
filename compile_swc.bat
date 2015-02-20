@echo off
set PAUSE_ERRORS=1
set FLEX_SDK=C:\airsdk

call "%FLEX_SDK%\bin\compc" -load-config=%FLEX_SDK%\frameworks\air-config.xml -source-path src -include-sources src -swf-version 20 -external-library-path %FLEX_SDK%\frameworks\libs\air\airglobal.swc -output bin\VKSDKProjector.swc
echo.
echo swc compile completed
echo.
call "C:\Program Files\7-Zip\7z.exe" x -y bin\VKSDKProjector.swc
call cp library.swf jar\Android-ARM\library.swf
call rm library.swf catalog.xml
echo.
echo swc extracted ok
call %FLEX_SDK%\bin\adt -package -target ane bin\VKSDKProjector.ane extension.xml -swc bin\VKSDKProjector.swc -platform Android-ARM -C jar/Android-ARM .
echo.
echo ane compiled ok
echo.
pause