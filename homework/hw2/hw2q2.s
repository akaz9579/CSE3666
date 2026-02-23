.text
main:
        # s1 = i
        # s2 = &A[0]
        # s3 = &B[0]

        addi    t2, x0, 25       # Loop counter = 100 / 4 = 25 iterations

loop4:
        # A[i], A[i+1], A[i+2], A[i+3]

        lw      t0, 0(s2)        # Load A[i]
        lw      t1, 4(s2)        # Load A[i+1]
        addi    t0, t0, 4        # A[i] + 4
        addi    t1, t1, 4        # A[i+1] + 4
        sw      t0, 0(s3)        # Store into B[i]
        sw      t1, 4(s3)        # Store into B[i+1]

        lw      t0, 8(s2)        # Load A[i+2]
        lw      t1, 12(s2)       # Load A[i+3]
        addi    t0, t0, 4        # A[i+2] + 4
        addi    t1, t1, 4        # A[i+3] + 4
        sw      t0, 8(s3)        # Store into B[i+2]
        sw      t1, 12(s3)       # Store into B[i+3]

        addi    s2, s2, 16       # Advance A pointer by 4 words (16 bytes)
        addi    s3, s3, 16       # Advance B pointer by 4 words (16 bytes)
        addi    s1, s1, 4        # i += 4

        addi    t2, t2, -1       # Decrement loop counter
        bne     t2, x0, loop4    # Repeat until 25 iterations complete


        addi    a7, x0, 10       # Exit system call
        ecall                    # Terminate program
