section .text
    global rotp

;; void rotp(char *ciphertext, char *plaintext, char *key, int len);
rotp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; ciphertext
    mov     esi, [ebp + 12] ; plaintext
    mov     edi, [ebp + 16] ; key
    mov     ecx, [ebp + 20] ; len
    ;; DO NOT MODIFY


    ;; FREESTYLE STARTS HERE
    xor ebp, ebp ; iterator pentru plaintext

func_rotp:
    xor eax, eax
    xor ebx, ebx
    mov al, [esi + ebp] 
    mov bl, [edi + ecx - 1] 
    xor al, bl
    mov [edx + ebp], al
    inc ebp
    loop func_rotp

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY