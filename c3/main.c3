import std::io;
import std::math;

const String COLOR_RESET = "\x1B[0m";

const double FREQ = 0.1;

struct Rgb {
    char r, g, b;
}

fn Rgb rainbow(double frequency, int i) {
    return {
        (char) (math::sin(frequency * i) * 127 + 128),
        (char) (math::sin(frequency * i + 2 * math::PI / 3) * 127 + 128),
        (char) (math::sin(frequency * i + 4 * math::PI / 3) * 127 + 128)
    };
}

fn void putc_with_rgb(char c, Rgb color) {
    io::printf("\x1B[38;2;%d;%d;%dm%c%s", color.r, color.g, color.b, c, COLOR_RESET);
}

fn void main(String[] args) {
    if (args.len > 1) {
        String input = args[1];

        for (int i = 0; i < input.len; ++i) {
            putc_with_rgb(input[i], rainbow(FREQ, i));
        }
    }
}