#include <stdio.h>
#include <string.h>

unsigned char code[] = "SHELLCODE";

int main() {
    printf("Shellcode Length:  %ld\n", strlen(code));
    void (*ret)() = (void *)code;
    ret();
    return 0;
}
