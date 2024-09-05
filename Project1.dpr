﻿program SolveExpression;

{$APPTYPE CONSOLE}
// (abs(ln(x²)) + 2 + 1 / 5) / (ℯ^(x / π) + nroot(x² + 1,3) + 1 + 1 / 4)

uses
  SysUtils;


// micro-functions
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



// helpers
procedure LogResult(arg: Double; res: Double; pres: Integer = 5);
begin
  WriteLn(Format('x=%-15.' + IntToStr(pres) + 'g f(x)=%-15.' + IntToStr(pres) +
    'g', [arg, res]));
end;

procedure ThrowError(msg: String);
begin
  WriteLn(Format('Error: %s', [msg]));
  Readln;
end;


// math solution
function Compute(x: Double): Double;
var
  numerator, denominator: Double;
begin
  if x = 0 then
    ThrowError('No value defined when x is 0');

  numerator := abs(Ln(x * x)) + 2.2;

  denominator := Exp(x / Pi) + CubicRoot(x * x + 1) + 1.25;

  Result := numerator / denominator;
end;



// main
var
  comp: function(a: Double; b: Double): Boolean;
  input: String;
  isError: Boolean;
  a, b, h, x, ans, finish: Double;
  pres: Integer;
begin
  Write('a: ');
  Readln(input);
  isError := not TryStrToFloat(input, a);
  if isError then
    ThrowError('{a} should be float');


  Write('b: ');
  Readln(input);
  isError := not TryStrToFloat(input, b);
  if isError then
    ThrowError('{b} should be float');

  Write('h: ');
  Readln(input);
  isError := not TryStrToFloat(input, h);
  if isError then
    ThrowError('{h} should be float');
  // Write('pres: ');
  // ReadLn(pres);

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

  ans := Compute(a);
  LogResult(a, ans);


//  if (not(a = b)) and (h = 0) then
//    ThrowError('{h} cant be 0 in case {a} != {b}');
//  if (b > a) and (h < 0) then
//    ThrowError('{h} must be greater than 0 in case {b} is greater than {a}');
//  if (b < a) and (h > 0) then
//    ThrowError('{h} must be less 0 in case {b} is less than {a}');

  isError := ((not(a = b)) and (h = 0))
                or ((b > a) and (h < 0))
                or ((b < a) and (h > 0));

  if not isError then
  begin
    x := x + h;
    while comp(x, finish) do
    begin
      ans := Compute(x);
      LogResult(x, ans);
      x := x + h;
    end;
  end;

  ans := Compute(b);
  LogResult(b, ans);
  Readln;
end.
