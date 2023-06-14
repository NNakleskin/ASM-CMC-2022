%include "io.inc"
section .bss
    n resb 4
    arr resb 4
    stdout resb 4
    k resb 4
    ou resb 4
    func resb 4
    temp resb 4
    
section .data
    op dw `%d\n`, 0

section .text
extern scanf
extern printf
extern malloc
extern free
extern fprintf
extern get_stdout
apply:
    push ebp
    mov ebp, esp
    
    
    push ebx
    push esi
    push edi
    
     


    xor ebx, ebx
    while:
        mov eax, ebx
        imul eax, 4
        mov ecx, dword[esp + 20]
        mov ecx, dword[ecx]
        lea edi, [ecx + eax]
        mov edi, dword[edi]
        
        mov edx, dword[esp + 36]
        
        mov eax, dword[esp + 28]
        
        mov esi, dword[esp + 32]
        mov esi, dword[esi]
        add esi, 10
        
        push edi
        mov ecx, 11
        for:
            push dword[esp + 4 * ecx] ; op
            inc ecx
            cmp ecx, esi
            jne for
            
            
        push edx      
        call eax
        add esp, 12
        
        inc ebx
        
        mov ecx, dword[esp + 24]
        cmp ebx, dword[ecx]
        jne while
        
    pop edi
    pop esi
    pop ebx
        
    mov esp, ebp
    pop ebp
    ret
        
    
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    sub esp, 4
    push n
    push op
    call scanf
    add esp, 12
    cmp dword[n], 0
    je fin
    

    
    mov dword[k], 2
    
    mov eax, dword[n]
    imul eax, 4
    
    sub esp, 8
    push eax
    call malloc
    add esp, 12
    mov dword[arr], eax
    mov dword[temp], eax
    
    xor ebx, ebx
    scanf_arr:
        mov eax, dword[arr]
        lea eax, [eax + 4 * ebx]
        sub esp, 4
        push eax
        push op
        call scanf
        add esp, 12
        inc ebx
        cmp ebx, dword[n]
        jne scanf_arr
        
    sub esp, 12
    call get_stdout
    add esp, 12
    
    mov ebx, fprintf
 
        

    sub esp, 4
    push op
    push eax
    push k
    push ebx
    push n
    push arr
    call apply
    add esp, 28

    
    
    fin:
        sub esp, 8
        push dword[temp]
        call free
        add esp, 12
        



        
    xor eax, eax
    ret