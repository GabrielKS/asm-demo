fmt_str: .asciz "%.17g\n"      # Format string
four: .double 4.0              # Double constant
.globl _main
_main:
    pushq %rbx
    movq $0, %r12              # t = 0
    movq $0, %r13              # n = 0
    movq $1, %r14              # y = 1
    movq $0, %r15              # y2 = 0
i:
    imulq %r12, %r14           # y *= t
    addq %r13, %r14            # y += n
    sarq $7, %r14              # y >>= 7
    movslq %r14d, %r14         # y = (int)y
    movq %r15, %rbx            # tmp = y2
    movq %r14, %r15            # y2 = y
    imulq %r15, %r15           # y2 *= y2
    addq %r15, %rbx            # tmp += y2
    sarq $62, %rbx             # tmp >>= 62
    subq %rbx, %r13            # n -= tmp
    incq %r12                  # t++
    incq %r13                  # n++
    movq %r12, %rbx            # tmp = t
    salq $36, %rbx             # tmp <<= 36
    test %rbx, %rbx
    jne i                      # Jump if tmp != 0

    # Floating point math within the if block
    cvtsi2sdq %r13, %xmm0      # xmm0 = (double)n
    mulsd four(%rip), %xmm0    # xmm0 *= 4.
    cvtsi2sdq %r12, %xmm1      # xmm1 = (double)t
    divsd %xmm1, %xmm0         # xmm0 /= xmm1

    # printf within the if block
    leaq fmt_str(%rip), %rdi   # Format string into first argument
    pushq %rbp                 # Stack alignment
    movq %rsp, %rbp
    andq $-16, %rsp
    callq _printf              # Call printf
    movq %rbp, %rsp
    popq %rbp
    
    movq %r12, %rbx            # tmp = t
    salq $30, %rbx             # tmp <<= 30
    test %rbx, %rbx
    jne i                      # Jump if tmp != 0

    popq %rbx
    movq $0, %rax
    retq
