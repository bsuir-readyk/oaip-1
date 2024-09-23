program SolveExpression;

{$APPTYPE CONSOLE}
// (abs(ln(x²)) + 2 + 1 / 5) / (ℯ^(x / π) + nroot(x² + 1,3) + 1 + 1 / 4)

uses
  SysUtils;

function CubicRoot(Value: Double): Double;
begin
  Result := Exp(Ln(Value) / 3);
end;

function Min(a: Double; b: Double): Double;
begin
  if a >= b then
    Min := b
  else
    Min := a;
end;

function Max(a: Double; b: Double): Double;
begin
  if a >= b then
    Max := a
  else
    Max := b;
end;

function CompGreater(a: Double; b: Double): Boolean;
begin
  CompGreater := a > b
end;

function CompLower(a: Double; b: Double): Boolean;
begin
  CompLower := a < b
end;


function Compute(x: Double): Double;
var
  numerator, denominator: Double;
begin
  if x = 0 then
    raise Exception.Create('No value defined when x is 0');

  numerator := abs(Ln(x * x)) + 2.2;

  denominator := Exp(x / Pi) + CubicRoot(x * x + 1) + 1.25;

  Result := numerator / denominator;
end;


procedure LogResult(arg: Double; res: Double; pres: Integer = 5);
begin
  WriteLn(Format('x=%-15.'+IntToStr(pres)+'g f(x)=%-15.'+IntToStr(pres)+'g', [arg, res]));
end;


function Test(x: Double; needed: Double): Boolean;
var
  res: Double;
  testResult: Boolean;
begin
  res := Compute(x);
  testResult := res = needed;
  if not testResult then
    raise Exception.Create('Test not passed:'
      +'\nNeeded {'+FloatToStr(needed)+'}'
      +'\nBut got {'+FloatToStr(res)+'}');

  Test := res = needed;
end;

var
  comp: function(a: Double; b: Double): Boolean;
  a, b, h, x, ans, finish: Double;
  pres: Integer;

begin
  try
    try
      Write('a: ');
      ReadLn(a);
      Write('b: ');
      ReadLn(b);
      Write('h: ');
      ReadLn(h);

//      Write('pres: ');
//      ReadLn(pres);

      if (not (a = b)) and (h = 0) then
        raise Exception.Create('{h} cant be 0 in case {a} != {b}');
      if (b > a) and (h < 0) then
        raise Exception.Create('{h} must be greater than 0 in case {b} is greater than {a}');
      if (b < a) and (h > 0) then
        raise Exception.Create('{h} must be less 0 in case {b} is less than {a}');

      if h > 0 then
      begin
        x := Min(a, b);
        finish := Max(a, b);
        comp := CompLower;
      end
      else
      begin
        x := Max(a, b);
        finish := Min(a, b);
        comp := CompGreater;
      end;

      while comp(x, finish) do
      begin
        ans := Compute(x);
        LogResult(x, ans);
        x := x + h;
      end;

      ans := Compute(b);
      LogResult(b, ans);
    except
      on E: Exception do
        WriteLn('Error: ', E.Message);
    end;
  finally
    ReadLn;
  end;
end.

