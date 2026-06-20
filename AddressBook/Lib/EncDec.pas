unit EncDec;

interface

function Base64Encode(const s: string): string;
function Base64Decode(const s: string): string;
function EncDecXor(const s : String): String;
function Encrypt(const s : WideString): String;
function Decrypt(const s : String): WideString;

implementation

uses
   SysUtils;

const
   myKey    = '!(&(>!)>!%_!(*))*!(';
   B64Table = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

//-----------------------------------------------------------------------------

function Base64Encode(const S: string): string;
var
  InBuf: array[0..2] of Byte;
  OutBuf: array[0..3] of Char;
  iI, iJ: Integer;
begin
  SetLength(Result, ((Length(S) + 2) div 3) * 4);
  for iI := 1 to ((Length(S) + 2) div 3) do begin
    if Length(S) < (iI * 3) then
      Move(S[(iI - 1) * 3 + 1], InBuf, Length(S) - (iI - 1) * 3)
    else
      Move(S[(iI - 1) * 3 + 1], InBuf, 3);
    OutBuf[0] := B64Table[((InBuf[0] and $FC) shr 2) + 1];
    OutBuf[1] := B64Table[(((InBuf[0] and $3) shl 4) or ((InBuf[1] and $F0) shr 4)) + 1];
    OutBuf[2] := B64Table[(((InBuf[1] and $F) shl 2) or ((InBuf[2] and $C0) shr 6)) + 1];
    OutBuf[3] := B64Table[(InBuf[2] and $3F) + 1];
    Move(OutBuf, Result[(iI - 1) * 4 + 1], 4);
  end;
  if Length(S) mod 3 = 1 then begin
    Result[Length(Result) - 1] := '=';
    Result[Length(Result)] := '=';
  end else if Length(S) mod 3 = 2 then
    Result[Length(Result)] := '=';
end;

//-----------------------------------------------------------------------------

function Base64Decode(const S: string): string;
var
  OutBuf: array[0..2] of Byte;
  InBuf : array[0..3] of Byte;
  iI, iJ: Integer;
begin
  if Length(S) mod 4 <> 0 then
    raise Exception.Create('Base64: Incorrect string format');
  SetLength(Result, ((Length(S) div 4) - 1) * 3);
  for iI := 1 to (Length(S) div 4) - 1 do begin
    Move(S[(iI - 1) * 4 + 1], InBuf, 4);
    for iJ := 0 to 3 do
      case InBuf[iJ] of
        43: InBuf[iJ] := 62;
        48..57: Inc(InBuf[iJ], 4);
        65..90: Dec(InBuf[iJ], 65);
        97..122: Dec(InBuf[iJ], 71);
      else
        InBuf[iJ] := 63;
      end;
    OutBuf[0] := (InBuf[0] shl 2) or ((InBuf[1] shr 4) and $3);
    OutBuf[1] := (InBuf[1] shl 4) or ((InBuf[2] shr 2) and $F);
    OutBuf[2] := (InBuf[2] shl 6) or (InBuf[3] and $3F);
    Move(OutBuf, Result[(iI - 1) * 3 + 1], 3);
  end;
  if Length(S) <> 0 then begin
    Move(S[Length(S) - 3], InBuf, 4);
    if InBuf[2] = 61 then begin
      for iJ := 0 to 1 do
        case InBuf[iJ] of
          43: InBuf[iJ] := 62;
          48..57: Inc(InBuf[iJ], 4);
          65..90: Dec(InBuf[iJ], 65);
          97..122: Dec(InBuf[iJ], 71);
        else
          InBuf[iJ] := 63;
        end;
      OutBuf[0] := (InBuf[0] shl 2) or ((InBuf[1] shr 4) and $3);
      Result := Result + Char(OutBuf[0]);
    end else if InBuf[3] = 61 then begin
      for iJ := 0 to 2 do
        case InBuf[iJ] of
          43: InBuf[iJ] := 62;
          48..57: Inc(InBuf[iJ], 4);
          65..90: Dec(InBuf[iJ], 65);
          97..122: Dec(InBuf[iJ], 71);
        else
          InBuf[iJ] := 63;
        end;
      OutBuf[0] := (InBuf[0] shl 2) or ((InBuf[1] shr 4) and $3);
      OutBuf[1] := (InBuf[1] shl 4) or ((InBuf[2] shr 2) and $F);
      Result := Result + Char(OutBuf[0]) + Char(OutBuf[1]);
    end else begin
      for iJ := 0 to 3 do
        case InBuf[iJ] of
          43: InBuf[iJ] := 62;
          48..57: Inc(InBuf[iJ], 4);
          65..90: Dec(InBuf[iJ], 65);
          97..122: Dec(InBuf[iJ], 71);
        else
          InBuf[iJ] := 63;
        end;
      OutBuf[0] := (InBuf[0] shl 2) or ((InBuf[1] shr 4) and $3);
      OutBuf[1] := (InBuf[1] shl 4) or ((InBuf[2] shr 2) and $F);
      OutBuf[2] := (InBuf[2] shl 6) or (InBuf[3] and $3F);
      Result := Result + Char(OutBuf[0]) + Char(OutBuf[1]) + Char(OutBuf[2]);
    end;
  end;
end;

//-----------------------------------------------------------------------------

function EncDecXor(const s : String): String;
var
   i, j, code: Integer;
begin
   j:=1;
   Result:='';
   for i:=1 to Length(s) do
   begin
      if j > Length(myKey) then
         j:=1;
      code:=(Ord(s[I]) xor Ord(myKey[j]));
      Result:=Result + Chr(code);
      j:=j + 1;
   end;
end;

//-----------------------------------------------------------------------------

function Encrypt(const s : WideString): String;
begin
   Result:=UTF8Encode(s);
   Result:=EncDecXor(Result);
   Result:=Base64Encode(Result);
end;

//-----------------------------------------------------------------------------

function Decrypt(const s : String): WideString;
var
  sTmp: String;
begin
   sTmp:=s;
   sTmp:=Base64Decode(sTmp);
   sTmp:=EncDecXor(sTmp);
   Result:=UTF8Decode(sTmp);
end;

//-----------------------------------------------------------------------------

end.
