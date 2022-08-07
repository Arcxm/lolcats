using System;

namespace loclat {
    struct RGB {
        public byte r { get; }
        public byte g { get; }
        public byte b { get; }

        public RGB(byte r, byte g, byte b) {
            this.r = r;
            this.g = g;
            this.b = b;
        }

        public static RGB rainbow(double frequency, int i) {
            var r = Math.Sin(frequency * i) * 127 + 128;
            var g = Math.Sin(frequency * i + 2 * Math.PI / 3) * 127 + 128;
            var b = Math.Sin(frequency * i + 4 * Math.PI / 3) * 127 + 128;

            return new RGB((byte) r, (byte) g, (byte) b);
        }

        public string escape_sequence() {
            return $"\x1B[38;2;{this.r};{this.g};{this.b}m";
        }
    }

    class Program {
        const int EXIT_SUCCESS = 0;
        const int EXIT_FAILURE = 1;

        const string COLOR_RESET = "\x1B[0m";

        const double FREQ = 0.1;

        static void putc_with_rgb(char c, RGB color) {
            Console.Write($"{color.escape_sequence()}{c}{COLOR_RESET}");
        }

        static int Main(string[] args) {
            // Check if at least one command line argument was provided
            if (args.Length > 0) {
                string input = args[0];

                int i = 0;
                foreach (char c in input) {
                    putc_with_rgb(c, RGB.rainbow(FREQ, i));

                    i++;
                }

                return EXIT_SUCCESS;
            } else {
                return EXIT_FAILURE;
            }
        }
    }
}