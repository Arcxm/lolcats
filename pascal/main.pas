program lolcat;

uses
  SysUtils;

type
RGB = record
  r: Integer;
  g: Integer;
  b: Integer;
end;

function rainbow(frequency: Real; i: Integer): RGB;
var
  color: RGB;
begin
  color.r := round(sin(frequency * i) * 127 + 128);
  color.g := round(sin(frequency * i + 2 * Pi / 3) * 127 + 128);
  color.b := round(sin(frequency * i + 4 * Pi / 3) * 127 + 128);

  rainbow := color;
end;

procedure putc_with_rgb(c: Char; color: RGB);
begin
  Write(#27'[38;2;' + inttostr(color.r) + ';' + inttostr(color.g) + ';' + inttostr(color.b) + 'm' + c + #27'[0m');  
end;

const
  freq: Real = 0.1;
var
  color: RGB;
  i: Integer = 0;
  c: Char;
begin
  if ParamCount > 0 then
  begin
    for c in ParamStr(1) do
    begin
      color := rainbow(freq, i);
      i := i + 1;

      putc_with_rgb(c, color);
    end;
  end;
end.
