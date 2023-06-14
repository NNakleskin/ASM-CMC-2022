%include "io.inc"

section .data
    op db `%d`, 0
    op2 db `%s`, 0
    
section .bss
    arr resb 50001
    n resb 4
    temp resb 11
    temp2 resb 4

section .text
extern scanf
extern printf
extern strcmp
extern strcpy
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    sub esp, 4
    push n
    push op
    call scanf
    add esp, 12
    xor edi, edi
    cmp dword[n], 0
    je fin
    
    
    sub esp, 4
    push arr
    push op2
    call scanf
    add esp, 12
    xor esi, esi
    
    
    mov edi, 1
    scanf_arr:
        sub esp, 4
        push temp
        push op2
        call scanf
        add esp, 12
        cmp eax, -1
        je fin
        xor esi, esi
        count:
            mov eax, esi
            imul eax, 11
            lea ecx, [arr + eax]
            sub esp, 4
            push temp
            push ecx
            call strcmp
            add esp, 12
            cmp eax, 0
            je not
            inc esi
            cmp esi, edi
            jne count
        nn:
        mov eax, edi
        imul eax, 11
        lea ecx, [arr + eax]
        
        sub esp, 4
        push temp
        push ecx
        call strcpy
        add esp, 12
        
        mov eax, dword[ecx]
        
        inc edi
        not:
        jmp scanf_arr

    fin:
    sub esp, 4
    push edi
    push op
    call printf
    add esp, 12
    xor eax, eax
    ret