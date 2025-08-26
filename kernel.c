char *vidptr = (char*)0xb8000;

unsigned int i = 0;
unsigned int current_loc = 0;

void scroll_screen(void)
{
        unsigned int i = 0;
        for (i = 0; i < (25 - 1) * 80 * 2; i++) {
                vidptr[i] = vidptr[i + 80 * 2];
        }
        for (i = (25 - 1) * 80 * 2; i < 25 * 80 * 2; i += 2) {
                vidptr[i] = ' ';
                vidptr[i + 1] = 0x07;
        }
        current_loc = (25 - 1) * 80 * 2;
}

void newline(void)
{
        unsigned int line_size = 2 * 80;
        current_loc = current_loc + (line_size - current_loc % (line_size));
        if (current_loc >= 2000) {
            scroll_screen();
        }
}

void clear_screen(void) {
        unsigned int i = 0;
        while (i < 2000) {
                vidptr[i++] = ' ';
                vidptr[i++] = 0x07;
        }
        current_loc = 0;
}

void print(const char *str)
{
    unsigned int i = 0;
    while (str[i] != '\0') {
        if (str[i] == '\n') {
                newline();
                i++;
        }
        vidptr[current_loc++] = str[i++];
        vidptr[current_loc++] = 0x07;
        if (current_loc >= 2000) {
                scroll_screen();
        }
    }
}

void shutdown(void) {
	asm volatile ("movw $0x2000, %%ax; movw $0x604, %%dx; outw %%ax, %%dx" ::: "ax", "dx");
}

void _start(void) {
	clear_screen();
	print("(BIOS mode)\n");
	// shutdown();
	while(1);
}
