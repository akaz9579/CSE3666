# Addition of decimal strings

# strings are stored in global data section 
        .data   
dst:    .space  128
str1:   .space  128
str2:   .space  128

# instructions are in text section
        .text
main: 
        # load adresses of strings into s1, s2, and s3
        # s3 is dst, where we store the result 

        lui     s3, 0x10010 
        addi    s1, s3, 128
        addi    s2, s1, 128

        # read the first number as a string
        addi    a0, s1, 0
        addi    a1, x0, 100
        addi    a7, x0, 8
        ecall

        # read the second number as a string
        addi    a0, s2, 0
        addi    a1, x0, 100
        addi    a7, x0, 8
        ecall

        #TODO
        # write a loop to find out the number of decimal digits in str1
        # the loop searches for the first character that is less than '0' 

        # Note that we assume str1, str2, and dst have the same number of 
        # decimal digits. 

        # We then write a loop to add str1 and str2, and save the result in 
        # dst. 
        # Remember that dst should have a terminating NULL.

        # find the length
        # do addition
        # print the result


        addi    t0, x0, 0
loop:
        add     t1, s1, t0
        lb      t2, 0(t1)
        addi    t3, x0, '0'
        blt     t2, t3, done
        addi    t0, t0, 1
        beq     x0, x0, loop

done:
        addi    t4, x0, 0
        addi    t1, t0, -1

add:
        add     t5, s1, t1
        lb      t6, 0(t5)
        add     t5, s2, t1
        lb      t7, 0(t5)

        addi    t6, t6, -'0'
        addi    t7, t7, -'0'
        add     t6, t6, t7
        add     t6, t6, t4

        addi    t4, x0, 0
        addi    t8, x0, 10
        blt     t6, t8, noCarry
        addi    t6, t6, -10
        addi    t4, x0, 1
noCarry:
        addi    t6, t6, '0'
        add     t5, s3, t1
        sb      t6, 0(t5)

        addi    t1, t1, -1
        bge     t1, x0, add

        add     t5, s3, t0
        sb      x0, 0(t5)

        addi    a0, s3, 0
        addi    a7, x0, 4
        ecall

        # exit
        addi    a7, x0, 10
        ecall
