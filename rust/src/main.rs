use std::env::args;
use std::f64::consts::PI;
use std::process::exit;

const EXIT_FAILURE: i32 = 1;

const COLOR_RESET: &str = "\x1B[0m";

const FREQ: f64 = 0.1;

struct RGB {
    r: u8,
    g: u8,
    b: u8,
}

impl RGB {
    fn rainbow(frequency: f64, i: i32) -> Self {
        Self {
            r: ((frequency * i as f64).sin() * 127f64 + 128f64) as u8,
            g: ((frequency * i as f64 + 2f64 * PI / 3f64).sin() * 127f64 + 128f64) as u8,
            b: ((frequency * i as f64 + 4f64 * PI / 3f64).sin() * 127f64 + 128f64) as u8,
        }
    }

    fn escape_sequence(self) -> String {
        format!("\x1B[38;2;{};{};{}m", self.r, self.g, self.b)
    }
}

fn putc_with_rgb(c: char, color: RGB) {
    print!("{}{}{}", color.escape_sequence(), c, COLOR_RESET);
}

fn main() {
    let args: Vec<String> = args().skip(1).collect();

    // Check if at least one command line argument was provided
    if args.len() > 0 {
        let input = &args[0];

        for (index, c) in input.chars().enumerate() {
            putc_with_rgb(c, RGB::rainbow(FREQ, index as i32));
        }
    } else {
        exit(EXIT_FAILURE);
    }
}