OUTPUT_FORMAT(elf_x86_64)
SECTIONS
 {
   . = 0x1000;
   .text : { *(.text) }
   .data : { *(.data) }
   .bss  : { *(.bss)  }
 }
