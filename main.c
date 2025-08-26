void shutdown(void) {
        asm volatile ("movw $0x2000, %%ax; movw $0x604, %%dx; outw %%ax, %%dx" ::: "ax", "dx");
}
