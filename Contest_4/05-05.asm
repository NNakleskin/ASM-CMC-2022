%include "io.inc"

section .data
    op dw `%d`, 0
    rmode db `rb`, 0
    rmodew db `wb`, 0
    outp dd `output.bin`, 0
    inp dd `input.bin`, 0

section .bss
    arr resb 5000000
    len resb 4
    input resb 4
    temp resb 4
    output resb 4

section .text

is_it:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    
    mov eax, dword[esp + 24]
    mov ebx, dword[eax + 16]
    mov ebx, dword[esp + 20]
    sub eax, 4
    mov ecx, 1
    min:
        mov esi, ecx
        mov ebx, dword[eax + 4 * ecx]
        imul esi, 2
        cmp esi, dword[esp + 20]
        jg yes_min
        mov edi, dword[eax + 4 * esi]
        cmp ebx, edi
        jg max_help
        inc ecx
        inc esi
        cmp esi, dword[esp + 20]
        jg yes_min
        cmp ebx, edi
        jg max_help
        mov edi, dword[eax + 4 * esi]
        cmp ebx, edi
        jg max_help
        jmp min
        
    max_help:
        xor ecx, ecx
        xor esi, esi
        mov ecx, 1

    max:
        mov esi, ecx
        mov ebx, dword[eax + 4 * ecx]
        imul esi, 2
        cmp esi, dword[esp + 20]
        jg yes_max
        mov edi, dword[eax + 4 * esi]
        cmp ebx, edi
        jl not_
        inc ecx
        inc esi
        cmp esi, dword[esp + 20]
        jg yes_max
        mov edi, dword[eax + 4 * esi]
        cmp ebx, edi
        jl not_
        jmp max
            
    yes_max:
        mov eax, -1
        jmp fin
        
    yes_min:
        mov eax, 1
        jmp fin
        
    not_:
        mov eax, 0
        
    fin:
    push edi
    push esi
    pop ebx
    mov esp, ebp
    pop ebp
    ret

extern scanf
extern fopen 
extern fclose
extern fscanf
extern fread
extern fwrite
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    xor eax, eax
    xor ecx, ecx
    
    sub esp, 4
    push rmode
    push inp
    call fopen 
    add esp, 12
    mov dword[input], eax
    
    
    xor ebx, ebx
    scan:
        mov ecx, dword[arr]
        lea ecx, [arr + 4 * ebx]
        push dword[input]
        push 1
        push 4
        push ecx
        call fread
        add esp, 16
        inc ebx
        cmp eax, 0
        jne scan
    dec ebx
    mov dword[len], ebx
    
    lea ecx, [arr]
    push ecx
    push dword[len]
    call is_it
    add esp, 8
    
    mov dword[temp], eax
    
    sub esp, 4
    push rmodew
    push outp
    call fopen 
    add esp, 12
    mov dword[output], eax

    
    push dword[output]
    push 1
    push 4
    push temp
    call fwrite
    add esp, 16
    
    sub esp, 8
    push dword[input]
    call fclose
    add esp, 12
    
    sub esp, 8
    push dword[output]
    call fclose
    add esp, 12
     
    xor eax, eax
    ret