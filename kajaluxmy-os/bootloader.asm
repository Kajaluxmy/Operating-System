; bootloader.asm
[org 0x7c00]         ; BIOS loads the boot sector to 0x7C00

start:
    mov si, message  ; Point to the start of the message

print_loop:
    lodsb            ; Load byte at DS:SI into AL, then increment SI
    cmp al, 0        ; End of string?
    je hang          ; If yes, jump to hang
    mov ah, 0x0E     ; Teletype output function
    int 0x10         ; BIOS interrupt to print character
    jmp print_loop   ; Loop again

hang:
    jmp $            ; Infinite loop

message db 'hello, welcome Kajaluxmy OS', 0

; Fill to 510 bytes with zeros
times 510 - ($ - $$) db 0
dw 0xAA55            ; Boot signature (must be last 2 bytes)
