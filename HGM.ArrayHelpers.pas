unit HGM.ArrayHelpers;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections;

type
  TArrayOfString = TArray<string>;

  TArrayOfInteger = TArray<Integer>;

  TArrayOfStringHelper = record helper for TArrayOfString
    function ToString: string; overload; inline;
    function ToJson: string; overload; inline;
    function Add(const Value: string): Integer; inline;
    procedure Delete(const Value: string); inline;
    procedure Assign(Source: TStrings); overload;
    function IsEmpty: Boolean;
    function Length: Integer;
    function IndexOf(const Value: string): Integer;
    function Contains(const Value: string): Boolean;
  end;

  TArrayOfIntegerHelper = record helper for TArrayOfInteger
    function ToString: string; overload; inline;
    function ToJson: string; overload; inline;
    function Add(Value: Integer): Integer; overload; inline;
    function Add(Value: array of integer): Integer; overload;
    procedure Delete(const Value: Integer); inline;
    function IsEmpty: Boolean;
    function Length: Integer;
    function IndexOf(const Value: Integer): Integer;
    function Contains(const Value: Integer): Boolean;
  end;

implementation

{ TArrayOfIntegerHelper }

function TArrayOfIntegerHelper.Add(Value: Integer): Integer;
begin
  Result := System.Length(Self) + 1;
  SetLength(Self, Result);
  Self[Result - 1] := Value;
end;

function TArrayOfIntegerHelper.Add(Value: array of integer): Integer;
var
  s, i: integer;
begin
  s := System.Length(Self);
  Result := s + System.Length(Value);
  SetLength(Self, Result);
  for i := 0 to High(Value) do
    Self[s + i] := Value[i];
end;

function TArrayOfIntegerHelper.Contains(const Value: Integer): Boolean;
begin
  Result := IndexOf(Value) >= 0;
end;

procedure TArrayOfIntegerHelper.Delete(const Value: Integer);
var
  i: Integer;
begin
  i := IndexOf(Value);
  if i >= 0 then
    System.Delete(Self, i, 1);
end;

function TArrayOfIntegerHelper.IndexOf(const Value: Integer): Integer;
var
  i: Integer;
begin
  for i := Low(Self) to High(Self) do
    if Self[i] = Value then
      Exit(i);
  Result := -1;
end;

function TArrayOfIntegerHelper.IsEmpty: Boolean;
begin
  Result := System.Length(Self) = 0;
end;

function TArrayOfIntegerHelper.Length: Integer;
begin
  Result := System.Length(Self);
end;

function TArrayOfIntegerHelper.ToJson: string;
var
  i: Integer;
begin
  Result := '[';
  for i := Low(Self) to High(Self) do
  begin
    if i <> Low(Self) then
      Result := Result + ',';
    Result := Result + '"' + Self[i].ToString + '"';
  end;
  Result := Result + ']';
end;

function TArrayOfIntegerHelper.ToString: string;
var
  i: Integer;
begin
  for i := Low(Self) to High(Self) do
  begin
    if i <> Low(Self) then
      Result := Result + ',';
    Result := Result + Self[i].ToString;
  end;
end;

{ TArrayOfStringHelper }

function TArrayOfStringHelper.IndexOf(const Value: string): Integer;
var
  i: Integer;
begin
  for i := Low(Self) to High(Self) do
    if Self[i] = Value then
      Exit(i);
  Result := -1;
end;

function TArrayOfStringHelper.IsEmpty: Boolean;
begin
  Result := System.Length(Self) = 0;
end;

function TArrayOfStringHelper.Length: Integer;
begin
  Result := System.Length(Self);
end;

function TArrayOfStringHelper.ToJson: string;
var
  i: Integer;
begin
  Result := '[';
  for i := Low(Self) to High(Self) do
  begin
    if i <> Low(Self) then
      Result := Result + ',';
    Result := Result + '"' + Self[i] + '"';
  end;
  Result := Result + ']';
end;

function TArrayOfStringHelper.ToString: string;
var
  i: Integer;
begin
  for i := Low(Self) to High(Self) do
  begin
    if i <> Low(Self) then
      Result := Result + ',';
    Result := Result + Self[i];
  end;
end;

function TArrayOfStringHelper.Add(const Value: string): Integer;
begin
  Result := System.Length(Self) + 1;
  SetLength(Self, Result);
  Self[Result - 1] := Value;
end;

procedure TArrayOfStringHelper.Assign(Source: TStrings);
var
  i: Integer;
begin
  SetLength(Self, Source.Count);
  for i := 0 to Source.Count - 1 do
    Self[i] := Source[i];
end;

function TArrayOfStringHelper.Contains(const Value: string): Boolean;
begin
  Result := IndexOf(Value) >= 0;
end;

procedure TArrayOfStringHelper.Delete(const Value: string);
var
  i: Integer;
begin
  i := IndexOf(Value);
  if i >= 0 then
    System.Delete(Self, i, 1);
end;

end.

