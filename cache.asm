;; defining constants, you can use these as immediate values in your code
CACHE_LINES  EQU 100
CACHE_LINE_SIZE EQU 8
OFFSET_BITS  EQU 3
TAG_BITS EQU 29 ; 32 - OFSSET_BITS

section .data
    tag dd 0
    address dd 0
    cnt dd 0
    line_position dd 0
    pos dd 0

section .text
    global load

;; void load(char* reg, char** tags, char cache[CACHE_LINES][CACHE_LINE_SIZE], char* address, int to_replace);
load:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; address of reg
    mov ebx, [ebp + 12] ; tags
    mov ecx, [ebp + 16] ; cache  
    mov edx, [ebp + 20] ; address
    mov edi, [ebp + 24] ; to_replace (index of the cache line that needs to be replaced in case of a cache MISS)
    ;; DO NOT MODIFY
    
    ;; TODO: Implment load
    ;; FREESTYLE STARTS HERE
    
    mov [address], edx

    xor esi, esi
    mov esi, edx  ; adresa data
    shr esi, OFFSET_BITS
    mov [tag], esi

    xor edx, edx
    mov esi, [address]
    mov dl, byte [esi]
    mov [eax], dl

xor ebp, ebp

search_tag:
    xor esi, esi
    mov esi, [ebx + ebp * 4] 
    cmp [tag], esi
    je finish
    inc ebp
    cmp ebp, CACHE_LINES
    jl search_tag
    jge tag_not_found
  
tag_not_found:
    xor esi, esi
    mov esi, [tag]
    mov [ebx + edi * 4], esi  ; pun tagul in tags daca nu exista
    xor ebp, ebp
    xor esi, esi
    jmp get_line

get_line:
    mov ebp, [cnt]
    add esi, CACHE_LINE_SIZE
    mov [line_position], esi
    inc ebp
    mov [cnt], ebp
    cmp edi, ebp
    jg get_line
    xor ebp, ebp
    jle build_cache

build_cache:
    mov esi, [tag]
    shl esi, 3
    add esi, ebp    ; adaug 000, 001, 010 ..
    mov edx, [line_position] 
    add edx, ebp
    mov [pos], edx
    xor edx, edx
    mov dl, byte [esi]
    mov esi, [pos]
    mov [ecx + esi], edx
    inc ebp
    cmp ebp, CACHE_LINE_SIZE
    jl build_cache
    jge finish

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
finish:
xor esi, esi
    mov [tag], esi
    mov [address], esi
    mov [cnt], esi
    mov [line_position], esi
    mov [pos], esi
    popa
    leave
    ret
    ;; DO NOT MODIFY