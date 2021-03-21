output: printLab.o
	ld printLab.o -o printLab

printLab.o: printLab.asm
	nasm -f elf64 printLab.asm -o printLab.o

clean:
	rm *.o