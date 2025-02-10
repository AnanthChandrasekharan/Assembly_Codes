        .code32

        .section .data
msg:
        .ascii  "Hello World\n\0"  # Our message string

        .section .text

        .globl  main
        .type   main, @function

        .extern printf
        .extern exit

main:
        # Prologue (manual, no 'leave')
        pushl   %ebp
        movl    %esp, %ebp

        # Push the address of msg so printf has its argument
        pushl   $msg
        call    printf
        addl    $4, %esp           # Clean up the argument

        # Prepare return value (0)
        movl    $0, %eax

        # Epilogue
        movl    %ebp, %esp
        popl    %ebp

        # Instead of ret (which would return to nowhere), call exit.
        pushl   %eax              # Push return code for exit
        call    exit
