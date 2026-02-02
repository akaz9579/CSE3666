#       CSE 3666 Lab 2 DIVU
#       TAG: 7e565c9c03f7747a263b

        # instructions are placed in the .text section
        .text
main:   

        # DIV examples
        # 10 // 5 = 2 r 0
        # 15 // 1 = 15 r 0
        # 100 // 3 = 33 r 1
        # read two positive integers from the console and 
        # save them in s1 and s2 

        # use system call 5 to read integers
        addi    a7, x0, 5
        ecall
        addi    s1, a0, 0       # n in s1

        addi    a7, x0, 5
        ecall
        addi    s2, a0, 0       # d in s2

        # TODO
        # Add you code here
        # compute 
        #       s3: q = n // d
        #       s4: r = n % d 
        # and print them

        # no need to change lines below
        # sys call to exit
exit:   addi    a7, x0, 10
        ecall
