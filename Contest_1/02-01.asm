section .bss
    vx resb 4
    vy resb 4
    aax resb 4
    aay resb 4
    t resb 4
    help resb 4

section .rodata
    op dw `%d`, 0
    opo dw `%d `, 0
    n dw `\n`, 0

section .text
global main
extern printf
extern scanf
main:
    sub esp, 4
    push vx
    push op
    call scanf
    add esp, 12


    sub esp, 4
    push vy
    push op
    call scanf
    add esp, 12


    sub esp, 4
    push aax
    push op
    call scanf
    add esp, 12


    sub esp, 4
    push aay
    push op
    call scanf
    add esp, 12


    sub esp, 4
    push t
    push op
    call scanf
    add esp, 12


    mov eax, dword[vx]
    mov ebx, dword[t]
    imul eax, ebx
    mov dword[help], eax

    mov eax, dword[aax]
    mov ebx, dword[t]
    imul ebx, ebx
    imul eax, ebx
    add eax, dword[help]

    sub esp, 4
    push eax
    push opo
    call printf
    add esp, 12


    mov eax, dword[vy]
    mov ebx, dword[t]
    imul eax, ebx
    mov dword[help], eax

    mov eax, dword[aay]
    mov ebx, dword[t]
    imul ebx, ebx
    imul eax, ebx
    add eax, dword[help]

    sub esp, 4
    push eax
    push opo
    call printf
    add esp, 12

    sub esp, 8
    push n
    call printf
    add esp, 12



    xor eax, eax
    ret