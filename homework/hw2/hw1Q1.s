        .text
main:
        # Assume:
        # s1 = i
        # s2 = &A[0]
        # s3 = &B[0]

loop:
        # Loop body: B[i] = A[i] + 4
        lw      t0, 0(s2)        # Load A[i] into t0
        addi    t0, t0, 4        # Add 4 to A[i]
        sw      t0, 0(s3)        # Store result into B[i]

        addi    s2, s2, 4        # Move to next element in A (4 bytes per word)
        addi    s3, s3, 4        # Move to next element in B
        addi    s1, s1, 1        # i++

        addi    t1, x0, 100      # Loop bound = 100
        blt     s1, t1, loop     # Continue loop if i < 100

        addi    a7, x0, 10       # Exit system call
        ecall                    # Terminate program
