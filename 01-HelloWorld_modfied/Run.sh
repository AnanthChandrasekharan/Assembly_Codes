as --32 HelloWorld.s -o HelloWorld.o
ld -m elf_i386 HelloWorld.o -o HelloWorld -lc -dynamic-linker /lib/ld-linux.so.2
rm -rf HelloWorld.o
./HelloWorld
