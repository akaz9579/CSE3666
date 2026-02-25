#       Merge Sort

        .data                   #data segment
        .align 2
#buffer: .space 1024             #allocate space for 256 words
buffer: .words 	
        234,  39, 432, 797, 374, 595, 879, 987, 863, 661,
        679, 933, 359, 443, 849, 778, 345, 782,  75,  42,
        714, 941, 502, 506,  80, 152, 814, 437, 938, 365,
        313,  21, 488, 998, 402, 841, 495, 955, 526, 783,
        964, 534, 695, 883, 559, 754, 133, 519, 895, 754,
         63, 698,  11, 159, 691, 421, 343,  65, 161, 628,
        353, 725, 113, 862, 786, 571, 197, 306, 588, 161,
        160,  18,  71, 934, 685, 816,  92, 130,   8,  33,
        706, 150, 670, 352, 136, 712, 911,  78, 366, 530,
        170, 321, 438, 806, 393, 864, 946, 326, 449, 459,
        632,   3, 290,  15, 757, 606, 131, 916, 821,  76,
         23, 381, 583, 120, 140, 445, 523, 208, 373, 445,
        179, 773, 485, 169, 798, 500, 619, 154, 884, 404,
        111, 440, 606, 888, 564, 794, 736, 950, 734, 352,
        562, 107, 861, 929, 819,  93,  12, 618,  28, 863,
        608,  78, 455, 108, 401, 424,  73, 288, 500, 999,
        714,  69, 784, 315, 581, 136,  38, 763, 120, 975,
        300, 491, 214, 884, 367, 538, 533, 775, 614,  97,
         74,  58, 871,  37, 418, 680, 492, 966, 837, 566,
        202, 743, 540, 658, 267, 974, 669, 451, 986, 760,
        757,  11, 382, 730, 769, 270, 368, 610,  73, 315,
        120, 831, 778, 991, 253, 843, 944,  71, 543, 503,
        474, 339, 600, 884, 469, 715, 429, 193, 252, 996,
        809, 414, 495, 753, 944, 724, 217, 156,  54, 937,
        666, 364, 996, 573, 243, 394,  99, 473, 708, 865,
        931, 218, 108, 640,  74, 629

        .text                   # Code segment
main: 
        # la      s1, buffer    # address of the buffer
        lui     s1, 0x10010     # hard code the address of buffer
        addi    s2, x0, 200     # number of elements, must be 256 or less

        # call init_array() to initialize the array with random values
        # it is not being called
        # uncomment the jal below to actually call the function
        addi    a0, s1, 0
        addi    a1, s2, 0
        # jal     ra, init_array 

        # call m_sort function with proper arguments
        # we must assume a0 and a1 are changed after calling init_array
        addi    a0, s1, 0
        addi    a1, s2, 0
        jal     ra, m_sort

        # set a breakpoint here and examine the memory
Exit:   
        addi    a7, x0, 10 
        ecall 

# void init_array(int p[], int n) 
# use pseudorandom numbers to fill out the array
init_array:
        # we use pointers in this function
        # t0 is the starting address and 
        # t1 is the word address right after the array 
        addi    t0, a0, 0
        slli    t1, a1, 2       
        add     t1, t1, t0      # &p[n]

        # set the seed
        addi    a0, x0, 1010
        lui     a1, 0x3666
        addi    a7, x0, 40 
        ecall

        # syscall for rand()
        # 41 on random integer
        # 42 for bounded values. upper bound is in a1. a0 selects the generator
        # a1 and a7 are not changed in the loop
        #lui     a1, 0x100
        addi	a1, x0, 1000
        addi     a7, x0, 42

ia_loop:
        addi    a0, x0, 0
        ecall                  # a1 and a7 are set before the loop
        sw      a0, 0(t0)      # save the random value
        addi    t0, t0, 4      # move to the next word
ia_test:
        bltu    t0, t1, ia_loop 

        jalr    x0, ra, 0
#### End of init_array

