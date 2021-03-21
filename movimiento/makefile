output: mov.o
	ld mov.o -o mov

printLab.o: mov.asm
	nasm -f elf64 mov.asm -o mov.o

clean:
	rm *.o