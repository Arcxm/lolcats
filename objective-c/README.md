# objective-c lolcat

This is the Objective-C implementation of lolcat. 

## Quick Start

### Windows

#### After Update

Using [GNUstep Windows MSVC Toolchain](https://github.com/gnustep/tools-windows-msvc).

```console
$ clang-cl -I <path/to/gnustep>\include -fobjc-runtime=gnustep-2.0 -Xclang -fexceptions -Xclang -fobjc-exceptions -fblocks -DGNUSTEP -DGNUSTEP_WITH_DLL -DGNUSTEP_RUNTIME=1 -D_NONFRAGILE_ABI=1 -D_NATIVE_OBJC_EXCEPTIONS /MDd /Z7 /c main.m
$ clang-cl main.obj gnustep-base.lib objc.lib dispatch.lib -fuse-ld=lld /MDd /Z7 -o lolcat.exe /link /LIBPATH:<path/to/gnustep>\lib
```

#### Before Update

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