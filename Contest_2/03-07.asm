section .bss
    n resb 4
    array resb 4
section .rodata
    op dw `%d `, 0

section .text
extern printf
extern scanf
extern malloc
extern free
global main
main:
    mov ebp, esp; for correct debugging
    sub esp, 4
    push n
    push op
    call scanf
    add esp, 12
    
    mov eax, dword[n]
    cmp eax, 0
    je .fin
    imul eax, 4
    
    sub esp, 8
    push eax
    call malloc
    add esp, 12
    
    mov dword[array], eax
    
    xor ebx, ebx
    .scan:
        mov eax, dword[array]
        lea eax, [eax + 4 * ebx]
        
        sub esp, 4
        push eax
        push op
        call scanf
        add esp, 12
        
        inc ebx
        cmp ebx, dword[n]
        jne .scan
    
    mov eax, dword[n]
    xor ebx, ebx
    cmp eax, 1
    je .print
    
    mov ebx, 1
    xor edi, edi
    .sort:
        mov ecx, dword[array]
        lea eax, [ecx + 4 * ebx]
        mov eax, dword[eax]
        
        dec ebx
        lea edx, [ecx + 4 * ebx]
        mov edx, dword[edx]
        inc ebx
        cmp eax, edx
        jg .not
        mov ecx, dword[array]
        lea ecx, [ecx + 4 * ebx]
        mov dword[ecx], edx
        dec ebx
        mov ecx, dword[array]
        lea ecx, [ecx + 4 * ebx]
        mov dword[ecx], eax
        inc ebx
        .not:
            inc ebx
            cmp ebx, dword[n]
            jne .sort
        mov ebx, 1
        inc edi
        cmp edi, dword[n]
        jne .sort
    
    xor ebx, ebx
    .print:
        mov eax, dword[array]
        lea eax, [eax, + 4 * ebx]
        sub esp, 4
        push dword[eax]
        push op
        call printf
        add esp, 12
        inc ebx
        cmp ebx, dword[n]
        jne .print
    
    sub esp, 8
    push dword[array]
    call free
    add esp, 12
    .fin:
    xor eax, eax
    ret