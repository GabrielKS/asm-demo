linker = ld -L/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib

all: all_hello_c all_hello_asm all_hello_math

all_hello_c: hello_c hello_c.s hello_c.o hello_c_asm
hello_c: hello_c.c
	gcc hello_c.c -o hello_c
hello_c.s: hello_c.c
	gcc hello_c.c -S -o hello_c.s
hello_c.o: hello_c.s
	as hello_c.s -o hello_c.o
hello_c_asm: hello_c.o
	$(linker) -lSystem hello_c.o -o hello_c_asm	

all_hello_asm: hello_asm.o hello_asm
hello_asm.o: hello_asm.s
	as hello_asm.s -o hello_asm.o
hello_asm: hello_asm.o hello_asm.s
	$(linker) -lSystem hello_asm.o -o hello_asm  # redundant, yes
	gcc hello_asm.s -o hello_asm

all_hello_math: hello_math_c.s hello_math_c hello_math_asm
hello_math_c.s: hello_math.c
	gcc hello_math.c -S -o hello_math_c.s
hello_math_c: hello_math.c
	gcc hello_math.c -o hello_math_c
hello_math_asm: hello_math.s
	gcc hello_math.s -o hello_math_asm

clean:
	rm hello_c hello_c.s hello_c.o hello_c_asm
	rm hello_asm.o hello_asm
	rm hello_math_c.s hello_math_c hello_math_asm
