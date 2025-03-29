[org 0x7C00]     ; BIOS loads MBR here

start:
    mov si, message

print_loop:
    lodsb               ; AL = [SI], SI++
    cmp al, 0
    je hang

    mov ah, 0x0E        ; BIOS teletype function
    int 0x10
    jmp print_loop

hang:
    cli
    hlt
    jmp hang

message db "Hello from the bootloader!", 0

; Fill to 510 bytes
times 510-($-$$) db 0
dw 0xAA55    ; MBR signature
