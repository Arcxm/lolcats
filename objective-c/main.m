#import <Foundation/Foundation.h>

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#include <math.h>

#ifndef PI
#define PI (acos(-1))
#endif

#define COLOR_RESET "\x1B[0m"

#define FREQ 0.1

@interface RGB : NSObject

@property (nonatomic, assign) uint8_t r;
@property (nonatomic, assign) uint8_t g;
@property (nonatomic, assign) uint8_t b;

// rainbow
- (id) initWithFrequency: (double) frequency andI: (int) i;
- (NSString*) escapeSequence;

@end

@implementation RGB

- (id) initWithFrequency: (double) frequency andI: (int) i {
    self.r = sin(frequency * i) * 127 + 128;
    self.g = sin(frequency * i + 2 * PI / 3) * 127 + 128;
    self.b = sin(frequency * i + 4 * PI / 3) * 127 + 128;

    return self;
}

- (NSString*) escapeSequence {
    return [NSString stringWithFormat:@"\x1B[38;2;%d;%d;%dm", self.r, self.g, self.b];
}

@end

void putc_with_rgb(char c, RGB *color) {
    printf("%s%c%s", [[color escapeSequence] UTF8String], c, COLOR_RESET);
}

int main(int argc, char **argv) {
    int exitCode = EXIT_SUCCESS;

    @autoreleasepool {
        // Check if at least one command line argument was provided
        if (argc > 1) {
            NSString *input = [NSString stringWithUTF8String: argv[1]];

            NSUInteger sz = [input length];
            for (NSUInteger i = 0; i < sz; ++i) {
                putc_with_rgb([input characterAtIndex: i], [[RGB alloc] initWithFrequency: FREQ andI: i]);
            }
        } else {
            exitCode = EXIT_FAILURE;
        }
    }

    return exitCode;
}
