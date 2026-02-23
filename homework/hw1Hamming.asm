	.text
	
main:
	addi 	s1, x0, 0	# s1 = 0 
	add	t0, x0, s0	# make a copy so s0 is not changed 

loop: 
	bge	t0, x0, skip	# if t0 >0, check for MSB, would be 0
	addi	s1, s1, 1	# increment for MSB = 1 
skip: 
	slli	t0, t0, 1	# shift MSB 
	bne	t0, x0, loop	#finish when all bits out 
	
	addi 	a7, x0 10 
	ecall
	

	