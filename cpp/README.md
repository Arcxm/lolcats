# c++ lolcat

This is the C++ implementation of lolcat. 

## Quick Start

### Windows

I built this with the MSVC cl Compiler, because it supports C++20 (which g++ unfortunately did not on my machine).

```console
$ cl /std:c++20 /EHsc /Fe:lolcat main.cc
$ ./lolcat "Hello, World!"
```

### Other Platforms

On other platforms it should be enough to simply set the standard as long as the compiler supports it.

```console
$ g++ -std=c++20 -o lolcat main.cc 
$ ./lolcat "Hello, World!"
```