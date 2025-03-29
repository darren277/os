[bits 32]

; ---------------------------------------------------
; Multiboot Header (for GRUB or any Multiboot loader)
; ---------------------------------------------------
align 4
multiboot_header:
    dd 0x1BADB002           ; magic number
    dd 0x0                  ; flags = no special flags
    dd -(0x1BADB002 + 0x0)  ; checksum

global _start
_start:
    ; Write "Hello from the kernel!" to VGA text mode
    mov eax, 0xB8000
    mov ds, ax
    mov es, ax

    ; Print each character with attribute 0x07 (light gray on black)
    mov byte [eax],   'H'
    mov byte [eax+1], 0x07
    mov byte [eax+2], 'e'
    mov byte [eax+3], 0x07
    mov byte [eax+4], 'l'
    mov byte [eax+5], 0x07
    mov byte [eax+6], 'l'
    mov byte [eax+7], 0x07
    mov byte [eax+8], 'o'
    mov byte [eax+9], 0x07
    mov byte [eax+10], ' '
    mov byte [eax+11], 0x07
    mov byte [eax+12], 'k'
    mov byte [eax+13], 0x07
    mov byte [eax+14], 'e'
    mov byte [eax+15], 0x07
    mov byte [eax+16], 'r'
    mov byte [eax+17], 0x07
    mov byte [eax+18], 'n'
    mov byte [eax+19], 0x07
    mov byte [eax+20], 'e'
    mov byte [eax+21], 0x07
    mov byte [eax+22], 'l'
    mov byte [eax+23], 0x07
    mov byte [eax+24], '!'
    mov byte [eax+25], 0x07

.hang:
    jmp .hang
