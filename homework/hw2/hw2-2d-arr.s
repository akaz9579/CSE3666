#       HW2 - 2D array

        .data
        .align  2
T:      .space 512
D:      .space 512

        .text
main:
        lui     s1, 0x10010     # hard code the address of T 
        addi    s2, s1, 512     # addr of D

        # TODO
        # construct the first nested loop
        # for (i = 0; i < 16; i += 1)
        #     for (j = 0; j < 8; j += 1)
        #         T[i][j] = 256 * i + j;
        
        addi    a1, x0, 16      # number of rows
        addi    a2, x0, 8       # number of columns
        addi    t1, x0, 0       # i = 0
        # beq x0, x0, COND1     # this is not needed here

loop1_i:
        addi    t2, x0, 0

loop1_j:
        slli    t3, t1, 8
        add     t3, t3, t2

        slli    t4, t1, 3
        add     t4, t4, t2
        slli    t4, t4, 2
        add     t5, s1, t4
        sw      t3, 0(t5)

        addi    t2, t2, 1
        blt     t2, a2, loop1_j

        addi    t1, t1, 1
        blt     t1, a1, loop1_i


        # This is after the initialization of T
        # print T 
        addi    a0, s1, 0
        addi    a1, x0, 16
        addi    a2, x0, 8
        jal     print_array

        # TODO
        # the second nested loop for transpose
        # Note the address of D is in s2

        # for (i = 0; i < 16; i += 1)
        #     for (j = 0; j < 8; j += 1)
        #         D[j][i] = T[i][j]

        addi    a1, x0, 16
        addi    a2, x0, 8 
        addi    t1, x0, 0       # i = 0

loop2_i:
        addi    t2, x0, 0

loop2_j:
        slli    t4, t1, 3
        add     t4, t4, t2
        slli    t4, t4, 2
        add     t5, s1, t4
        lw      t3, 0(t5)

        slli    t6, t2, 4
        add     t6, t6, t1
        slli    t6, t6, 2
        add     t0, s2, t6
        sw      t3, 0(t0)

        addi    t2, t2, 1
        blt     t2, a2, loop2_j

        addi    t1, t1, 1
        blt     t1, a1, loop2_i


        # This is after the loop
        # print D and exit
        addi    a0, s2, 0
        addi    a1, x0, 8
        addi    a2, x0, 16
        jal     print_array

exit:   addi    a7, x0, 10
        ecall

print_array: 

        addi    t0, a0, 0       # the pointer
        addi    t1, x0, 0       # i = 0

loopfi:
        addi    t2, x0, 0       # j = 0

loopfj:
        lw      a0, 0(t0)
        addi    a7, x0, 34      # 34 for hex
        ecall

        addi    a0, x0, ' '     # separate words
        addi    a7, x0, 11
        ecall

        addi    t0, t0, 4       # move to the next word

        addi    t2, t2, 1
        blt     t2, a2, loopfj

        addi    a0, x0, '\n'
        addi    a7, x0, 11
        ecall

        addi    t1, t1, 1
        blt     t1, a1, loopfi

f_ret:
        jalr    x0, ra, 0
