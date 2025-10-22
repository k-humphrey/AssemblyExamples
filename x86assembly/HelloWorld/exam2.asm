;Kayla humphrey, 3/25/2025, exam 2 practice
BITS 32

; for linker
GLOBAL _start

;here we use the define directive to make stuff readable, I just do it for eax
%define SYSCALL(num) mov eax, num
%assign WRITE 4
%assign READ 3
%assign EXIT 1

section .text

_start:

;using the define we made earlier we write a title out
SYSCALL(WRITE)
mov ebx, 1
mov ecx, hello
mov edx, hellolen
int 0x80

;now we are going to read two numbers, and print out what would happen if we added the 2nd number to the first number 3 times
SYSCALL(WRITE)
mov ebx, 1
mov ecx, prompt
mov edx, promptlen
int 0x80

SYSCALL(READ)
mov ebx, 0
mov ecx, num1
mov edx, 2
int 0x80

SYSCALL(WRITE)
mov ebx, 1
mov ecx, prompt
mov edx, promptlen
int 0x80

SYSCALL(READ)
mov ebx, 0
mov ecx, num2
mov edx, 2
int 0x80


; im going to create a number version of the numbers to be used in a loop by subtracting '0' from it
mov al, BYTE [num2]
sub al, '0'
mov BYTE [num2], al

mov al, BYTE [num1]
sub al, '0'
mov BYTE [num1], al

; now the looping
mov al, [num1]
mov bl, [num2]
mov cx, 0

adding:
cmp cx, 3
jge end_adding
add al,bl
inc cx
jmp adding

end_adding:
add al, '0'
mov [sum], al

SYSCALL(WRITE)
mov ebx, 1
mov ecx, sum
mov edx, 2
int 0x80

SYSCALL(EXIT)
int 0x80

section .data
hello db 'Hello, this is a practice program for exam 2!', 0xa
hellolen EQU $ - hello
prompt db 0xa, 'Please enter a number, unsigned: '
promptlen EQU $ - prompt

section .bss
num1 RESB 2
num2 RESB 2
sum RESB 2