        .section .data
funcVal_fmt:
        .ascii  "funcVal %d\n\0"    # Format string for funcVal
funcPtr_fmt:
        .ascii  "funcPtr %p\n\0"    # Format string for funcPtr

        .section .text

        .extern printf
        .extern exit

        .globl funcVal
        .type  funcVal, @function
funcVal:
        # Prologue using pushl/popl
        pushl   %ebp
        movl    %esp, %ebp

        # Parameter (an int) is at 8(%ebp)
        # Push the integer argument and the format string for printf.
        pushl   8(%ebp)           # Push the integer value (a copy of a)
        pushl   $funcVal_fmt      # Push pointer to the format string "funcVal %d\n"
        call    printf
        addl    $8, %esp          # Clean up the two arguments

        # Epilogue
        movl    %ebp, %esp
        popl    %ebp
        ret

        .globl funcPtr
        .type  funcPtr, @function
funcPtr:
        # Prologue using pushl/popl
        pushl   %ebp
        movl    %esp, %ebp

        # Parameter (a pointer) is at 8(%ebp)
        # Push the pointer argument and the format string for printf.
        pushl   8(%ebp)           # Push the pointer value
        pushl   $funcPtr_fmt      # Push pointer to the format string "funcPtr %p\n"
        call    printf
        addl    $8, %esp          # Clean up the two arguments

        # Epilogue
        movl    %ebp, %esp
        popl    %ebp
        ret

        .globl main
        .type  main, @function
main:
        # Standard function prologue
        pushl   %ebp
        movl    %esp, %ebp

        # Instead of subtracting from %esp to allocate a local variable,
        # we push the constant 50 onto the stack. This will be our variable 'a'.
        pushl   $50             # "Allocate" a by pushing its initial value (50)

        # --- Call funcVal(a) ---
        # We need to pass a by value. Since 'a' is already on the stack,
        # we can push the value at the top of the stack.
        pushl   (%esp)          # Push the value of a (which is 50)
        call    funcVal
        addl    $4, %esp        # Remove the argument pushed for funcVal

        # --- Call funcPtr(&a) ---
        # We want to pass the address of a. Since a is at the top of the stack,
        # its address is simply the current %esp.
        pushl   %esp            # Push the pointer to a (i.e. the address on the stack)
        call    funcPtr
        addl    $4, %esp        # Remove the argument pushed for funcPtr

        # Now that we've used 'a', remove it from the stack.
        popl    %eax            # Pop off 'a' (value 50) – we don't need it further

        # Set up return value (0) in %eax.
        movl    $0, %eax

        # Restore the caller’s stack frame
        popl    %ebp

        # Instead of using ret (which wouldn’t return to a valid caller),
        # push the return code and call exit.
        pushl   %eax            # Push return code (0) for exit
        call    exit
