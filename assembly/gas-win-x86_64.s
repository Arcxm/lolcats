.section .rodata
    fmt: .asciz "\x1B[38;2;%d;%d;%dm%c\x1B[0m"

    frequency: .double 0.1

    two_pi_thirds: .double 2.0943951023931953
    four_pi_thirds: .double 4.1887902047863905

    const_127: .double 127.0
    const_128: .double 128.0

.section .bss
    .lcomm arg, 8
    .lcomm sz, 8

    .lcomm r, 4
    .lcomm g, 4
    .lcomm b, 4

.section .text

.global main

.extern strlen
.extern section
.extern printf

rainbow:
    cvtsi2sd %ecx, %xmm6 # xmm6 := i
    movsd frequency(%rip), %xmm0 # xmm0 := frequency
    mulsd %xmm0, %xmm6 # xmm6 := i * frequency

    movsd const_127(%rip), %xmm7 # xmm7 := 127
    movsd const_128(%rip), %xmm8 # xmm8 := 128

    # r = sin(frequency * i) * 127 + 128
    movsd %xmm6, %xmm0 # xmm0 := i * frequency
    call sin # xmm0 := sin(i * frequency)
    mulsd %xmm7, %xmm0 # xmm0 := sin(i * frequency) * 127
    addsd %xmm8, %xmm0 # xmm0 := sin(i * frequency) * 127 + 128
    cvtsd2si %xmm0, %eax
    movl %eax, r(%rip)

    # g = sin(frequency * i + 2 * M_PI / 3) * 127 + 128
    movsd %xmm6, %xmm0 # xmm0 := i * frequency
    movsd two_pi_thirds(%rip), %xmm1 # xmm1 := 2 * (pi / 3)
    addsd %xmm1, %xmm0 # xmm0 := i * frequency + 2 * (pi / 3)
    call sin # xmm0 := sin(i * frequency + 2 * (pi / 3))
    mulsd %xmm7, %xmm0 # xmm0 := sin(i * frequency + 2 * (pi / 3)) * 127
    addsd %xmm8, %xmm0 # xmm0 := sin(i * frequency + 2 * (pi / 3)) * 127 + 128
    cvtsd2si %xmm0, %eax
    movl %eax, g(%rip)

    # b = sin(frequency * i + 4 * M_PI / 3) * 127 + 128
    movsd %xmm6, %xmm0 # xmm0 := i * frequency
    movsd four_pi_thirds(%rip), %xmm1 # xmm1 := 4 * (pi / 3)
    addsd %xmm1, %xmm0 # xmm0 := i * frequency + 4 * (pi / 3)
    call sin # xmm0 := sin(i * frequency + 4 * (pi / 3))
    mulsd %xmm7, %xmm0 # sin(i * frequency + 4 * (pi / 3)) * 127
    addsd %xmm8, %xmm0 # sin(i * frequency + 4 * (pi / 3)) * 127 + 128
    cvtsd2si %xmm0, %eax
    movl %eax, b(%rip)

    ret

main:
    push %rbp
    mov %rsp, %rbp
    subq $48, %rsp

    cmpq $2, %rcx
    jl exit

    movq %rdx, %r8
    movq 8(%r8), %rdx
    movq %rdx, arg(%rip)

    movq arg(%rip), %rcx
    call strlen
    movq %rax, sz(%rip)

    xor %rbx, %rbx
range:
    movl %ebx, %ecx
    call rainbow

    leaq fmt(%rip), %rcx
    movl r(%rip), %edx
    movl g(%rip), %r8d
    movl b(%rip), %r9d

    movq arg(%rip), %rax
    movq (%rax, %rbx, 1), %rax
    movq %rax, 32(%rsp)
    call printf

    inc %rbx
    mov sz(%rip), %r8
    cmp %r8, %rbx
    jl range

exit:
    mov %rbp, %rsp
    pop %rbp

    xor %rax, %rax
    ret
