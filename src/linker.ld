OUTPUT_FORMAT(elf32-i386)
ENTRY(_start)
SECTIONS
{
  . = 1M;               /* Place the code at 1MB */
  .text : {
    *(.multiboot_header)
    *(.text*)
  }
  .data : { *(.data*) }
  .bss  : { *(.bss*)  }
}
