const EXIT_FAILURE = 1;

const COLOR_RESET = "\x1B[0m";

const FREQ = 0.1;

class RGB {
    constructor(r, g, b) {
        this.r = r;
        this.g = g;
        this.b = b;
    }

    static rainbow(frequency, i) {
        let r = Math.sin(frequency * i) * 127 + 128;
        let g = Math.sin(frequency * i + 2 * Math.PI / 3) * 127 + 128;
        let b = Math.sin(frequency * i + 4 * Math.PI / 3) * 127 + 128;
        
        return new RGB(Math.floor(r), Math.floor(g), Math.floor(b));
    }

    escape_sequence() {
        return `\x1B[38;2;${this.r};${this.g};${this.b}m`;
    }
}

function putc_with_rgb(c, color) {
    process.stdout.write(`${color.escape_sequence()}${c}${COLOR_RESET}`);
}

function main() {
    // Index 0 is the path to the node executable
    // Index 1 is the path to the script file
    let argv = process.argv.slice(2);
    let argc = argv.length;

    // Check if at least one command line argument was provided
    // See notes above
    if (argc > 0) {
        let input = argv[0];

        for (var i = 0; i < input.length; ++i) {
            putc_with_rgb(input.charAt(i), RGB.rainbow(FREQ, i));
        }
    } else {
        process.exit(EXIT_FAILURE);
    }
}

if (require.main === module) {
    main();
}