import math
import os
import strformat

const
  colorReset = "\x1B[0m"
  freq = 0.1

type RGB = object
  r: uint8
  g: uint8
  b: uint8

proc rainbow(frequency: float, i: int): RGB =
  let r = (sin(frequency * i.float) * 127 + 128).uint8
  let g = (sin(frequency * i.float + 2 * PI / 3) * 127 + 128).uint8
  let b = (sin(frequency * i.float + 4 * PI / 3) * 127 + 128).uint8
  RGB(r: r, g: g, b: b)

proc putcWithRGB(c: char, color: RGB) =
  stdout.write(&"\x1B[38;2;{color.r};{color.g};{color.b}m{c}{colorReset}")

when isMainModule:
  if paramCount() > 0:
    let input = paramStr(1)

    var index = 0
    for c in input.items:
      putcWithRGB(c, rainbow(freq, index))

      index += 1
  else:
    quit(QuitFailure)