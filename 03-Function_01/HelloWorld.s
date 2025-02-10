        .section .data
msg:
        .ascii  "Hello World\n\0"  # Our message string

        .section .text

        # ---------------------------------------------
        # _start: The process entry point
        # ---------------------------------------------
        .globl  _start
        .type   _start, @function

        .extern main
        .extern exit

_start:
        # Call main() with no arguments
        call    main

        # main() returns an integer in EAX
        # Pass that to exit() as the return code
        pushl   %eax
        call    exit
        # If exit() returns at all (it shouldn't), fall through

        # ---------------------------------------------
        # main: Calls print_hello and returns 0
        # ---------------------------------------------
        .globl  main
        .type   main, @function

        .extern print_hello

main:
        # Prologue (manual, no 'leave')
        pushl   %ebp
        movl    %esp, %ebp

        # Call print_hello to print "Hello World\n"
        call    print_hello

        # Return 0 from main
        movl    $0, %eax

        # Epilogue
        movl    %ebp, %esp
        popl    %ebp
        ret

        # ---------------------------------------------
        # print_hello: Prints "Hello World\n"
        # ---------------------------------------------
        .globl  print_hello
        .type   print_hello, @function

        .extern printf

print_hello:
        # Prologue
        pushl   %ebp
        movl    %esp, %ebp

        # Push the address of msg so printf has its argument
        pushl   $msg
        call    printf
        addl    $4, %esp           # Clean up the argument

        # Epilogue
        movl    %ebp, %esp
        popl    %ebp
        ret
