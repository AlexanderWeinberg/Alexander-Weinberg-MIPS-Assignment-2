#My ID: 02876360 %11 = 3 +26 = Base 29

.data
user_input: .space 1000	   #makes 1000 spaces for the user input
endl: .asciiz "\n"	   #makes asciiz character for a new line
invalid: .asciiz "Invalid input"  #makes asciiz Invalid message

.text

main:

Invalid: 	#runs if the character is invalid
li $v0, 4        #prints out a string
la $a0, invalid    #prints the invalid input message
syscall



