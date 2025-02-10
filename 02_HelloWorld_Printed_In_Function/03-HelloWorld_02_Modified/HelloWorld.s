        .code32

        .section .data
msg:
        .ascii  "Hello World\n\0"  # Our message string

        .section .text

        .globl main
        .type main, @function

        .extern printf
        .extern exit

main:
        # Call print_hello to print the message.
        call print_hello

        # Prepare return value (0) in %eax.
        movl    $0, %eax

        # Instead of pushl/popl, adjust %esp directly for the argument to exit.
        subl    $4, %esp         # Allocate space for exit's argument.
        movl    %eax, (%esp)      # Place the return value (0) into that space.
        call    exit             # Call exit.
        addl    $4, %esp         # (Not reached normally.)

        # ---------------------------------------------
        # print_hello: Prints "Hello World\n"
        # ---------------------------------------------
        .globl print_hello
        .type print_hello, @function

print_hello:
        # Adjust %esp to reserve space for printf's argument.
        subl    $4, %esp         # Reserve 4 bytes on the stack.
        movl    $msg, (%esp)      # Place the address of msg into that space.
        call    printf           # Call printf to print the string.
        addl    $4, %esp         # Restore %esp after the call.
        ret
