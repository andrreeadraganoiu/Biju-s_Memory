section .data
    extern len_cheie, len_haystack
    i dd 0

section .text
    global columnar_transposition

;; void columnar_transposition(int key[], char *haystack, char *ciphertext);
columnar_transposition:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha 

    mov edi, [ebp + 8]   ;key
    mov esi, [ebp + 12]  ;haystack
    mov ebx, [ebp + 16]  ;ciphertext
    ;; DO NOT MODIFY

    ;; TODO: Implment columnar_transposition
    ;; FREESTYLE STARTS HERE

    xor ebp, ebp
    xor ecx, ecx
    
iter_columns:
    xor eax, eax
    mov eax, [edi + 4 * ecx]   ; indicele coloanei aflat in cheie
    inc ecx
    cmp ecx, [len_cheie]
    jle write
    jg finish 

write:
    xor edx, edx
    mov ebp, [i]
    mov dl, byte [esi + eax] 
    mov [ebx + ebp], dl        ; se pune in ciphertext
    inc ebp
    mov [i], ebp
    add eax, [len_cheie]
    cmp eax, [len_haystack]
    jl write
    jge iter_columns


    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    
finish:
    xor eax, eax
    mov [i], eax
    popa
    leave
    ret
    ;; DO NOT MODIFY