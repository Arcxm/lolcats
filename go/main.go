package main

import (
	"fmt"
	"math"
	"os"
)

const exit_failure int = 1

const color_reset string = "\x1B[0m"

const freq float64 = 0.1

type rgb struct {
	r, g, b uint8
}

func rainbow(frequency, i float64) *rgb {
	return &rgb{
		r: uint8(math.Sin(frequency*i)*127 + 128),
		g: uint8(math.Sin(frequency*i+2*math.Pi/3)*127 + 128),
		b: uint8(math.Sin(frequency*i+4*math.Pi/3)*127 + 128)}
}

func putc_with_rgb(c byte, color rgb) {
	fmt.Printf("\x1B[38;2;%d;%d;%dm%c%s", color.r, color.g, color.b, c, color_reset)
}

func main() {
	if argc := len(os.Args); argc > 1 {
		input := os.Args[1]

		for i := 0; i < len(input); i++ {
			putc_with_rgb(input[i], *rainbow(freq, float64(i)))
		}
	} else {
		os.Exit(exit_failure)
	}
}
