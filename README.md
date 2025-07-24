```markdown
# Kajaluxmy OS

A minimal 16-bit operating system built using x86 assembly. This OS boots using BIOS, prints a welcome message, and halts. Designed for learning low-level system development.

## What It Does

When booted, the OS displays the following message:

```

hello, welcome Kajaluxmy OS

````

## Prerequisites

Make sure you have the following tools installed on your Linux or WSL environment:

- NASM (Netwide Assembler)
- QEMU (to emulate and test the OS)

Install them using:

```bash
sudo apt update
sudo apt install nasm qemu
````

## How to Build and Run

### Step 1: Create a Working Directory

```bash
mkdir kajaluxmy-os
cd kajaluxmy-os
```

### Step 2: Write the Bootloader

Create a file named `bootloader.asm`:

```bash
nano bootloader.asm
```

Paste the following code:

```asm
; bootloader.asm
[org 0x7c00]
start:
    mov si, message
print_loop:
    lodsb
    cmp al, 0
    je hang
    mov ah, 0x0E
    int 0x10
    jmp print_loop
hang:
    jmp $
message db 'hello, welcome Kajaluxmy OS', 0
times 510 - ($ - $$) db 0
dw 0xAA55
```

### Step 3: Assemble the Bootloader

```bash
nasm -f bin bootloader.asm -o bootloader.bin
```

### Step 4: Run the OS

Use QEMU to test the bootable binary:

```bash
qemu-system-x86_64 -drive format=raw,file=bootloader.bin
```

You should see:

```
hello, welcome Kajaluxmy OS
```

## How It Works

* The BIOS loads the bootloader at memory address `0x7C00`.
* The bootloader prints the message using BIOS interrupt `int 0x10` (teletype).
* After printing, it halts in an infinite loop.

## What's Next?

* Change the text color using BIOS color attributes.
* Add keyboard input support.
* Chain-load a second-stage kernel.
* Learn about file systems and disk I/O.






