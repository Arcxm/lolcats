#include <format>
#include <iostream>
#include <numbers>
#include <sstream>
#include <string>

#include <cmath>

#define COLOR_RESET "\x1B[0m"

#define FREQ 0.1

class RGB {
private:
    uint8_t r;
    uint8_t g;
    uint8_t b;
public:
    RGB(uint8_t r, uint8_t g, uint8_t b);

    static RGB rainbow(double frequency, int i);

    std::string escapeSequence();

    ~RGB();
};

RGB::RGB(uint8_t r, uint8_t g, uint8_t b) {
    this->r = r;
    this->g = g;
    this->b = b;
}

RGB RGB::rainbow(double frequency, int i) {
    uint8_t r = sin(frequency * i) * 127 + 128;
    uint8_t g = sin(frequency * i + 2 * std::numbers::pi / 3) * 127 + 128;
    uint8_t b = sin(frequency * i + 4 * std::numbers::pi / 3) * 127 + 128;
    
    return RGB(r, g, b);
}

std::string RGB::escapeSequence() {
    return std::format("\x1B[38;2;{0};{1};{2}m", this->r, this->g, this->b);
}

RGB::~RGB() {}

void putc_with_rgb(char c, RGB color) {
    std::cout << color.escapeSequence() << c << COLOR_RESET;
}

int main(int argc, char **argv) {
    // Check if at least one command line argument was provided
    if (argc > 1) {
        std::string input = std::string(argv[1]);
        
        size_t i = 0;
        for (auto iter = input.begin(); iter != input.end(); iter++) {
            putc_with_rgb(*iter, RGB::rainbow(FREQ, i));

            i++;
        }

        return EXIT_SUCCESS;
    } else {
        return EXIT_FAILURE;
    }
}