uses
  SysUtils;

function Solve(Length: Integer): string;
var
  Prev, Res: string;
  i: Integer;
begin
  Prev := '10';
  Res := Prev;

  for i := 2 to Length - 1 do
  begin
    if Prev = '00' then
      Res := Res + '1'
    else if Prev = '11' then
      Res := Res + '0'
    else
    begin
      if Random < 0.5 then
        Res := Res + '1'
      else
        Res := Res + '0';
    end;
    Prev := Res[i] + Res[i + 1];
  end;

  Result := Res;
end;

function Check(const X: string): Boolean;
var
  L, i: Integer;
  A1, A2, A3: string;
  Ans: Boolean;
begin
  Ans := true;
  for L := 1 to Length(X) do
  begin
    for i := 1 to Length(X) - (L * 3) do
    begin
      A1 := Copy(X, i, L);
      A2 := Copy(X, i + L, L);
      A3 := Copy(X, i + 2 * L, L);

      if (A1 = A2) and (A2 = A3) then
        Ans := false;
    end;
  end;
  Result := Ans;
end;

procedure Main;
var
  Iterating, IsCheckPassed: Boolean;
  Cnt: Integer;
  A: string;
begin
  Randomize;
  Iterating := True;
  Cnt := 0;
    while Iterating do
    begin
      A := Solve(50);
      IsCheckPassed := Check(A);
      Inc(Cnt);
      if IsCheckPassed then
      begin
        Writeln(Format('Success in %s, Result is: %s', [IntToStr(Cnt), A]));
        Iterating := False;
      end;
    end;

    Readln;
end;

begin
  Main;
end.

