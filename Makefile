64v:	boot32.asm boot64.asm kernel.asm kernel.c
	nasm -fbin boot32.asm -o boot32.bin
	# gcc -m64 -ffreestanding -fno-pic -fno-stack-protector -nostdlib -c kernel.c -o kernel64.o
	nasm -felf64 boot64.asm -o boot64.o
	clang -m64 -ffreestanding -fno-pic -fno-stack-protector -nostdlib -S -emit-llvm kernel.c -o kernel64.ll
	llc -filetype=obj -mtriple=x86_64-elf -opaque-pointers=1 kernel64.ll -o kernel64.o
	ld  -melf_x86_64 -o kernel64.bin -Ttext 0x1000 boot64.o kernel64.o --oformat binary -T linker.ld
	cat boot32.bin kernel64.bin > boot.img

clear:
	rm *.o *.bin *.img
