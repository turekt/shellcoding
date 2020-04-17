# Shellcoding

`PROJECT` listing:
- `hello` - Hello, World x64
- `bind` - TCP bind x64

## Compiling via Makefile

Possible `Makefile` targets:
- `c` - compile C code
- `asm` - compile assembly
- `shellcode` - print shellcode to terminal
- `disasm` - disassemble shellcode
- `skeleton` - run shellcode inside skeleton

When specifying target, use the `PROJECT` variable to compile specific project.

### Compilation examples

Lines starting with `#` specify how to compile without `make`.

TCP bind C code compilation:
```
# gcc -o bind bind.c
make c PROJECT=bind
```

Assembly rewrite compilation:
```
# nasm -felf64 bind.s && ld -o bind bind.o
make asm PROJECT=bind
```

Convert assembly to shellcode:
```
# nasm -felf64 bind_sh.s && ld -o bind bind_sh.o
# objcopy -O binary bind shellcode
# hexdump -v -e '"\\x" 1/1 "%02x"' shellcode
make shellcode PROJECT=bind
```

Disassemble shellcode:
```
# ndisasm -b64 shellcode
make disasm PROJECT=bind
```

Test shellcode via skeleton:
```
# Replace SHELLCODE placeholder in skeleton.c with printed shellcode
# gcc -no-pie -fno-stack-protector -z execstack -x c -o skeleton skeleton.c
make skeleton PROJECT=bind
```

Results are stored in `out` folder if `Makefile` is used (specify `OUT` variable to `make` to change folder name).
