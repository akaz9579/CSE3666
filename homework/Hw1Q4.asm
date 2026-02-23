        .text
main:   
	#a, i, r are assumed to be stored in registers        
        
        addi	s2, x0, 0   #i = 0
     
        
Loop:
        andi 	s4, s2, 0xA5  #i & 0xA5
        beq 	s4, x0, else
#if
	slli 	t0, s2, 8 #i<<8
	xor 	s3, s3, t0 #r = r xor (i <<8)
	beq 	x0,x0, check
	
else:
	srai 	t0, s2, 4 #(i >>4)
	add 	s3, s3, t0 #r = r += (i >>4)
check:	
	addi 	s2, s2, 1 # i+=1 
	blt 	s2, s1, Loop #i<a
	
    
exit:   addi    a7, x0, 10
        ecall
