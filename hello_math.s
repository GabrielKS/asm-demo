# A format string
fmt_str: .asciz "%d\n"

# The program
.globl _main
_main:
    movq $42, %rsi  # Second argument register = 42
    addq $5, %rsi  # Second argument register += 5
    leaq fmt_str(%rip), %rdi  # Format string into first argument register
    
    # Same stack alignment stuff as in hello_asm.s
    pushq %rbp
    movq %rsp, %rbp
    andq $-16, %rsp
    callq _printf  # Call printf
    movq %rbp, %rsp
    popq %rbp
	
    movq $0, %rax  # Load 0 into the return register
    retq  # Return
