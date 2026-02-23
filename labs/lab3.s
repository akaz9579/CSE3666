#       CSE 3666: Lab 3 Array merge
#       Merge two sorted arrays
#       TAG: 76906aa2dda6abea5263

        .data
        .align  2       
        # allocate space for 256 words
dst: .space 1024

src1:   .word                   # 100 words
        -50, -40, -20,  -5,  10,  30,  60,  70,  80,  90,
        100, 110, 120, 130, 140, 150, 160, 170, 180, 190,
        200, 210, 220, 230, 240, 250, 260, 270, 280, 290,
        301, 310, 326, 330, 340, 350, 360, 370, 380, 390,
        400, 410, 420, 430, 440, 450, 460, 470, 480, 490,
        500, 510, 520, 530, 540, 550, 560, 570, 580, 590,
        600, 610, 620, 630, 640, 650, 660, 670, 680, 690,
        700, 710, 720, 730, 740, 750, 760, 770, 780, 790,
        800, 810, 820, 830, 840, 850, 860, 870, 880, 890,
        900, 910, 920, 930, 940, 950, 960, 970, 980, 990

src2:   .word
        -98, -76, -61, -45, -30, -24, -20, -15,  -4,  -1,
         24,  37,  77,  79,  86, 100, 102, 115, 118, 124,
        129, 130, 133, 154, 170, 186, 188, 197, 211, 228,
        237, 251, 257, 263, 272, 275, 278, 290, 300, 304,
        328, 329, 330, 344, 368, 371, 373, 379, 384, 385,
        400, 404, 408, 409, 413, 424, 441, 449, 451, 457,
        475, 484, 494, 496, 512, 528, 529, 536, 545, 546,
        549, 555, 567, 568, 573, 606, 619, 625, 637, 653,
        659, 681, 686, 693, 712, 716, 724, 730, 756, 780,
        783, 790, 847, 854, 857, 913, 948, 958, 970, 975

        # code
        .text
main:   
        # help to check if any saved registers are changed during the function call
        # could add more...
        addi    s0, sp, 0
        addi    s1, x0, -1
        addi    s2, x0, -1
        addi    s3, x0, -1
        addi    s4, x0, -1
        addi    s5, x0, -1
        addi    s6, x0, -1
        addi    s7, x0, -1
        addi    s8, x0, -1
        addi    s9, x0, -1

        # read integers from the console for testing
        # read number of words in src1
        addi    a7, x0, 5
        ecall
        addi    a2, a0, 0

        # read number of words in src2
        addi    a7, x0, 5
        ecall
        addi    a4, a0, 0

        lui     a0, 0x10010     # hard code the address of dst
        addi    a1, a0, 1024    # addr of src1 (dst has 256 words)
        addi    a3, a1, 400     # addr of src2 (src1 has 100 words)

        jal     ra, array_merge

exit:   addi    a7, x0, 10 
        ecall

#### start of array_merge
# array_merge(int dst[], int src1[], int n1, int src2[], int n2)
#                 a0         a1          a2      a3          a4
# merge two sorted arrays src1 and src2 into array dst
# n1: number of words in src1
# n2: number of words in src2
array_merge:

        # initialize 3 indexes
        addi    a5, x0, 0  	# idst
        addi    a6, x0, 0  	# i1
        addi    a7, x0, 0  	# i2
        
loop1:
        # if i1 >= n1, go to loop2
        bge     a6, a2, loop2
        # if i2 >= n2, go to loop3
        bge     a7, a4, loop3

        # w1 = src1[i1]
        slli    t3, a6, 2
        add     t3, t3, a1
        lw      t1, 0(t3)

        # w2 = src2[i2]
        slli    t4, a7, 2
        add     t4, t4, a3
        lw      t2, 0(t4)

        # if w1 < w2
        blt     t1, t2, take_w1

        # take w2
        addi    t0, t2, 0
        addi    a7, a7, 1
        beq     x0, x0, write_dst

take_w1:
        addi    t0, t1, 0
        addi    a6, a6, 1

write_dst:
        slli    t5, a5, 2
        add     t5, t5, a0
        sw      t0, 0(t5)
        addi    a5, a5, 1
        beq     x0, x0, loop1

loop2:
        # copy remaining elements of src2
        bge     a7, a4, f_exit

        slli    t3, a7, 2
        add     t3, t3, a3
        lw      t0, 0(t3)

        slli    t4, a5, 2
        add     t4, t4, a0
        sw      t0, 0(t4)

        addi    a7, a7, 1
        addi    a5, a5, 1
        beq     x0, x0, loop2

loop3:
        # copy remaining elements of src1
        bge     a6, a2, f_exit

        slli    t3, a6, 2
        add     t3, t3, a1
        lw      t0, 0(t3)

        slli    t4, a5, 2
        add     t4, t4, a0
        sw      t0, 0(t4)

        addi    a6, a6, 1
        addi    a5, a5, 1
        beq     x0, x0, loop3

        

        # Do not change the lines below 
f_exit:
        jalr    x0, ra, 0
