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

        # Call print_hello to print the message
        call    print_hello

        # Prepare return value (0)
        movl    $0, %eax

        # Epilogue
        movl    %ebp, %esp
        popl    %ebp

        # Instead of ret (which would return to nowhere), call exit.
        pushl   %eax              # Push return code for exit
        call    exit

        # ---------------------------------------------
        # print_hello: Prints "Hello World\n"
        # ---------------------------------------------
        .globl  print_hello
        .type   print_hello, @function

print_hello:
        # Prologue
        pushl   %ebp
        movl    %esp, %ebp

        # Push the address of msg so printf has its argument
        pushl   $msg
        call    printf
        addl    $4, %esp          # Clean up the argument

        # Epilogue
        movl    %ebp, %esp
        popl    %ebp
        ret