####START_OF_m_sort and helper functions

# array_copy(int dst[], int src[], int n)
array_copy :
	addi	t4, x0, 0       # i = 0
ac_loop:
	slli	t0, t4, 2	# t0 = i * 4
	add	t2, t0, a1 	# compute addr of src[i]
	lw	t1, 0(t2)	
	add	t3, t0, a0	# compute addr of dst[i]
	sw	t1, 0(t3)
	addi	t4, t4, 1
	blt	t4, a2, ac_loop
        jalr    x0, ra, 0

# TODO
# copy array_merge code from lab
# implement msort function 



# array_merge(int dst[], int src1[], int n1, int src2[], int n2)
#                 a0         a1          a2      a3          a4
array_merge:

    addi    a5, x0, 0      # idst
    addi    a6, x0, 0      # i1
    addi    a7, x0, 0      # i2

am_loop1:
    bge     a6, a2, am_loop2
    bge     a7, a4, am_loop3

    slli    t3, a6, 2
    add     t3, t3, a1
    lw      t1, 0(t3)

    slli    t4, a7, 2
    add     t4, t4, a3
    lw      t2, 0(t4)

    blt     t1, t2, am_take_w1

    addi    t0, t2, 0
    addi    a7, a7, 1
    beq     x0, x0, am_write

am_take_w1:
    addi    t0, t1, 0
    addi    a6, a6, 1

am_write:
    slli    t5, a5, 2
    add     t5, t5, a0
    sw      t0, 0(t5)
    addi    a5, a5, 1
    beq     x0, x0, am_loop1

am_loop2:
    bge     a7, a4, am_exit

    slli    t3, a7, 2
    add     t3, t3, a3
    lw      t0, 0(t3)

    slli    t4, a5, 2
    add     t4, t4, a0
    sw      t0, 0(t4)

    addi    a7, a7, 1
    addi    a5, a5, 1
    beq     x0, x0, am_loop2

am_loop3:
    bge     a6, a2, am_exit

    slli    t3, a6, 2
    add     t3, t3, a1
    lw      t0, 0(t3)

    slli    t4, a5, 2
    add     t4, t4, a0
    sw      t0, 0(t4)

    addi    a6, a6, 1
    addi    a5, a5, 1
    beq     x0, x0, am_loop3

am_exit:
    jalr    x0, ra, 0


# void m_sort(int d[], int n)
# a0 = d, a1 = n
m_sort:

    addi    sp, sp, -20
    sw      ra, 16(sp)
    sw      s1, 12(sp)
    sw      s2, 8(sp)
    sw      s3, 4(sp)
    sw      s4, 0(sp)

    addi    sp, sp, -1024
    addi    s4, sp, 0      # c base

    addi    s1, a0, 0      # d
    addi    s2, a1, 0      # n

    addi    t0, x0, 1
    bge     t0, s2, ms_exit    # if n <= 1

    srai    s3, s2, 1      # n1 = n/2

    addi    a0, s1, 0
    addi    a1, s3, 0
    jal     ra, m_sort

    slli    t0, s3, 2
    add     t1, s1, t0
    sub     t2, s2, s3
    addi    a0, t1, 0
    addi    a1, t2, 0
    jal     ra, m_sort

    slli    t0, s3, 2
    add     t1, s1, t0
    sub     t2, s2, s3
    addi    a0, s4, 0
    addi    a1, s1, 0
    addi    a2, s3, 0
    addi    a3, t1, 0
    addi    a4, t2, 0
    jal     ra, array_merge

    addi    a0, s1, 0
    addi    a1, s4, 0
    addi    a2, s2, 0
    jal     ra, array_copy

ms_exit:
    addi    sp, sp, 1024

    lw      s4, 0(sp)
    lw      s3, 4(sp)
    lw      s2, 8(sp)
    lw      s1, 12(sp)
    lw      ra, 16(sp)
    addi    sp, sp, 20

    jalr    x0, ra, 0
