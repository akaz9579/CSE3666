
main:
        addi    a7, x0, 5
        ecall
       
        
        add     s1, x0, a0          # n

        addi    s2, x0, 0           # steps =0
        addi    t2, x0, 1           # 

check:
        beq     s1, t2, exit       # if n = 1 

        andi    t0, s1, 1           #  n & 1
        beq     t0, x0, even        # if

odd: #else

        slli    t1, s1, 1           # 2n
        add     s1, t1, s1          # 3n
        addi    s1, s1, 1           # 3n + 1
        addi    s2, s2, 1    
        beq     x0, x0, check   

even:

        srli    s1, s1, 1     # n >> 1
        addi    s2, s2, 1          
        beq     x0, x0, check   

exit:

        add     a0, x0, s2
        addi    a7, x0, 1
        ecall
        addi    a7, x0, 10
        ecall