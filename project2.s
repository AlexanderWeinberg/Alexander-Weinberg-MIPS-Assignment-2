#My ID: 02876360 %11 = 3 +26 = Base 29

.data
user_input: .space 1000	   #makes 1000 spaces for the user input
endl: .asciiz "\n"	   #makes asciiz character for a new line
invalid: .asciiz "Invalid input"  #makes asciiz Invalid message

.text

main:

#saved registers
la $s1, 0     #register to keep track of final output
la $s2, 0     #register to keep track of when a character is found
la $s3, 0     #register to keep track of spaces

li $v0,8 	      # takes in and reads input
la $a0, user_input    #puts the users input into the $a0 register
li $a1, 5            #takes in 4 spaces from the user input even though it says 5 (NULL)
syscall

Invalid: 	#runs if the character is invalid
li $v0, 4        #prints out a string
la $a0, invalid    #prints the invalid input message
syscall

li $v0, 10    #exits the program
syscall

