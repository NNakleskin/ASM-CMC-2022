section .bss
    x resb 4
    len resb 4
    res resb 4
section .rodata
    op dw `%lu`, 0
    ope dw `%o`, 0

section .text
extern printf
extern scanf
extern malloc
extern free
global main
main:
    mov ebp, esp; for correct debugging
    sub esp, 4
    push x
    push op
    call scanf
    add esp, 12
    
    sub esp, 4
    push dword[x]
    push ope
    call printf
    add esp, 12
    
    jmp .ret
    
    sub esp, 8
    push 400
    call malloc
    add esp, 12
    mov dword[res], eax
    xor esi, esi
    .to_8:
        mov eax, dword[x]
        cmp eax, 8
        jb .fin
        
        mov ebx, 8
        cdq
        div ebx
        mov ecx, dword[res]
        lea ecx, [ecx + 4 * esi]
        mov dword[ecx], edx
        mov dword[x], eax
        inc esi
        mov ecx, dword[res]
        lea ecx, [ecx + 4 * esi]
        mov dword[ecx], -1
        jmp .to_8
    .fin:
        mov ecx, dword[res]
        lea edx, [ecx + 4 * esi]
        mov dword[edx], eax
        inc esi
        lea edx, [ecx + 4 * esi]
        mov dword[edx], -1
    xor esi, esi
    .find:
        mov eax, dword[res]
        lea eax, [eax + 4 * esi]
        mov eax, dword[eax]
        inc esi
        cmp eax, -1
        jne .find
        dec esi
    .print:
        dec esi
        mov eax, dword[res]
        lea eax, [eax + 4 * esi]
        
        sub esp, 4
        push dword[eax]
        push op
        call printf
        add esp, 12
        
        cmp esi, 0
        jne .print
        
    sub esp, 8
    push dword[res]
    call free
    add esp, 12
    .ret:
    
    
    
    xor eax, eax
    ret