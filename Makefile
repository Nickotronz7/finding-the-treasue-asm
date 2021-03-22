output: main.o
	ld main.o -o main

main.o: main.asm
	nasm -f elf64 main.asm -o main.o

clean:
	rm *.o
	rm main