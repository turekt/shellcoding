#include <stdio.h>
#include <unistd.h>

int main() {
    write(1, "Hello, World", 12);
    return 0;
}
