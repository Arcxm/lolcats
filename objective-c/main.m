#import <Foundation/Foundation.h>

#import <stdio.h>
#import <stdlib.h>
#import <stdint.h>

#import <math.h>
#define PI (acos(-1))

#define COLOR_RESET "\x1B[0m"

#define FREQ 0.1

@interface rgb:NSObject {
    uint8_t r;
    uint8_t g;
    uint8_t b;
}

// rainbow
- (id) initWithFrequency: (double) frequency andI: (int) i;
- (NSString*) escapeSequence;

@end

@implementation rgb

- (id) initWithFrequency: (double) frequency andI: (int) i {
    r = sin(frequency * i) * 127 + 128;
    g = sin(frequency * i + 2 * PI / 3) * 127 + 128;
    b = sin(frequency * i + 4 * PI / 3) * 127 + 128;
}

- (NSString*) escapeSequence {
    return [NSString stringWithFormat:@"\x1B[38;2;%d;%d;%dm", r, g, b];
}

@end

void putc_with_rgb(char c, rgb *color) {
    printf("%s%c%s", [[color escapeSequence] UTF8String], c, COLOR_RESET);
}

int main(int argc, char **argv) {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    int exitCode = EXIT_SUCCESS;

	// Check if at least one command line argument was provided
    if (argc > 1) {
        NSString *input = [NSString stringWithUTF8String: argv[1]];

        NSUInteger sz = [input length];
        for (NSUInteger i = 0; i < sz; ++i) {
            putc_with_rgb([input characterAtIndex: i], [[rgb alloc] initWithFrequency: FREQ andI: i]);
        }
    } else {
        exitCode = EXIT_FAILURE;
    }

    [pool drain];
    return exitCode;
}
