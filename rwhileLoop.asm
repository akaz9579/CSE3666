.text

main:
	addi s0,x0,0 #s0=sum=0
	addi s1 x0,0 #s1=i=0
	addi s2,x0,100 #s2=100\
	beq x0,x0,loop_check
	
loop_top:
	#i>= 100; break 
	add s0,s0,s1 #sum+=i
	addi s1,s1,1 #i+=1
loop_check:
	blt s1,s2,loop_top
	
	
while_exit:
	addi a0,x0,55
	
	