<?php
declare(strict_types=1);

const EXIT_FAILURE = 1;

const COLOR_RESET = "\x1B[0m";

const FREQ = 0.1;

class RGB {
    public $r;
    public $g;
    public $b;

    function __construct(int $r, int $g, int $b) {
        $this->r = $r;
        $this->g = $g;
        $this->b = $b;
    }

    public static function rainbow(float $frequency, int $i): RGB {
        $r = sin($frequency * $i) * 127 + 128;
        $g = sin($frequency * $i + 2 * pi() / 3) * 127 + 128;
        $b = sin($frequency * $i + 4 * pi() / 3) * 127 + 128;

        return new RGB((int) $r, (int) $g, (int) $b);
    }
}

function putc_with_rgb(string $c, RGB $color) {
    echo "\x1B[38;2;{$color->r};{$color->g};{$color->b}m{$c}" . COLOR_RESET;
}

function main() {
    global $argc, $argv;

    // Check if at least one command line argument was provided
    if ($argc > 1) {
        $input = $argv[1];
        
        for ($i = 0; $i < strlen($input); ++$i) {
            putc_with_rgb($input[$i], RGB::rainbow(FREQ, $i));
        }
    } else {
        exit(EXIT_FAILURE);
    }
}

main();

?>