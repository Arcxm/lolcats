with Ada.Characters.Latin_1;
with Ada.Command_Line;
with Ada.Integer_Text_IO;
with Ada.Numerics;
with Ada.Numerics.Elementary_Functions;
with Ada.Strings.Unbounded;
with Text_IO;

procedure main is
    use Ada.Characters.Latin_1;
    use Ada.Command_Line;
    use Ada.Integer_Text_IO;
    use Ada.Numerics;
    use Ada.Numerics.Elementary_Functions;
    use Ada.Strings.Unbounded;
    use Text_IO;

    Color_Reset: constant String := ESC & "[0m";
    Freq: constant Float := 0.1;

    unbound_input: Unbounded_String := (if Argument_Count > 0 then
        To_Unbounded_String(Argument(1))
    else
        Null_Unbounded_String
    );

    type RGB is tagged record
        r, g, b: Integer;
    end record;

    function Rainbow (frequency: in Float; i: in Integer) return RGB is
        color: RGB;
    begin
        color.r := Integer(Sin(Freq * Float(i)) * Float(127) + Float(128));
        color.g := Integer(Sin(Freq * Float(i) + Float(2) * Pi / Float(3)) * Float(127) + Float(128));
        color.b := Integer(Sin(Freq * Float(i) + Float(4) * Pi / Float(3)) * Float(127) + Float(128));

        return color;
    end Rainbow;

    procedure Putc_With_RGB (c: in Character; color: in RGB) is
    begin
        -- Using the Integers 'Image attribute won't work as they contain a space and that results in an invalid escape sequence (e.g. "\x1B[38;2; 128; 0; 0m")
        -- So we print the escape sequence this way:
        Put(ESC & "[38;2;");
        Put(color.r, Width => 0);
        Put(";");
        Put(color.g, Width => 0);
        Put(";");
        Put(color.b, Width => 0);
        Put("m" & c & Color_Reset);
    end;

begin
    if Argument_Count > 0 then
        for i in 1 .. Length(unbound_input) loop
            Putc_With_RGB(Element(unbound_input, i), Rainbow(Freq, i));
        end loop;
    end if;
end main;