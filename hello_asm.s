# First, let's define the message as a C-style string
my_message: .asciz "Hello, world!\n"

# Now, the actual program
.globl _main  # Export the _main symbol so it can be called from outside the program
_main:  # Code execution starts here
    leaq my_message(%rip), %rdi  # Load the message into the first argument register
    
    # To call printf, we have to do some stack setup and teardown:
    pushq %rbp  # Save the base pointer
    movq %rsp, %rbp  # Save the stack pointer
    andq $-16, %rsp  # Align the stack pointer
    callq _printf  # Call printf
    movq %rbp, %rsp  # Restore the stack pointer
    popq %rbp  # Restore the base pointer

	movq $0, %rax  # Load 0 into the return register
    retq  # Return
