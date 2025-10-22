;written by Kayla Humphrey, 2/18/2025
;Purpose: p4 for assignment 2, taking a two character string from the user and swapping it
BITS 32

GLOBAL _start

section .text

_start:
;first we print out the title
mov eax, 4 ;write
mov ebx, 1 ;stdout
mov ecx, title ;message
mov edx, titlelen ;length
int 0x80 ;kernel control

;then we prompt the user for their characters
mov eax, 4 ;write
mov ebx, 1 ;stdout
mov ecx, prompt ;message
mov edx, promptlen ;length
int 0x80 ;kernel control

;then read the input
mov eax, 3 ; read
mov ebx, 0 ; stdin
mov ecx, two_char_string ; the "variable"
mov edx, 3 ; reserved space for that variable
int 0x80 ; kernel reads

;now we will swap the bytes of those characters
mov ax, [two_char_string] ; move entire string into ax
mov ch, al ; create a placeholder for the lower part of ax
mov al, ah ; put the higher part of ax into al
mov ah, ch ; put the lower part into the higher part, effectively swapping them
mov [two_char_string], ax ; put the swapped value back into memory

;print the answer
mov eax, 4 ;write
mov ebx, 1 ;stdout
mov ecx, answer ;message
mov edx, answerlen ;length
int 0x80 ;kernel control

mov eax, 4 ;write
mov ebx, 1 ;stdout
mov ecx, two_char_string ;message
mov edx, 3 ;length
int 0x80 ;kernel control

;terminate program
mov eax, 1
int 0x80

section .data
;title
title db 'The Swapping Program', 0xa 
titlelen equ $-title
;character prompt
prompt db 'Please enter a two character string:', 0xa
promptlen equ $-prompt
;answer prompt
answer db 'The answer is: '
answerlen equ $-answer

section .bss
two_char_string resb 3
