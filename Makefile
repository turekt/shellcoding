PROJECT=hello
GCC=gcc
NASM=nasm
NDISASM=ndisasm
LD=ld
OBJCOPY=objcopy
HEXDUMP=hexdump
ECHO=echo
OUT=out
SKELETON=skeleton

.PHONY: folder
folder:
	mkdir -p $(OUT)

.PHONY: c
c: folder
	$(GCC) -o $(OUT)/$(PROJECT) $(PROJECT)/$(PROJECT).c

.PHONY: asm
asm: folder
	$(NASM) -felf64 -o $(OUT)/$(PROJECT).o $(PROJECT)/$(PROJECT).s
	$(LD) -o $(OUT)/$(PROJECT) $(OUT)/$(PROJECT).o
	
.PHONY: shcd
shcd: folder
	$(NASM) -felf64 -o $(OUT)/$(PROJECT)_sh.o $(PROJECT)/$(PROJECT)_sh.s
	$(LD) -o $(OUT)/$(PROJECT) $(OUT)/$(PROJECT)_sh.o
	$(OBJCOPY) -O binary $(OUT)/$(PROJECT) $(OUT)/shellcode
	
.PHONY: shellcode
shellcode: shcd	
	$(HEXDUMP) -v -e '"\\x" 1/1 "%02x"' $(OUT)/shellcode
	
.PHONY: disasm
disasm: shcd
	$(NDISASM) -b64 $(OUT)/shellcode
	
.PHONY: shellcode-test
skeleton: shellcode
	$(eval HEX=$(shell $(HEXDUMP) -v -e '"\\\\x" 1/1 "%02x"' $(OUT)/shellcode))
	sed -e 's/SHELLCODE/$(HEX)/' ./$(SKELETON).c | gcc -no-pie -fno-stack-protector -z execstack -x c -o $(OUT)/$(SKELETON) -
