output: spawn.o
	ld spawn.o -o spawn

printLab.o: spawn.asm
	nasm -f elf64 spawn.asm -o spawn.o

clean:
	rm *.o