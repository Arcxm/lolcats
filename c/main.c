#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#define _USE_MATH_DEFINES
#include <math.h>

#define COLOR_RESET "\x1B[0m"

#define FREQ 0.1

typedef struct rgb_t {
    uint8_t r;
    uint8_t g;
    uint8_t b; 
} rgb;

rgb rainbow(double frequency, int i) {
    rgb color = {
        .r = sin(frequency * i) * 127 + 128,
        .g = sin(frequency * i + 2 * M_PI / 3) * 127 + 128,
        .b = sin(frequency * i + 4 * M_PI / 3) * 127 + 128
    };

    return color;
}

void putc_with_rgb(char c, rgb color) {
    printf("\x1B[38;2;%d;%d;%dm", color.r, color.g, color.b);

    printf("%c", c);

    printf("%s", COLOR_RESET);
}

int main(int argc, char **argv) {
    // Check if at least one command line argument was provided
    if (argc > 1) {
        const char *const input = argv[1];

        size_t sz = strlen(input);
        for (size_t i = 0; i < sz; ++i) {
            putc_with_rgb(input[i], rainbow(FREQ, i));
        }
    } else {
        return EXIT_FAILURE;
    }
}