from math import pi, sin
from sys import argv, exit

CONST_EXIT_FAILURE = 1

CONST_COLOR_RESET = "\x1B[0m"

CONST_FREQ = 0.1

class RGB:
    def __init__(self, r: int, g: int, b: int) -> None:
        self.r = r
        self.g = g
        self.b = b
    
    def rainbow(frequency: float, i: int):
        r = int(sin(frequency * i) * 127 + 128)
        g = int(sin(frequency * i + 2 * pi / 3) * 127 + 128)
        b = int(sin(frequency * i + 4 * pi / 3) * 127 + 128)
        return RGB(r, g, b)

    def escape_sequence(self) -> str:
        esc = f'\x1B[38;2;{self.r};{self.g};{self.b}m'
        return esc

def putc_with_rgb(char: str, color: RGB): 
    print(f'{color.escape_sequence()}{char}{CONST_COLOR_RESET}', end='')

if __name__ == "__main__":
    # Check if at least one command line argument was provided
    if len(argv) > 1:
        input = argv[1]

        for index, char in enumerate(input):
            putc_with_rgb(char, RGB.rainbow(CONST_FREQ, index))
    else:
        exit(CONST_EXIT_FAILURE)