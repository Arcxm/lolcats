import std.conv;
import std.math;
import std.stdio;

immutable string colorReset = "\x1B[0m";
immutable double freq = 0.1;

struct RGB {
    ubyte r;
    ubyte g;
    ubyte b;

    static RGB rainbow(double frequency, int i) {
        return RGB(
            cast(ubyte)(sin(frequency * i) * 127 + 128),
            cast(ubyte)(sin(frequency * i + 2 * PI / 3) * 127 + 128),
            cast(ubyte)(sin(frequency * i + 4 * PI / 3) * 127 + 128)
        );
    }

    string escapeSequence() const {
        return "\x1B[38;2;" ~ to!(string)(r) ~ ";" ~ to!(string)(g) ~ ";" ~ to!(string)(b) ~ "m";
    }
}

void putc_with_rgb(char c, RGB color) {
    write(color.escapeSequence() ~ c ~ colorReset);
}

void main(string[] args) {
    // Check if at least one command line argument was provided
    if (args.length > 1) {
        immutable input = args[1];

        for (int i = 0; i < input.length; ++i) {
            putc_with_rgb(input[i], RGB.rainbow(freq, i));
        }
    }
}