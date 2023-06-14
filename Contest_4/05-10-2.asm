%include "io.inc"

section .data
    op dw `%d `, 0
    op2 dw `%c`, 0
    
section .bss
    root resb 5000000
    findmin_help resb 4
    temp resb 4
    temp2 resb 4
    oper resb  4
    key resb 4
    data resb 4
    count resb 4
    help resb 4
    
section .text
extern malloc
extern free
extern printf
extern scanf
global CMAIN
add_node:
    push ebp
    mov ebp, esp
    mov eax, dword[esp + 8]
    mov ecx, dword[eax]
    mov eax, dword[ecx]
    mov edx, dword[esp + 12]
    cmp eax, edx
    je jj
    cmp eax, -1
    jne not_null
    jj:
    mov eax, ecx
    mov ecx, dword[esp + 12]
    mov dword[eax], ecx
    mov ecx, dword[esp + 16]
    mov dword[eax + 4], ecx
    mov dword[eax + 16], 1
    
    jmp fin
    not_null:
        cmp eax, dword[esp + 12]
        jg left
        ;right
        lea eax, [ecx + 8]
        mov ebx, dword[eax]
        cmp dword[eax], 0
        jne not_null_rigth
        mov ebx, eax
        
;        sub esp, 8
;        push 20
;        call malloc
;        add esp, 12
;        mov dword[ebx], eax 
        mov ecx, dword[count]
        lea eax, [root + ecx]
        mov dword[ebx], eax
        add ecx, 20
        mov dword[count], ecx

        
        
        mov ebx, dword[esp + 8]
        mov dword[eax + 16], 1
        mov esi, dword[temp]
        mov dword[temp2], esi
        mov dword[temp], eax
        lea ecx, [eax]
        mov dword[ecx], -1
        not_null_rigth:
            mov eax, dword[esp + 8]
            mov ecx, dword[eax]
            lea eax, [ecx + 8]
            mov ebx, dword[esp + 16]
            mov ebx, dword[esp + 12]
            push dword[esp + 16]
            push ebx
            push eax
            call add_node
            jmp fin
        left:
            lea eax, [ecx + 12]
            mov ebx, dword[eax]
            cmp dword[eax], 0
            jne not_null_left
            mov ebx, eax
            
            
;            sub esp, 8
;            push 20
;            call malloc
;            add esp, 12
;            mov dword[ebx], eax 
            mov ecx, dword[count]
            lea eax, [root + ecx]
            mov dword[ebx], eax
            add ecx, 20
            mov dword[count], ecx
            
            
            mov ebx, dword[esp + 8]
            mov dword[eax + 16], 1
            mov esi, dword[temp]
            mov dword[temp2], esi
            mov dword[temp], eax
            lea ecx, [eax]
            mov dword[ecx], -1
            not_null_left:
                mov eax, dword[esp + 8]
                mov ecx, dword[eax]
                lea eax, [ecx + 12]
                mov ebx, dword[esp + 16]
                mov ebx, dword[esp + 12]
                push dword[esp + 16]
                push ebx
                push eax
                call add_node
                add esp, 12
    fin:
    mov esp, ebp
    pop ebp
    ret

    
find_node:
    push ebp
    mov ebp, esp
    
    
    mov eax, dword[esp + 8]
    mov ebx, dword[eax]
    cmp ebx, 0
    je fin_find_not
    mov ecx, dword[ebx]
    
    mov eax, dword[esp + 8]
    mov eax, dword[eax]
    cmp dword[eax + 16], 0
    je deleted
    
    cmp ecx, dword[esp + 12]
    je save
    
    deleted:
    
    cmp ecx, dword[esp + 12]
    jg left_find
    ;right
    mov eax, dword[esp + 8]
    mov ecx, dword[eax]
    lea eax, [ecx + 8]
    push dword[esp + 12]
    push eax
    call find_node
    add esp, 8
    jmp fin_find
    left_find:
        mov eax, dword[esp + 8]
        mov ecx, dword[eax]
        lea eax, [ecx + 12]
        mov ecx, dword[esp + 12]
        push ecx
        push eax
        call find_node
        add esp, 8
        jmp fin_find
        
    save:
        mov ecx, dword[esp + 8]
        mov eax, dword[ecx]
        mov dword[findmin_help], eax
        mov eax, dword[esp + 8]
        mov ecx, dword[eax]
        lea edx, [ecx + 4]
        mov eax, dword[edx]
        
        mov ecx, dword[esp + 8]
        mov ecx, dword[ecx]
        lea ecx, [ecx + 16]
        mov ecx, dword[ecx]
        
        
        imul eax, ecx
        
        jmp fin_find
        
    fin_find_not:
        mov eax, -1
        
    fin_find:
    mov esp, ebp
    pop ebp
    ret
    

    

    
delete:
    push ebp
    mov ebp, esp
    mov eax, dword[esp + 8]
    mov ecx, dword[esp + 12]
    
    
    push ecx
    push eax
    call find_node
    add esp, 8
    cmp eax, -1
    je fin_full
    mov eax, dword[findmin_help]
    lea eax, [eax + 16]
    mov dword[eax], 0
    


    fin_full: 
    
    mov esp, ebp
    pop ebp
    ret
    
CMAIN:
    mov ebp, esp; for correct debugging
    mov dword[help], root
    mov dword[help], -1
    
    mov ecx, dword[count]
    lea eax, [root + ecx]
    add ecx, 20
    mov dword[count], ecx
    
    mov dword[help], root
    
    
    lea eax, [root]
    mov dword[eax], -1
    mov dword[eax + 16], 1
    xor eax, eax
    new:
    sub esp, 4
    push oper
    push op2
    call scanf
    add esp, 12
    mov eax, 70
    mov ebx, dword[oper]
    cmp dword[oper], eax
    je stop
    
    mov eax, 65
    cmp dword[oper], eax
    je to_add
    
    mov eax, 83
    cmp dword[oper], eax
    je to_search
    
    mov eax, 68
    cmp dword[oper], eax
    je to_delete
    
    jmp new
    
    to_add:
        sub esp, 4
        push key
        push op
        call scanf
        add esp, 12
        sub esp, 4
        push data
        push op
        call scanf
        add esp, 12
        
        
        push dword[data]
        push dword[key]
        push help
        call add_node
        add esp, 12
        
        jmp new
        
    to_search:
        sub esp, 4
        push key
        push op
        call scanf
        add esp, 12
        
        
        push dword[key]
        push help
        call find_node
        add esp, 8
        
        cmp eax, -1
        je new
        
        cmp eax, 0
        je new
        
        mov ebx, eax
        
        sub esp, 4
        push dword[key]
        push op
        call printf
        add esp, 12
        
        sub esp, 4
        push ebx
        push op
        call printf
        add esp, 12
        
        jmp new
        
    to_delete:
        sub esp, 4
        push key
        push op
        call scanf
        add esp, 12

        

        
        push dword[key]
        push help
        call delete
        add esp, 8
         
        jmp new
    stop:
    
    
    xor eax, eax
    ret