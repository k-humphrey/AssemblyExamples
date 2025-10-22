; written by Kayla Humphrey
; simple hello world program
BITS 32 ; declare 32 bits

global _start ;for linker

section .text ; where code is stored
_start:
    mov edx, len ;message length
    mov ecx, msg ; message
    mov ebx, 1 ; stdout
    mov eax, 4 ; syscall write
    int 0x80 ; kernel interrupt

    mov eax, 1 ;syscall exit
    int 0x80 

section .data ; define the msg and len
    msg db 'Hello, World!', 0xa ; msg label, define bytes, msg, newline
    len equ $-msg ; label len, equate length to the address of last bit - the address of the msg start