        .section .data
funcVal_fmt:
        .ascii  "funcVal %d\n\0"    # Format string for funcVal
funcPtr_fmt:
        .ascii  "funcPtr %p\n\0"    # Format string for funcPtr

        .section .text

        .globl  funcVal
        .type   funcVal, @function
funcVal:
        # Function prologue
        pushl   %ebp
        movl    %esp, %ebp

        # The integer parameter is at 8(%ebp)
        # Push the parameter and the address of our format string for printf
        pushl   8(%ebp)           # Push the integer argument
        pushl   $funcVal_fmt      # Push pointer to "funcVal %d\n"
        call    printf
        addl    $8, %esp          # Clean up the two arguments from the stack

        # Function epilogue
        movl    %ebp, %esp
        popl    %ebp
        ret

        .globl  funcPtr
        .type   funcPtr, @function
funcPtr:
        # Function prologue
        pushl   %ebp
        movl    %esp, %ebp

        # The pointer parameter is at 8(%ebp)
        # Push the parameter and the address of our format string for printf
        pushl   8(%ebp)           # Push the pointer argument
        pushl   $funcPtr_fmt      # Push pointer to "funcPtr %p\n"
        call    printf
        addl    $8, %esp          # Clean up the two arguments

        # Function epilogue
        movl    %ebp, %esp
        popl    %ebp
        ret

        .globl  main
        .type   main, @function
main:
        # Prologue (manual, no 'leave')
        pushl   %ebp
        movl    %esp, %ebp

        # Allocate space for local variable 'a' (4 bytes)
        subl    $4, %esp
        movl    $50, -4(%ebp)     # int a = 50;

        # Call funcVal(a)
        pushl   -4(%ebp)          # Push the value of a (50)
        call    funcVal
        addl    $4, %esp          # Clean up the argument

        # Call funcPtr(&a)
        leal    -4(%ebp), %eax    # Get the address of a
        pushl   %eax              # Push &a
        call    funcPtr
        addl    $4, %esp          # Clean up the argument

        # Prepare return value (0)
        movl    $0, %eax

        # Epilogue (restore stack frame)
        movl    %ebp, %esp
        popl    %ebp

        # Instead of ret (which would return to nowhere), call exit.
        pushl   %eax              # Push the return code (0)
        call    exit
