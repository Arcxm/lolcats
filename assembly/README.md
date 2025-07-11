# assembly lolcats

These are Assembly implementations of lolcat.

## Quick Start

### Windows

#### NASM

Using [NASM](https://www.nasm.us) and gcc.

```console
$ nasm -fwin64 nasm-win-x86_64.asm
$ gcc -o lolcat nasm-win-x86_64.obj
$ ./lolcat "Hello, World!"
```

#### GAS

Using as and gcc.

```console
$ as -o gas-win-x86_64.obj gas-win-x86_64.s
$ gcc -o lolcat gas-win-x86_64.obj
$ ./lolcat "Hello, World!"
```