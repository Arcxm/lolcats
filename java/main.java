class RGB {
    public int r;
    public int g;
    public int b;

    public RGB(int r, int g, int b) {
        this.r = r;
        this.g = g;
        this.b = b;
    }

    public static RGB rainbow(double frequency, int i) {
        double r = Math.sin(frequency * i) * 127 + 128;
        double g = Math.sin(frequency * i + 2 * Math.PI / 3) * 127 + 128;
        double b = Math.sin(frequency * i + 4 * Math.PI / 3) * 127 + 128;
        
        return new RGB((int) r, (int) g, (int) b);
    }

    public String escape_sequence() {
        return String.format("\u001B[38;2;%d;%d;%dm", this.r, this.g, this.b);
    }
}

class lolcat {
    static final int EXIT_SUCCESS = 0;
    static final int EXIT_FAILURE = 1;

    static final String COLOR_RESET = "\u001B[0m";

    static final double FREQ = 0.1;

    private static void putc_with_rgb(char c, RGB color) {
        System.out.printf("%s%c%s", color.escape_sequence(), c, COLOR_RESET);
    }

    public static void main(String[] args) {
        // Check if at least one command line argument was provided
        if (args.length > 0) {
            final String input = args[0];

            for (int i = 0; i < input.length(); i++) {
                putc_with_rgb(input.charAt(i), RGB.rainbow(FREQ, i));
            }

            System.exit(EXIT_SUCCESS);
        } else {
            System.exit(EXIT_FAILURE);
        }
    }
}