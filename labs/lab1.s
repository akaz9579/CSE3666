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
        # median the median

        addi    a7, x0, 5
        ecall
        addi    s3, a0, 0	# c in s3

# if (s1 < s2):
#     if (s2 < s3):
#         median = s2
#     else if (s1 < s3):
#         median = s3
#     else:
#         median = s1
# else:
#     if (s1 < s3):
#         median = s1
#     else if (s2 < s3):
#         median = s3
#     else:
#         median = s2


        blt     s1, s2, swap1
        addi    t0, s1, 0
        addi    s1, s2, 0
        addi    s2, t0, 0

swap1:        
        blt     s2, s3, swap2
        addi    t0, s2, 0
        addi    s2, s3, 0
        addi    s3, t0, 0

swap2:        
        blt     s1, s2, median
        addi    t0, s1, 0
        addi    s1, s2, 0
        addi    s2, t0, 0

median:        
        addi    a0, s2, 0
        addi    a7, x0, 1
        ecall
        
        # do not change this line and lines below
        # sys call to exit
exit:   addi    a7, x0, 10
        ecall