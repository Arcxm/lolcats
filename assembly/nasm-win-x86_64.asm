bits 64
default rel

section .rodata
    fmt db `\e[38;2;%d;%d;%dm%c\e[0m`, 0

    frequency dq 0.1

    two_pi_thirds dq 2.0943951023931953
    four_pi_thirds dq 4.1887902047863905

    const_127 dq 127.0
    const_128 dq 128.0

section .bss
    arg resq 1
    sz resq 1

    r resd 1
    g resd 1
    b resd 1

section .text

global main

extern strlen
extern sin
extern printf

rainbow:
    cvtsi2sd xmm6, ecx ; xmm6 := i
    movsd xmm0, [frequency] ; xmm0 := frequency
    mulsd xmm6, xmm0 ; xmm6 := i * frequency

    movsd xmm7, [const_127] ; xmm7 := 127
    movsd xmm8, [const_128] ; xmm8 := 128

    ; r = sin(frequency * i) * 127 + 128
    movsd xmm0, xmm6 ; xmm0 := i * frequency
    call sin ; xmm0 := sin(i * frequency)
    mulsd xmm0, xmm7 ; xmm0 := sin(i * frequency) * 127
    addsd xmm0, xmm8 ; xmm0 := sin(i * frequency) * 127 + 128
    cvtsd2si eax, xmm0
    mov dword [r], eax

    ; g = sin(frequency * i + 2 * M_PI / 3) * 127 + 128
    movsd xmm0, xmm6 ; xmm0 := i * frequency
    movsd xmm1, [two_pi_thirds] ; xmm1 := 2 * (pi / 3)
    addsd xmm0, xmm1 ; xmm0 := i * frequency + 2 * (pi / 3)
    call sin ; xmm0 := sin(i * frequency + 2 * (pi / 3))
    mulsd xmm0, xmm7 ; xmm0 := sin(i * frequency + 2 * (pi / 3)) * 127
    addsd xmm0, xmm8 ; xmm0 := sin(i * frequency + 2 * (pi / 3)) * 127 + 128
    cvtsd2si eax, xmm0
    mov dword [g], eax

    ; b = sin(frequency * i + 4 * M_PI / 3) * 127 + 128
    movsd xmm0, xmm6 ; xmm0 := i * frequency
    movsd xmm1, [four_pi_thirds] ; xmm1 := 4 * (pi / 3)
    addsd xmm0, xmm1 ; xmm0 := i * frequency + 4 * (pi / 3)
    call sin ; xmm0 := sin(i * frequency + 4 * (pi / 3))
    mulsd xmm0, xmm7 ; sin(i * frequency + 4 * (pi / 3)) * 127
    addsd xmm0, xmm8 ; sin(i * frequency + 4 * (pi / 3)) * 127 + 128
    cvtsd2si eax, xmm0
    mov dword [b], eax

    ret

main:
    push rbp
    mov rbp, rsp
    sub rsp, 48

    cmp rcx, 2
    jl exit

    mov r8, rdx
    mov rdx, [r8 + 8]
    mov [arg], rdx

    mov rcx, [arg]
    call strlen
    mov [sz], rax

    xor rbx, rbx
range:
    mov ecx, ebx
    call rainbow

    lea rcx, [fmt]
    mov edx, [r]
    mov r8d, [g]
    mov r9d, [b]

    mov rax, [arg]
    mov rax, [rax + rbx]
    mov [rsp + 32], rax
    call printf

    inc rbx
    mov r8, [sz]
    cmp rbx, r8
    jl range

exit:
    mov rsp, rbp
    pop rbp

    xor rax, rax
    ret