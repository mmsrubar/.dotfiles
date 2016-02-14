#GENERAL SYNTAX
#target: dependencies
#	command

CC=gcc
CFLAGS=-pedantic -Wall -Wextra -Wstrict-prototypes -std=c99
# build executalbe binary file program from program.c by use 
# gcc program.o -o prg
program: program.o
	$(CC) $(CFLAGS) program.o -o program

# build the object file program.o from program.c by use gcc -c program.c
program.o: program.c
	$(CC) $(CFLAGS) -c program.c


# remove program.o and program if you type make clean
clean:
	rm program.o program