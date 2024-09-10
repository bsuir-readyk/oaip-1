﻿program SolveExpression;

{$APPTYPE CONSOLE}
// y=f(x)
// x = [a..h..b]
// y = (abs(ln(x²)) + 2 + 1 / 5) / (ℯ^(x / π) + nroot(x² + 1,3) + 1 + 1 / 4)

uses
  SysUtils;

// micro-functions
function CubicRoot(Value: Single): Single; inline;
begin
  Result := Exp(Ln(Value) / 3);
end;

function Min(a: Single; b: Single): Single;
begin
  if a >= b then
    Result := b
  else
    Result := a;
end;

function Max(a: Single; b: Single): Single;
begin
  if a >= b then
    Result := a
  else
    Result := b;
end;

function CompGreater(a: Single; b: Single): Boolean; inline;
begin
  CompGreater := a > b
end;

function CompLower(a: Single; b: Single): Boolean; inline;
begin
  CompLower := a < b
end;

// helpers
procedure LogResult(x: Single; y: Single); overload; inline;
begin
  WriteLn(Format('%8.3f %-15.4g', [x, y]));
end;

procedure LogResult(x: Single; error: String); overload; inline;
begin
  WriteLn(Format('%8.3f %-s', [x, error]));
end;

procedure RepeatedReadTo(var readTo: Single; gentleInput: String = '');
var
  error: String;
begin
  repeat
  begin
    error := '';
    Write(gentleInput);
    try
      ReadLn(readTo);
    except
      on E: Exception do
      begin
        error := E.Message;
        WriteLn(error);
      end;
    end;
  end;
  until error = '';
end;

// math solution
function Compute(x: Single; out error: String): Single;
var
  numerator, denominator: Single;
begin
  if x = 0 then
  begin
    error := 'функция не определена';
    Result := MaxInt;
  end
  else
  begin
    numerator := abs(Ln(x * x)) + 2.2;
    denominator := Exp(x / Pi) + CubicRoot(x * x + 1) + 1.25;

    error := '';
    Result := numerator / denominator;
  end;
end;

// main
var
  comparator: function(a: Single; b: Single): Boolean;
  error: String;
  needCycle: Boolean;
  a, b, h, x, ans, finish: Single;

begin
  error := '';

  RepeatedReadTo(a, 'a: ');
  RepeatedReadTo(b, 'b: ');
  RepeatedReadTo(h, 'h: ');

  // If step is above 0
  if h > 0 then
  begin
    x := Min(a, b);
    finish := Max(a, b);
    comparator := CompLower;
  end
  else
  begin
    x := Max(a, b);
    finish := Min(a, b);
    comparator := CompGreater;
  end;

  WriteLn('   x     y');

  ans := Compute(a, error);
  if error <> '' then
    LogResult(a, error)
  else
    LogResult(a, ans);

  needCycle := not (
    (h = 0)
    or (a = b)
    or ((b > a) and (h < 0))
    or ((b < a) and (h > 0))
  );

  if needCycle then
  begin
    x := x + h;
    while comparator(x, finish) do
    begin
      ans := Compute(x, error);
      if error <> '' then
        LogResult(x, error)
      else
        LogResult(x, ans);

      x := x + h;
    end;
  end;

  // when a != b
  if (
    needCycle
    or (not needCycle and (Abs(a - b) > (1 / 1e9)))
  ) then
  begin
    ans := Compute(b, error);
    if error <> '' then
      LogResult(b, error)
    else
      LogResult(b, ans);
  end;

  ReadLn;
end.

