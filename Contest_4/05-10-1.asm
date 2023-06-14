%include "io.inc"

section .data
    op dw `%d `, 0
    op2 dw `%c`, 0
    f dw `F`, 0
    a dw `A`, 0
    d dw `D`, 0
    s dw `S`, 0
    
section .bss
    root resb 4
    findmin_help resb 4
    temp resb 4
    temp2 resb 4
    oper resb 4
    key resb 4
    data resb 4

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
        sub esp, 8
        push 16
        call malloc
        add esp, 12
        mov dword[ebx], eax 
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
            sub esp, 8
            push 16
            call malloc
            add esp, 12
            mov dword[ebx], eax 
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
    cmp ecx, dword[esp + 12]
    je save
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
        jmp fin_find
        
    fin_find_not:
        mov eax, -1
        
    fin_find:
    mov esp, ebp
    pop ebp
    ret
    
find_node_parent:
    push ebp
    mov ebp, esp
    
    xor ebx, ebx
    mov eax, dword[esp + 8]
    mov ecx, dword[eax]
    mov edx, dword[ecx + 8]
    cmp edx, 0
    je null_1
    add ebx, 1
    mov eax, dword[edx]
    mov edx, 1
    cmp eax, dword[esp + 12]
    je save_parent
    null_1:
    mov edx, dword[ecx + 12]
    cmp edx, 0
    je null_2
    add ebx, 2
    mov eax, dword[edx]
    mov edx, 2
    cmp eax, dword[esp + 12]
    je save_parent
    null_2:
    cmp ebx, 0
    je fin_par
    cmp ebx, 1
    je right_node
    cmp ebx, 2
    je left_node
    
    mov eax, dword[esp + 8]
    mov ecx, dword[eax]
    mov eax, dword[ecx]
    cmp eax, dword[esp + 12]
    jg left_node
    ;right
    jmp right_node
    left_node:
        mov eax, dword[esp + 8]
        mov ecx, dword[eax]
        lea eax, [ecx + 12]
        
        push dword[esp + 12]
        push eax
        call find_node_parent
        add esp, 8
        
        jmp fin_par

    right_node:
        mov eax, dword[esp + 8]
        mov ecx, dword[eax]
        lea eax, [ecx + 8]
        
        push dword[esp + 12]
        push eax
        call find_node_parent
        add esp, 8
        
        jmp fin_par
        
    save_parent:
        mov ecx, dword[esp + 8]
        mov eax, dword[ecx]
    
    fin_par:

    mov esp, ebp
    pop ebp
    ret
    
find_min:
    push ebp
    mov ebp, esp
    
    
    mov eax, dword[esp + 8]
    mov ebx, dword[eax]
    mov eax, dword[ebx + 12]
    mov ecx, ebx
    cmp eax, 0
    je save_min
    mov ebx, eax
    while:
        cmp ebx, 0
        je save_min
        mov ecx, ebx
        mov ebx, dword[ecx + 12]
        jmp while
    
    
    save_min:
        
        mov eax, ecx
        
    fin_findmin:

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
    lea ecx, [eax + 12]
    mov eax, dword[ecx]
    cmp eax, 0
    jne not_null_left_del
    mov eax, dword[findmin_help]
    lea ecx, [eax + 8]
    mov eax, dword[ecx]
    cmp eax, 0
    jne left_null_right_not
    ;both null//////////////////////////////////////
    mov ecx, dword[esp + 12]
    
    lea eax, [esp + 8]
    push ecx
    push root
    call find_node_parent
    add esp, 8
    cmp edx, 0
    je del_root
    cmp edx, 1
    jne left_del
    
    lea ecx, [eax + 8]
    mov eax, dword[ecx]
    mov dword[ecx], 0
    

    sub esp, 8
    push eax
    call free
    add esp, 12
    
    jmp fin_del
    left_del:
        lea ecx, [eax + 12]
        mov eax, dword[ecx]
        mov dword[ecx], 0
        
    
        sub esp, 8
        push eax
        call free
        add esp, 12
        
        jmp fin_del
   ;///////////////////////     
    left_null_right_not:
        mov eax, dword[findmin_help]
        mov ecx, dword[eax + 8]
        
        mov edx, dword[ecx]
        mov dword[eax], edx
        
        mov edx, dword[ecx + 4]
        mov dword[eax + 4], edx
        
        mov edx, dword[ecx + 8]
        mov dword[eax + 8], edx
        
        mov edx, dword[ecx + 12]
        mov dword[eax + 12], edx
        
        sub esp, 8
        push ecx
        call free
        add esp, 12
        
        
        jmp fin_del
       

    not_null_left_del:
        mov eax, dword[findmin_help]
        lea ecx, [eax + 8]
        mov eax, dword[ecx]
        cmp eax, 0
        jne both_not
        ;right null, left not
        

        
        mov eax, dword[findmin_help]
        mov ecx, dword[eax + 12]
        
        mov edx, dword[ecx]
        mov dword[eax], edx
        
        mov edx, dword[ecx + 4]
        mov dword[eax + 4], edx
        
        mov edx, dword[ecx + 8]
        mov dword[eax + 8], edx
        
        mov edx, dword[ecx + 12]
        mov dword[eax + 12], edx
        
        sub esp, 8
        push ecx
        call free
        add esp, 12
        
        
        jmp fin_del

        
        both_not:
            mov esi, dword[findmin_help]
            lea eax, [esi + 8]
            push eax
            call find_min
            add esp, 4
            
           
            mov ecx, eax
            mov eax, dword[findmin_help]

            
            
            mov edx, dword[ecx]
            mov esi, dword[ecx + 4]
            
            
            mov dword[eax], edx
            
            mov edx, dword[ecx + 4]
            mov dword[eax + 4], edx   
            
                     
            
            mov ecx, dword[eax]
            lea edx, [eax + 8]
            push ecx
            push edx
            call delete
            add esp, 8
          
            
            
            jmp fin_del
            
            
    del_root:
        mov eax, dword[esp + 8]
        sub esp, 8
        push dword[findmin_help]
        call free
        add esp, 12
    
    fin_del:

    fin_full: 
    mov esp, ebp
    pop ebp
    ret
    
CMAIN:
    mov ebp, esp; for correct debugging
    mov dword[root], -1
    
    sub esp, 8
    push 16
    call malloc
    add esp, 12
    mov dword[root], eax
    
    mov esi, dword[root]
    lea eax, [esi]
    mov dword[eax], -1
    
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
        push root
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
        push root
        call find_node
        add esp, 8
        
        cmp eax, -1
        je new
        
        mov dword[data], eax
        
        sub esp, 4
        push dword[key]
        push op
        call printf
        add esp, 12
        
        sub esp, 4
        push dword[data]
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
        mov eax, dword[key]
        
        push dword[key]
        push root
        call delete
        add esp, 8
         
        jmp new
    stop:
    
    
    xor eax, eax
    ret