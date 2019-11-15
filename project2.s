#My ID: 02876360 %11 = 3 +26 = Base 29

.data
user_input: .space 1000	   #makes 1000 spaces for the user input
endl: .asciiz "\n"	   #makes asciiz character for a new line
invalid_msg: .asciiz "Invalid input"  #makes asciiz Invalid message

.text

main:

#saved registers
#la $al, user_input
#li $a0, 0 #register to keep track of final output set to 0

la $s1, 0     #register to keep track of final output set to 0
la $s2, 0     #register to keep track of when a character is found
la $s3, 0     #register to keep track of spaces
la $t5, 0     #register to keep  track of the strings length
la $t3, 1     #register to keep track of exponent

li $v0,8 	      # takes in and reads input
la $a0, user_input    #puts the users input into the $a0 register
li $a1, 1001            #takes in 1000 spaces from the user input even though it says 1001 (NULL)
syscall

move $t0, $a0         #moves the values in the $a0 to $t0 temporary register

jal loop		#jumps to the loop subprogram


final:		#runs if the character is valid
li $v0, 4        #prints out a string
la $a0, endl    #prints the new line character making it skip a line
syscall

move $a0, $s1	#moves the values in $s1 to $a0
li $v0, 1       #prints out an integer
syscall

li $v0, 10    #exits the program
syscall




invalid: 	#runs if the character is invalid

li $v0, 4        #prints out a string
la $a0, endl    #prints the new line character making it skip a line
syscall

li $v0, 4        #prints out a string
la $a0, invalid_msg    #prints the invalid input message
syscall

li $v0, 10    #exits the program
syscall







loop:		      #initializes loop to find if any character is found and iterates to count entire string
lb $a0 ($t0)          #load the bit for the $t0 position in $a0
addi $t0, $t0, 1       # iterates the $t0 postion in $a0
addi $t5, $t5, 1       # iterates the $s5 register to keep track of the string length
beqz $a0, end_of_loop    #checks if the Null character is found and if so sends it to end_loop
j loop

#beq $a0, 10, end_of_loop #checks if a character less than 9 is found and if so sends it to end_loop
#beq $a0, 32, if_space #checks if a space is found and if so sends it to if_space loop
#beq $a0, 9, if_tab    #checks if a tab is found and if so sends it to if_tab loop
#bne $s3, 1, filter    #if a space if found it goes to the filter loop
#bne $s2, 1, filter     #if a char was found it goes to the filter loop

#j invalid		      #jumps to invalid loop


end_of_loop:		#after the loop runs and gets string length, this loops backwards to get the vaild values
#beqz $s2, invalid    #if $s2 equals 0 it goes to invalid
subu $t0, $t0, 1       # iterates the the position of the bit in $t0 to begin reading from the rightmost bit to the left
lb $a0 ($t0)          #load the bit for the $a0 position in $t0
beq $a0, 32, end_of_loop #checks if a space is found and if so sends back up to end loop
beq $a0, 9, end_of_loop    #checks if a tab is found and if so sends back up to end loop
j filter		   # jumps to final loop



filter:			  #loops to filter for valid characters 
#la $s2, 1    		  #iterates the $s2 to know that a char was found
blt $a0, 48, invalid	  #checks if ASCII is less than 48. If true it goes to invalid
blt $a0, 58, valid_number #checks if ASCII is less than 68. If true it goes to valid_number loop
blt $a0, 65, invalid	  #checks if ASCII is less than 48. If true it goes to invalid
blt $a0, 84, valid_CAP	  #checks if ASCII is less than 68. If true it goes to valid_CAP
blt $a0, 97, invalid   	  #checks if ASCII is less than 96. If true it goes to invalid
blt $a0, 116, valid_low    #checks if ASCII is less than 58. If true it goes to valid_low

j invalid			  #jumps to invalid  loop

valid_number:
subu $s4, $a0, 48  #subtracts to find decimal value of char from ASCII 
#addu $s1, $s1, $s4 #adds the decimal value of the character the final sum

j calculate		   #jump to calculate loop




valid_CAP:	    #checks for valid capital hexidecimal letters	
subu $s4, $a0, 55   #subtracts to find decimal value of char from ASCII 
#addu $s1, $s1, $s4  #adds the decimal value of the character the final sum

j  calculate		   #jump to calculate loop




valid_low:	    #checks for valid lower case hexidecimal letters
subu $s4, $a0, 87   #subtracts to find decimal value of char from ASCII 
#addu $s1, $s1, $s4  #adds the decimal value of the character the final sum

j  calculate		   #jump to calculate loop



#if_space:		#skips  position if a space is found
#j filter		   #jumps back to filter

#if_tab:			#skips  position if a tab is found
#j filter		   #jumps back to filter

calcuate:
li $t6, 29 		#initializes $t6 as 29 for base 29
multu $s4, $t3		#multiplies the decimal value by the exponent value
mflo $s4		#saves the lower 4 bits in the $s4 register
addu $s1, $s1, $s4	#adds the multiplied value to the sum output
multu $t3, $t6		#multiplies the exponent by base-29 	
j loop			#jump back to loop
jr $ra





