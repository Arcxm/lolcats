# objective-c lolcat

This is the Objective-C implementation of lolcat. 

## Quick Start

### Windows

Using [GNUstep](https://github.com/gnustep/) with MinGW.

```console
$ gcc -I <path/to/gnustep/headers> -L <path/to/gnustep/libraries> -o lolcat main.m -lgnustep-base -lobjc -std=c99 -fobjc-exceptions -fconstant-string-class=NSConstantString
$ ./lolcat "Hello, World!"
```

### MacOS

```console
$ clang -framework Foundation -o lolcat main.m
$ ./lolcat "Hello, World!"
```