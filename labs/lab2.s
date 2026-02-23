#       CSE 3666 Lab 2 DIVU
#       TAG: 7e565c9c03f7747a263b

        # instructions are placed in the .text section
        .text
main:   

        # DIV examples
        # 10 // 5 = 2 r 0
        # 15 // 1 = 15 r 0
        # 100 // 3 = 33 r 1
        # read two positive integers from the console and 
        # save them in s1 and s2 

        # use system call 5 to read integers
        addi    a7, x0, 5
        ecall
        addi    s1, a0, 0       # n in s1

        addi    a7, x0, 5
        ecall
        addi    s2, a0, 0       # d in s2

        # TODO
        # Add you code here
        # compute 
        #       s3: q = n // d
        #       s4: r = n % d 
        # and print them
      
        
        addi 	t0, s2, 0
        slli  	t0, t0,16 # d<<16
        addi 	s3, x0, 0  #q = 0
        add 	s4, x0, s1 #r = n
        
        addi    s5, x0, 0  # setting i
        addi 	s6, x0, 16 # conndition for loop
      
         
Loop:
	srli 	t0, t0, 1 #d >>= 1
        slli 	s3, s3, 1 #q <<= 1
 
        #bge 	s4, s2, if # IF (r >= d) 
        bltu    s4, t0, skip
#if
	sub 	s4,s4,t0 #r -= d
	ori  	s3, s3, 1 #q |= 1
	
skip:
	addi 	s5,s5, 1 #incrementing for loop
	blt	s5, s6, Loop	


print:
	addi	a7, x0, 1
	add 	a0, s3, x0
	ecall
	
	addi 	a7, x0, 11
	addi 	a0, x0, '\n'
	ecall
	
	addi 	a7, x0, 1
	add 	a0,s4,x0
	ecall
	
	addi 	a7, x0, 11
	addi 	a0, x0, '\n'
	ecall

        # no need to change lines below
        # sys call to exit
exit:   addi    a7, x0, 10
        ecall
