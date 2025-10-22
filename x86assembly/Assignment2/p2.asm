;written by Kayla Humphrey, 2/11/2025
;Purpose: p2 for assignment 2, multiplying two numbers from user input
BITS 32

GLOBAL _start

section .text
_start:
    ;first we display the title of the program
    mov eax, 4 ; write
    mov ebx, 1 ; standard output file descriptor
    mov ecx, title ; holds the title to print
    mov edx, titlelen ; tells how many bits the title is
    int 0x80 ; get kernel to do the print

    ;Then we prompt the user for their digits
    mov eax, 4 ; write
    mov ebx, 1 ;stdout
    mov ecx, prompt
    mov edx, promptlen
    int 0x80 ; kernel interrupt

    ;read that digit
    mov eax, 3 ; read
    mov ebx, 0 ; stdin
    mov ecx, digit1 ; the "variable"
    mov edx, 5 ; reserved space for that variable
    int 0x80 ; kernel reads

    ; prompt and read again
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, promptlen
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, digit2
    mov edx, 5
    int 0x80

    ;digits are strings so we convert by subtracting 48 from them
    mov eax, [digit1]
    sub eax, '0'
    mov [digit1], eax

    mov eax, [digit2]
    sub eax, '0'
    mov [digit2], eax

    ;now we need to multiply the two numbers and store into result
    mov ax, 0 ;zero out ax
    mov al, [digit1]
    mov bx, [digit2]
    imul bx
    mov [result], al

    ;result is a number, we have to add 48 to it to make it printable
    mov eax, [result]
    add eax, '0'
    mov [result], eax

    ;now we just print out the answer msg and the result
    mov eax, 4
    mov ebx, 1
    mov ecx, answer
    mov edx ,answerlen
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 5
    int 0x80

    ;terminate program
    mov eax, 1 
    int 0x80 


section .data
title db 'The Multiplying Program', 0xa ; define title
titlelen equ $ - title ; get length of title
prompt db 'Please enter a single digit number: ' 
promptlen equ $ - prompt
answer db 'The answer is: '
answerlen equ $ - answer

section .bss
digit1 resb 5
digit2 resb 5
result resb 5