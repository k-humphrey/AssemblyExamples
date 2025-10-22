;Kayla Humphrey, Assignment 3 CSC3410-002, A program that returns true if a string is a palindrome
;NOTE: I hope it is okay that i did not use actual string functions. I could not use cmpsb because it was advancing my edi pointer the wrong way.. trust me I tried.
;I also could have copied one of the strings in reverse and then compared them using cmpsb but... that doesn't match the pseudocode
BITS 32

GLOBAL _start

;functions and constants
BUFFER_SIZE EQU 1024
is_palindrome: 
        continue:
            ;here we compare esi and edi's addresses. if esi has surpassed edi, or if they are equal that means we have reached the middle and checked all characters without finding a "non equal" one
            cmp esi, edi
            jge palindrome

            ;given that we are not at the end, we load 1 character (1 byte) into al and bl, then we compare them. 
            mov al, [esi]
            mov bl, [edi]
            cmp al, bl
            ;if at any point these parallel characters are unequal, it is not a palindrome
            jne not_palindrome
            
            ;move both esi and edi inwards and return control back up to the top of the loop
            inc esi
            dec edi
            jmp continue
    
ret

section .text
_start:
    again:
        ;prompt the user
        mov eax, 4
        mov ebx, 1
        mov ecx, prompt
        mov edx, promptlen
        int 0x80

        ;read the string into buf
        mov eax, 3
        mov ebx, 0
        mov ecx, buf
        mov edx, BUFFER_SIZE
        int 0x80

        ;subtract the newline from the string size returned to eax and get the length into a label called size
        sub eax, 1
        mov [size], eax

        ;if only a newline has been entered then size is 0, meaning we end the program
        cmp BYTE [size], 0
        je exit

        ;point esi to the beginning of the string and edi to the end of the string
        mov esi, buf
        mov edi, buf
        add edi, [size]
        dec edi

        ;if there is a string entered, we call the function is_palindrome which will handle the rest
        CALL is_palindrome

not_palindrome:
;print that its not a palindrome and return control to the top of the main loop
    mov eax, 4
    mov ebx, 1
    mov ecx, notp
    mov edx, notplen
    int 0x80

    jmp again

palindrome:
;print that its a palindrome and return control to the top of the main loop
    mov eax, 4
    mov ebx, 1
    mov ecx, isp
    mov edx, isplen
    int 0x80

    jmp again

    
exit:
    ;exiting nicely with a newline
    mov eax, 4
    mov ebx, 1
    mov ecx, 0xa
    mov edx, 1
    int 0x80

    mov eax, 1
    int 0x80


section .data
    ;prompt text
    prompt DB 'Please enter a string:', 0xa
    promptlen EQU $ - prompt
    ;not plaindrome
    notp DB 'It is NOT a palindrome', 0xa
    notplen EQU $ - notp
    ;palindrome
    isp DB 'It is a palindrome', 0xa
    isplen EQU $ - isp


section .bss
    ;to hold entered string
    buf RESB 1024
    ;to hold length of entered string
    size RESB 2