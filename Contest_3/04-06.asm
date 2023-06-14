%include "io.inc"
section .rodata
    op dw `%d`, 0

section .bss
    N resb 4
    arr resd 1000
    k resb 4
    temp resb 4


section .text
extern scanf
extern printf

zero_counter:
    push ebp
    mov ebp, esp
    push ecx
    push ebx
    

    xor ecx, ecx
    xor ebx, ebx
    mov eax, dword[ebp + 8]
    find:
        cmp eax, 1
        je count_cr
        sar eax, 1
        inc ecx
        cmp eax, 0
        je fin_zero
        jmp find
       
    count_cr: 
        mov ebx, 32
        sub ebx, ecx
        mov ecx, ebx
        mov ebx, 0
    count:
        mov eax, dword[ebp + 8]
        ;inc ecx
        sal eax, cl
        inc ecx
        sar eax, 31
        cmp ecx, 33
        je fin
        cmp eax, 0
        je save
        jmp count
        
    save:
        inc ebx
        jmp count
    
    fin_zero:
        inc ebx
    fin:
    mov eax, ebx
    
    pop ebx
    pop ecx
    
    mov esp, ebp
    pop ebp
    ret

global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    sub esp, 4
    push N
    push op
    call scanf
    add esp, 12

    xor ebx, ebx
    cmp dword[N], 0
    je finish
    .sc:
        sub esp, 4
        push temp
        push op
        call scanf
        add esp, 12
        mov eax, dword[temp]
        mov dword[arr + 4 * ebx], eax
        inc ebx
        cmp ebx, dword[N]
        jne .sc

    sub esp, 4
    push k
    push op
    call scanf
    add esp, 12



    xor ebx, ebx
    xor ecx, ecx
    counter_plus: 
        cmp ecx, dword[N]
        je finish
        push dword[arr + 4 * ecx]
        
        call zero_counter
        
        pop dword[arr + 4 * ecx]
        inc ecx
        cmp eax, dword[k]
        je counter_zeroes
        
     
        jmp counter_plus
        
    counter_zeroes:
        inc ebx
        jmp counter_plus
    
    finish:
        sub esp, 4
        push ebx
        push op
        call printf
        add esp, 12

    
    xor eax, eax
    ret