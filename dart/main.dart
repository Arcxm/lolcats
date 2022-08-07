import 'dart:io';
import 'dart:math';

const int EXIT_FAILURE = 1;

const String COLOR_RESET = '\x1B[0m';

const double FREQ = 0.1;

class RGB {
  int r = 0;
  int g = 0;
  int b = 0;

  RGB(int r, int g, int b) {
    this.r = r;
    this.g = g;
    this.b = b;
  }

  static RGB rainbow(double frequency, int i) {
    final r = sin(frequency * i) * 127 + 128;
    final g = sin(frequency * i + 2 * pi / 3) * 127 + 128;
    final b = sin(frequency * i + 4 * pi / 3) * 127 + 128;

    return RGB(r.toInt(), g.toInt(), b.toInt());
  }

  String escape_sequence() {
    return '\x1B[38;2;$r;$g;${b}m';
  }
}

void putc_with_rgb(String c, RGB color) {
  stdout.write('${color.escape_sequence()}$c$COLOR_RESET');
}

void main(List<String> args) {
  // Check if at least one command line argument was provided
  if (args.length > 0) {
    final input = args[0];

  	var i = 0;
    input.runes.forEach((int rune) {
      var character = new String.fromCharCode(rune);
      putc_with_rgb(character, RGB.rainbow(FREQ, i));

      i++;
    });
  } else {
    exit(EXIT_FAILURE);
  }
}