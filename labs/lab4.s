#       CSE 3666 Lab 4
#	TAG: EEE007ACD8D766FC885C6393A526

	.data
	.align	2	
word_array:     .word
        0,   10,   20,  30,  40,  50,  60,  70,  80,  90, 
        100, 110, 120, 130, 140, 150, 160, 170, 180, 190,
        200, 210, 220, 230, 240, 250, 260, 270, 280, 290,
        300, 310, 320, 330, 340, 350, 360, 370, 380, 390,
        400, 410, 420, 430, 440, 450, 460, 470, 480, 490,
        500, 510, 520, 530, 540, 550, 560, 570, 580, 590,
        600, 610, 620, 630, 640, 650, 660, 670, 680, 690,
        700, 710, 720, 730, 740, 750, 760, 770, 780, 790,
        800, 810, 820, 830, 840, 850, 860, 870, 880, 890,
        900, 910, 920, 930, 940, 950, 960, 970, 980, 990

        # code
        .text
main:   
        # s1, s2, and s3 are set later
	addi	s0, sp, 0
	addi	s4, x0, -4
	addi	s5, x0, -5
	addi	s6, x0, -6
	addi	s7, x0, -7
	addi	s8, x0, -8
	addi	s9, x0, -9
	addi	s10, x0, -20
	addi	s11, x0, -25

        lui     s1, 0x10010      # starting addr of word_array in standard memory config
        addi    s2, x0, 100      # 100 elements in the array

        # read an integer from the console
        addi    a7, x0, 5
        ecall

        addi    s3, a0, 0       # keep a copy of v in s3
        
        # call binary search
        addi	a0, s1, 0
        addi	a1, s2, 0
        addi	a2, s3, 0
        jal	ra, binary_search

exit:   addi    a7, x0, 10      
        ecall

#### Do not change lines above
binary_search:
        addi    sp, sp, -8
        sw      ra, 4(sp)
        sw      s1, 0(sp)

        # if (n == 0)
        beq     a1, x0, n_zero

        # half = n / 2
        srai    t0, a1, 1

        # half_v = a[half]
        slli    t1, t0, 2
        add     t1, a0, t1
        lw      t2, 0(t1)

        # if (half_v == v)
        beq     t2, a2, found

        # else if (v < half_v)
        blt     a2, t2, search_left

        # else (v > half_v)
        addi    s1, t0, 1              # left = half + 1

        slli    t3, s1, 2              # byte offset = left * 4
        add     t4, a0, t3             # new base = &a[left]
        sub     t5, a1, s1             # new size = n - left

        addi    a0, t4, 0              # set new base
        addi    a1, t5, 0              # set new size
        # a2 already holds v
        jal     ra, binary_search

        blt     a0, x0, f_exit         # if (rv < 0) return rv
        add     a0, a0, s1             # rv += left
        beq     x0, x0, f_exit

search_left:
        addi    a1, t0, 0              # new size = half
        # a0 unchanged
        # a2 unchanged
        jal     ra, binary_search
        beq     x0, x0, f_exit

found:
        addi    a0, t0, 0
        beq     x0, x0, f_exit

n_zero:
        addi    a0, x0, -1

f_exit:
        lw      ra, 4(sp)
        lw      s1, 0(sp)
        addi    sp, sp, 8
        jalr    x0, ra, 0
