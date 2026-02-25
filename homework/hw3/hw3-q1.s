#       CSE 3666: HW3
#       Function call

        .data
        .align  2       

buf:    .word                   # 200 words
         -1, -56, -64, -26, -27, -74, -18, -90,  39,  19,
        -74, -64,  78,  85,  59, -71,  80, -63,  70,  86,
         32, -87, -53,  54,  61,  94,  99,   2, -57,  64,
        -96, -33, -57, -89, -61,  40,  49,  41, -87, -67,
         26, -11,  19,   7,   4,  68,  39,  86, -51,  20,
        -33,  99, -70, -66,  -1, -69, -63,   8, -76,  80,
         -4, -99,  21,  35, -83,  34, -62, -95, -38, -86,
         87,  -5,  85,  32,  48,  77,  31,  11, -40, -74,
          7, -57,  68,  -5,  29, -48, -93,  43, -27,  -5,
        -50, -53,  69, -88,  36, -52, -51,  74,  72,  54,
        -84, -85,  39, -54, -51,  59, -63, -24, -63, -25,
         62,  25, -33,  22,  90,   4,  90,  81, -83,  51,
          6, -90,  39,  97, -52,  76, -28,  49,  12,  -4,
         36, -13,  56,  67,  63, -61,  19,  85, -87, -47,
         81,  86,  69, -24, -35,  78, -18, -69,  20,  26,
          5, -34,  80,  82, -26,  92, -32,  88,  88, -41,
        -16, -73, -42,  97,  22,  56, -40,  90,  95, -55,
        -56,  94,  74,  48,  59, -41, -72, -53, -92,  81,
        -33,   4, -25,  36,  44, -17,  87, -91, -31,  89,
        -81,  82, -10,  55, -85, -55,  55,  87,   7,  48,

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

	# here are a few expected return values:
	#    a1   return value
	#    10   8
	#    50   24
	#   100   52
	#   200   97

        lui     a0, 0x10010     # hard code the address of buf
        addi    a1, x0, 200     # addr of src1 (dst has 256 words)

        jal     ra, foo

exit:   addi    a7, x0, 10 
        ecall

#### start of bar
bar:
        lw      t0, 0(a0)
        addi    t1, x0, 0
        bge     t0, x0, bar_ret
        sub     t0, x0, t0
        sw      t0, 0(a0)
        addi    t1, x0, 1
bar_ret:
        addi    a0, t1, 0
        jalr    x0, ra, 0
#### end of bar

#### start of foo
foo: 	
        # TODO
        # Implement foo
        # You do not need to know how bar is implemented
        
        # s1: count
        # s2: i
        #### start of foo
foo:

        addi    sp, sp, -20
        sw      ra, 16(sp)
        sw      s1, 12(sp)
        sw      s2, 8(sp)
        sw      s3, 4(sp)
        sw      s4, 0(sp)

        # a0 = d[]
        # a1 = n
       
        addi    s3, a0, 0      # s3 = base address d
        addi    s4, a1, 0      # s4 = n

        # count = 0
        addi    s1, x0, 0

        # i = 0
        addi    s2, x0, 0

loop_test:
        # if (i >= n) exit
        bge     s2, s4, loop_exit

        # &d[i]
        slli    t0, s2, 2      # t0 = 4*i
        add     t0, s3, t0     # t0 = &d[i]

        # bar(&d[i])
        addi    a0, t0, 0
        jal     ra, bar

        # a0 = return value t

        # if (t <= 0) skip increment
        ble     a0, x0, skip_inc

        addi    s1, s1, 1      # count++

skip_inc:
        addi    s2, s2, 1      # i++
        beq     x0, x0, loop_test

loop_exit:
        # return count in a0
        addi    a0, s1, 0

        lw      s4, 0(sp)
        lw      s3, 4(sp)
        lw      s2, 8(sp)
        lw      s1, 12(sp)
        lw      ra, 16(sp)
        addi    sp, sp, 20

        jalr    x0, ra, 0
