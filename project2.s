#My ID: 02876360 %11 = 3 +26 = Base 29

.data
user_input: .space 1000	   #makes 1000 spaces for the user input
endl: .asciiz "\n"	   #makes asciiz character for a new line
invalid_msg: .asciiz "Invalid input"  #makes asciiz Invalid message

.text

main:

#saved registers
la $s1, 0     #register to keep track of final output
la $s2, 0     #register to keep track of when a character is found
la $s3, 0     #register to keep track of spaces
la $s5, 0     #register to keep  track of vaalid characters before loop stops

li $v0,8 	      # takes in and reads input
la $a0, user_input    #puts the users input into the $a0 register
li $a1, 1001            #takes in 1000 spaces from the user input even though it says 1001 (NULL)
syscall

move $t0, $a0         #moves the values in the $a0 to $t0 temporary register



loop:		      #initializs loop and iterates

lb $a0 ($t0)          #load the bit for the $t0 position in $a0
addi $t0, $t0, 1       # iterates the $t0 postion in $a0
beqz $a0, end_loop    #checks if a 0 is found and if so sends it to end_loop
beq $a0, 10, end_loop #checks if a character less than 9 is found and if so sends it to end_loop
beq $a0, 32, if_space #checks if a space is found and if so sends it to if_space loop
beq $a0, 9, if_tab    #checks if a tab is found and if so sends it to if_tab loop
bne $s3, 1, filter    #if a space if found it goes to the filter loop
bne $s2, 1, filter     #if a char if found it goes to the filter loop
beq $s5, 5, invalid    #if the $s4 register is more than 5 it will jump to the invalid loop
j invalid		      #jumps to invalid loop



filter:			  #loops to filter for valid characters 
la $s2, 1    		  #iterates the $s2 to know that a char was found
blt $a0, 48, invalid	  #checks if ASCII is less than 48. If true it goes to invalid
blt $a0, 58, valid_number #checks if ASCII is less than 68. If true it goes to valid_number loop
blt $a0, 65, invalid	  #checks if ASCII is less than 48. If true it goes to invalid
blt $a0 84, valid_CAP	  #checks if ASCII is less than 68. If true it goes to valid_CAP
blt $a0 97, invalid   	  #checks if ASCII is less than 96. If true it goes to invalid
blt $a0 116, valid_low    #checks if ASCII is less than 58. If true it goes to valid_low

j invalid			  #jumps to invalid loop



end_loop:
beqz $s2, invalid    #if $s2 equals 0 it goes to invalid

j final		   # jumps to final loop



final:		#runs if the character is valid
li $v0, 4        #prints out a string
la $a0, endl    #prints the new line character making it skip a line
syscall

move $a0, $s1	#moves the values in $s1 to $a0
li $v0, 1       #prints out an integer
syscall

li $v0, 10    #exits the program
syscall




valid_number:
subu $s4, $a0, 48  #subtracts to find decimal value of char from ASCII 
addu $s1, $s1, $s4 #adds the decimal value of the character the final sum
addi $s5, $s5, 1   #increments to keep track that one valid character has been stored
j loop		   #jumps back to loop




valid_CAP:	    #checks for valid capital hexidecimal letters	
subu $s4, $a0, 55   #subtracts to find decimal value of char from ASCII 
addu $s1, $s1, $s4  #adds the decimal value of the character the final sum
addi $s5, $s5, 1   #increments to keep track that one valid character has been stored
j loop		    #jumps back to loop




valid_low:	    #checks for valid lower case hexidecimal letter
subu $s4, $a0, 87   #subtracts to find decimal value of char from ASCII 
addu $s1, $s1, $s4  #adds the decimal value of the character the final sum
addi $s5, $s5, 1   #increments to keep track that one valid character has been stored
j loop		    #jumps back to loop




if_space:		#skips  position if a space is found
 
j loop		 	#jumps back to loop


if_tab:
j loop


invalid: 	#runs if the character is invalid
li $v0, 4        #prints out a string
la $a0, invalid_msg    #prints the invalid input message
syscall

li $v0, 10    #exits the program
syscall

#subroutine area
jal subprogram
jr $ra

subprogram:

addi $sp, $sp, -4  #$sp is a stack pointer and -4 makes room in the stack to save nformation in
sw $s0 ,0($sp)	   #stores the value os $s0 into the 0th placement of the stack pointer (sp)
jr $ra



