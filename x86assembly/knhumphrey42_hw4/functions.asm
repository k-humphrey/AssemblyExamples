;Kayla Humphrey, HW 4, CSC 3410-002, functions for backandforth.c
BITS 32
GLOBAL addstr
EXTERN atoi
GLOBAL is_palindromeA
GLOBAL factstr
EXTERN fact
GLOBAL palindrome_check
EXTERN is_palindromeC



section .data
prompt db 'Please enter a string: '
promptlen EQU $-prompt
isp db 'It is a palindrome.', 0xa
isplen EQU $-isp
isnp db 'It is NOT a palindrome.', 0xa
isnplen EQU $-isnp

SECTION .bss
str: RESB 1024

SECTION .text
;Function: addstr
;parameters: char* a and char *b which represent two numbers
;output: the result of the two added numbers as an "int"
addstr:
    ;set up stack, add ebx first to save the first return of atoi
    push ebx
    push ebp
    mov ebp, esp
    
    ;set esi to the second parameter and push onto the stack to call atoi. clean up the stack
    mov esi, [ebp + 16]
    push esi
    call atoi
    add esp, 4

    ;save the value returned from atoi
    mov ebx, eax

    ;do it one more time with the first parameter
    mov esi, [ebp + 12]
    push esi
    call atoi
    add esp, 4

    ;now add the first parameter to the second, storing result in eax as c expects
    add eax, ebx
    

    ;clean up the stack in reverse order and return control
    mov esp, ebp
    pop ebp
    pop ebx
    ret

;function: is_palindromeA
;parameters: a char * s that is the string to be evaluated
;output: 1 if palindrome, 0 if not
is_palindromeA:
    push ebp
    mov ebp, esp
    push esi
    push edi

    ;get pointers to beggining and ends of string
    mov esi, [ebp + 8]
    mov edi, esi

    ;find end is a loop that moves edi to the last character of the string
    find_end:
    cmp BYTE [edi], 0
    je end_find_end

    inc edi
    jmp find_end

    end_find_end:
    dec edi

    ;check_loop checks whether the string is a palindrome
    check_loop:
    cmp esi, edi
    jge palindrome ; if esi has surpassed edi without any character's being unequal, then its a palindrome

    mov al, [esi]
    cmp al, [edi]
    jne not_palindrome ; if any characters are unequal, it is automatically not a palindrome

    ;given that characters are equal, but there are still more characters to check, we move our pointers inwards and loop again
    inc esi
    dec edi
    jmp check_loop

    not_palindrome: ;set return value and clean stack
    mov eax, 0
    pop edi
    pop esi
    pop ebp
    ret

    palindrome: ;set return value and clean stack
    mov eax, 1
    pop edi
    pop esi
    pop ebp
    ret

;function: factstr
;parameters: a c string that contains an integer
;output: the factorial of that integer
factstr:
    push ebp
    mov ebp, esp

    ;call atoi
    mov esi, [ebp + 8]
    push esi
    call atoi
    add esp, 4

    ;call fact
    push eax
    call fact
    add esp, 4

    pop ebp
    ret
;function: palindrome_check
;parameters: none
;output: prints whether a string is a palindrome or not
palindrome_check:
    push ebp
    mov ebp, esp
    push eax
    push ebx
    push ecx
    push edx

    ;prompt for string
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, promptlen
    int 0x80

    ;read string
    mov eax, 3
    mov ebx, 0
    mov ecx, str
    mov edx, 1024
    int 0x80

    ;take off newline and zero terminate
    dec eax
    mov bl, 0
    mov [str + eax], bl

    ;call is_palindromeC
    mov esi, str
    push esi
    call is_palindromeC
    add esp, 4

    ;if ispalindromeC returns 1, that means it is a palindrome
    cmp eax, 1
    je is
    
    ;print out answer and clean stack
    mov eax, 4
    mov ebx, 1
    mov ecx, isnp
    mov edx, isnplen
    int 0x80

    pop edx
    pop ecx
    pop ebx
    pop eax
    mov esp, ebp
    pop ebp
    ret

is:
    ;print out answer and clean stack
    mov eax, 4
    mov ebx, 1
    mov ecx, isp
    mov edx, isplen
    int 0x80

    pop edx
    pop ecx
    pop ebx
    pop eax
    mov esp, ebp
    pop ebp
    ret