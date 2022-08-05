const std = @import("std");
const fs = std.fs;
const heap = std.heap;
const io = std.io;
const math = std.math;
const process = std.process;

const EXIT_FAILURE: i32 = 1;

const COLOR_RESET = "\x1B[0m";

const FREQ: f64 = 0.1;

const RGB = struct {
    r: u8,
    g: u8,
    b: u8,

    /// TODO: There HAS to be a better way than this built-in casts abomination!!
    pub fn rainbow(frequency: f64, i: usize) RGB {
        const PI_THIRDS: f64 = math.pi / @intToFloat(f64, 3);

        return RGB {
            .r = @floatToInt(u8, math.sin(frequency * @intToFloat(f64, i)) * 127 + 128),
            .g = @floatToInt(u8, math.sin(frequency * @intToFloat(f64, i) + 2 * PI_THIRDS) * 127 + 128),
            .b = @floatToInt(u8, math.sin(frequency * @intToFloat(f64, i) + 4 * PI_THIRDS) * 127 + 128)
        };
    }
};

fn putc_with_rgb(writer: fs.File.Writer, c: u8, color: RGB) !void {
    try writer.print("\x1B[38;2;{d};{d};{d}m{c}{s}", .{
        color.r, color.g, color.b,
        c, COLOR_RESET
    });
}

pub fn main() !void {
    var arena = heap.ArenaAllocator.init(heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    var args = try process.argsWithAllocator(allocator);
    defer args.deinit();

    // Skip the first argument (the name of the executable itself)
    var skippedProg = args.skip();
    if (skippedProg) {
        // Check if at least one other command line argument was provided
        var maybe_arg = args.next();

        if (maybe_arg) |input| {
            var stdoutWriter = io.getStdOut().writer();

            for (input) |c, index| {
                try putc_with_rgb(stdoutWriter, c, RGB.rainbow(FREQ, index));
            }
        } else {
            // TODO: Do the defers get called when exiting the process this way?!
            process.exit(EXIT_FAILURE);
        }
    } else {
        // TODO: see above
        process.exit(EXIT_FAILURE);
    }
}