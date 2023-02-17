; This is your structure
struc  my_date
    .day: resw 1
    .month: resw 1
    .year: resd 1
endstruc

section .text
    global ages

; void ages(int len, struct my_date* present, struct my_date* dates, int* all_ages);
ages:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; present
    mov     edi, [ebp + 16] ; dates
    mov     ecx, [ebp + 20] ; all_ages
    ;; DO NOT MODIFY

    ;; TODO: Implement ages
    ;; FREESTYLE STARTS HERE


month_date:
    xor eax, eax
    xor ebx, ebx
    dec edx
    mov ax, word [esi + my_date.month]  ; present
    mov bx, word [edi + my_date_size * edx + my_date.month] ; dates
    cmp ax, bx 
    jl actual_month_lower
    je day_date
    jg actual_month_greater

actual_month_greater:
    xor eax, eax
    xor ebx, ebx
    mov eax, [esi + my_date.year]
    mov ebx, [edi + my_date_size * edx + my_date.year]
    sub eax, ebx
    cmp eax, 0
    jl put_zero
    mov [ecx + 4 * edx], eax
    cmp edx, 0
    jnz month_date
    jz finish

actual_month_lower:
    xor eax, eax
    xor ebx, ebx
    mov eax, [esi + my_date.year]
    mov ebx, [edi + my_date_size * edx + my_date.year]
    sub eax, ebx
    cmp eax, 0
    jl put_zero
    dec eax
    mov [ecx + 4 * edx], eax
    cmp edx, 0
    jnz month_date
    jz finish
    
day_date:
    xor eax, eax
    xor ebx, ebx
    mov ax, word [esi + my_date.day]  ;present
    mov bx, word [edi + my_date_size * edx + my_date.day] ;dates
    cmp ax, bx
    jl actual_day_lower
    je actual_day_greater
    jg actual_day_greater

actual_day_lower: 
    xor eax, eax
    xor ebx, ebx
    mov eax, [esi + my_date.year]
    mov ebx, [edi + my_date_size * edx + my_date.year]
    sub eax, ebx
    cmp eax, 0
    jl put_zero
    je put_zero
    sub eax, 1
    mov [ecx + 4 * edx], eax
    cmp edx, 0
    jnz month_date
    jz finish

actual_day_greater:
    xor eax, eax
    xor ebx, ebx
    mov eax, [esi + my_date.year]
    mov ebx, [edi + my_date_size * edx + my_date.year]
    sub eax, ebx
    cmp eax, 0
    jl put_zero
    mov [ecx + 4 * edx], eax
    cmp edx, 0
    jnz month_date
    jz finish

put_zero:
    xor eax, eax
    mov [ecx + 4 * edx], eax
    cmp edx, 0
    jnz month_date
    jz finish

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
finish:
    popa
    leave
    ret
    ;; DO NOT MODIFY
