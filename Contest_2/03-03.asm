section .bss
    n resb 4
    array resb 4
    min resb 4
    max resb 4
    count_min resb 4
    count_max resb 4

section .rodata
    op dw `%d `, 0
    opn dw `%d\n`, 0
    opnn dw `\n%d\n`, 0
    exit_out dw `0\n0`, 0
    nnn dw `\n`, 0

section .text
extern malloc
extern printf
extern scanf
extern realloc
global main
main:
    mov ebp, esp; for correct debugging
    
    
    sub esp, 4
    push n
    push op
    call scanf
    add esp, 12
    
    mov eax, dword[n]
    cmp eax, 3
    jl .exit
    
    mov eax, dword[n]
    imul eax, 4
    
    sub esp, 8
    push eax
    call malloc
    add esp, 12
    mov dword[array], eax
    
    sub esp, 8
    push 8
    call malloc
    add esp, 12
    mov dword[min], eax
    
    sub esp, 8
    push 8
    call malloc
    add esp, 12
    mov dword[max], eax
    
    xor ebx, ebx
    .scanf:
        mov ecx, dword[array]
        lea ecx, [ecx + 4 * ebx]
        inc ebx
        
        sub esp, 4
        push ecx
        push op
        call scanf
        add esp, 12
        
        cmp ebx, dword[n]
        jne .scanf
    
    mov ebx, 1
    .min:
        mov eax, dword[array]
        lea eax, [eax + 4 * ebx]
        mov eax, dword[eax]
        
        mov ecx, ebx
        dec ecx
        
        mov edx, dword[array]
        lea edx, [edx + 4 * ecx]
        mov edx, dword[edx]
        
        cmp eax, edx
        jge .not
        
        add ecx, 2
        
        mov edx, dword[array]
        lea edx, [edx + 4 * ecx]
        mov edx, dword[edx]
       
        cmp eax, edx
        jge .not
        
        mov eax, dword[count_min]
        inc eax
        imul eax, 4
        
        sub esp, 4
        push eax
        push dword[min]
        call realloc
        add esp, 12
        mov dword[min], eax
       
        
        mov eax, dword[count_min]
        mov edx, dword[min]
        lea edx, [edx + 4 * eax]
        mov dword[edx], ebx
        
        mov eax, dword[count_min]
        inc eax
        mov dword[count_min], eax
        .not:
        inc ebx
        mov eax, dword[n]
        dec eax
        cmp ebx, eax
        jne .min
     
     sub esp, 4
     push dword[count_min]
     push op
     call printf
     add esp, 12
     
     xor ebx, ebx
     mov eax, dword[count_min]
     cmp eax, 0
     je .printf_min
     
     sub esp, 8
     push nnn
     call printf
     add esp, 12
     
     .printf_min:
        cmp ebx, dword[count_min]
        je .fin_min
        
        mov eax, dword[min]
        lea eax, [eax + 4 * ebx]
        
        sub esp, 4
        push dword[eax]
        push op
        call printf
        add esp, 12
        
        inc ebx
        jmp .printf_min
        
  ;////////////////////////////////////////////////////////////////  
    .fin_min:
    sub esp, 8
    push nnn
    call printf
    add esp, 12
    
    mov ebx, 1    
    .max:
        mov eax, dword[array]
        lea eax, [eax + 4 * ebx]
        mov eax, dword[eax]
        
        mov ecx, ebx
        dec ecx
        
        mov edx, dword[array]
        lea edx, [edx + 4 * ecx]
        mov edx, dword[edx]
        
        cmp eax, edx
        jle .not2
        
        add ecx, 2
        
        mov edx, dword[array]
        lea edx, [edx + 4 * ecx]
        mov edx, dword[edx]
       
        cmp eax, edx
        jle .not2
        
        mov eax, dword[count_max]
        inc eax
        imul eax, 4
        
        sub esp, 4
        push eax
        push dword[max]
        call realloc
        add esp, 12
        mov dword[max], eax
       
        
        mov eax, dword[count_max]
        mov edx, dword[max]
        lea edx, [edx + 4 * eax]
        mov dword[edx], ebx
        
        mov eax, dword[count_max]
        inc eax
        mov dword[count_max], eax
        .not2:
        inc ebx
        mov eax, dword[n]
        dec eax
        cmp ebx, eax
        jne .max
     
     sub esp, 4
     push dword[count_max]
     push opn
     call printf
     add esp, 12
     
     xor ebx, ebx
     .printf_max:
        cmp ebx, dword[count_max]
        je .fin
        
        mov eax, dword[max]
        lea eax, [eax + 4 * ebx]
        
        sub esp, 4
        push dword[eax]
        push op
        call printf
        add esp, 12
        
        inc ebx
        jmp .printf_max

    .exit:
        sub esp, 8
        push exit_out
        call printf
        add esp, 12
    .fin:
    xor eax, eax
    ret