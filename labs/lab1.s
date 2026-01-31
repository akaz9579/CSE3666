#       CSE 3666 Lab 1 Median
#       TAG: 4b65a92624740b63b57e263
        
        .text                   # Code segment
main: 

        # use system call 5 to read integers
        addi    a7, x0, 5
        ecall
        addi    s1, a0, 0	# a in s1

        addi    a7, x0, 5
        ecall
        addi    s2, a0, 0	# b in s2

        # TODO
        # read another integer and save it in s3
        # find the median
        # print the median


        # do not change this line and lines below
        # sys call to exit
exit:   addi    a7, x0, 10
        ecall
