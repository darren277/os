# Makefile in project root
.PHONY: all clean iso

#BOOTLOADER = bootloader.bin
KERNEL_OBJ = kernel.o
KERNEL_ELF = kernel.elf
ISO_NAME   = os.iso

all: iso

# 1) Assemble bootloader (16-bit MBR)
#$(BOOTLOADER): src/bootloader.asm
#	nasm -f bin $< -o $@

# 2) Assemble 32-bit kernel code (Multiboot)
$(KERNEL_OBJ): src/kernel.asm
	nasm -f elf32 $< -o $@

# 3) Link kernel ELF (using your linker.ld)
$(KERNEL_ELF): $(KERNEL_OBJ) src/linker.ld
	ld -m elf_i386 -T src/linker.ld -o $@ $(KERNEL_OBJ)

# 4) Build ISO with GRUB
iso: $(BOOTLOADER) $(KERNEL_ELF) grub.cfg
	mkdir -p iso/boot/grub
	#cp $(BOOTLOADER) iso/boot/bootloader.bin
	cp $(KERNEL_ELF) iso/boot/kernel.elf
	cp grub.cfg       iso/boot/grub/grub.cfg

	# Write the bootloader to the first 512 bytes of a disk image (optional).
	# This creates an MBR in sector 0, so the ISO is "hybrid" (MBR + GRUB).
	#dd if=/dev/zero of=$(ISO_NAME) bs=1k count=1440
	#dd if=$(BOOTLOADER) of=$(ISO_NAME) conv=notrunc

	# Generate a bootable ISO that includes our MBR + GRUB folder:
	grub-mkrescue -o $(ISO_NAME) iso -d /usr/lib/grub/i386-pc

	# Copy the final ISO to qemu/ so Docker can mount it.
	mkdir -p qemu
	cp $(ISO_NAME) qemu/$(ISO_NAME)

clean:
	rm -rf *.bin *.o *.elf *.iso iso qemu/$(ISO_NAME)
	rm -f $(BOOTLOADER) $(KERNEL_OBJ) $(KERNEL_ELF) $(ISO_NAME)
