.global draw

;la $a0, str1 
;Jal print_str

.data 
Str1: .byte "texto ", 0
str1: .byte "===========================================================================================================================", 0

str2: .byte "          PLAYER 1          ||", 0
str3: .byte "                            ||", 0
str4: .byte "    ____________________    ||", 0
str5: .byte "   |       SCORE        |   ||", 0
str6: .byte "   |     0000000000     |   ||", 0
str7: .byte "   |      LIVES:04      |   ||", 0
str8: .byte "   |      ROUND:01      |   ||", 0
str9: .byte "   |____________________|   ||", 0
.text

;vertical = t0,t1
;horizontal=t1,t2
;horizontal extra = t3,t4

draw:
addi $sp,$sp,-232
addi $t9,$sp,228
#show  $t9
sw $ra,228($sp)
move $a0,$sp
move $s6,$sp
li $t0,37
sw $t0,224($sp)
li $a1,56
jal function_get_bloques
li $a0,9
li $v0,20
syscall
la $a0, str1 
jal printString

li $v0,21
syscall

li $a0,10
jal printChar

jal vertical_draw

lw $ra,228($sp)
addi $sp,$sp,232
jr $ra

vertical_draw:
li $s0,0
li $s1,30
for_vertical_draw:
slt $s2,$s0,$s1

beq $s2,$zero,end_for_vertical_draw
	j horizontal_draw

    continueDraw:
	addi $s0,$s0,1
	j for_vertical_draw	

end_for_vertical_draw:
	j end_draw
	
end_draw:

addi $sp,$sp,-4
sw $ra,0($sp)

    li $a0,9
    li $v0,20
    syscall
    la $a0, str1 
    jal printString
    li $v0,21
    syscall

li $a0,10
jal printChar

lw $ra,0($sp)
addi $sp,$sp,4

jr $ra


horizontal_draw:
li $s2,0
li $s3,93
li $t6,1

for_horizontal_draw:	
	slt $s4,$s2,$s3
	beq $s4,$zero,end_for_horizontal_draw
		base:
            li $t5,2
			slt $s4,$s2,$t5
			beq $s4,$zero,NoBase
                addi $sp,$sp,-4
                sw $ra,0($sp)

                    li $a0,9
                    li $v0,20
                    syscall
                    li $a0,124
                    jal printChar                
                    li $v0,21
                    syscall

                lw $ra,0($sp)
                addi $sp,$sp,4
				j EndBase
		NoBase:
			li $t5,91
			bne $s2,$t5,NoBase2
                
                addi $sp,$sp,-4
                sw $ra,0($sp)

                    li $a0,7
                    li $v0,20
                    syscall
                    li $a0,124
                    jal printChar
                    li $v0,21
                    syscall

                lw $ra,0($sp)
                addi $sp,$sp,4

				j EndBase
		NoBase2:
			li $t5,92
			bne $s2,$t5,NoBase3
                
                addi $sp,$sp,-4
                sw $ra,0($sp)

                    li $a0,7
                    li $v0,20
                    syscall
                    li $a0,124
                    jal printChar
                    li $v0,21
                    syscall
                lw $ra,0($sp)
                addi $sp,$sp,4

				j EndBase
		NoBase3:
				li $a0,32
                addi $sp,$sp,-4
                sw $ra,0($sp)
                move $a0,$s0
                move $a1,$s2
                move $a2,$s6
                jal draw_blocks
                lw $ra,0($sp)
                addi $sp,$sp,4
                move $t7,$v0
                bne $t7,$zero,found_block
                addi $sp,$sp,-4
                sw $ra,0($sp)
                li $a0,32
                jal printChar
                lw $ra,0($sp)
                addi $sp,$sp,4
                j EndBase
            found_block:
                addi $s2,$s2,9
                j EndBase
        EndBase:
			addi $s2,$s2,1
			j for_horizontal_draw	
end_for_horizontal_draw:
	j horizontal_extra_draw


horizontal_extra_draw:	

    li $t6,6
    beq $s0,$t6,drawTitle

    li $t6,8
    beq $s0,$t6,drawLine

    li $t6,9
    beq $s0,$t6,drawScore

    li $t6,10
    beq $s0,$t6,drawScorePoints

    li $t6,11
    beq $s0,$t6,drawLives

    li $t6,12
    beq $s0,$t6,drawPoints
    
    li $t6,13
    beq $s0,$t6,drawEndLine

    continueDrawExtra:
    addi $sp,$sp,-4
    sw $ra,0($sp)
    
        li $a0,9
        li $v0,20
        syscall
        la $a0, str3 
        jal printString
        li $v0,21
        syscall

    lw $ra,0($sp)
    addi $sp,$sp,4


end_horizontal_extra_draw:

    li $a0,10
    addi $sp,$sp,-4
    sw $ra,0($sp)
    jal printChar
    lw $ra,0($sp)
    addi $sp,$sp,4

j continueDraw

drawTitle:
addi $sp,$sp,-4
sw $ra,0($sp)

    li $a0,9
    li $v0,20
    syscall
    la $a0, str2 
    jal printString
    li $v0,21
    syscall
lw $ra,0($sp)
addi $sp,$sp,4
j end_horizontal_extra_draw

drawLine:
addi $sp,$sp,-4
sw $ra,0($sp)

    li $a0,9
    li $v0,20
    syscall
    la $a0, str4 
    jal printString
    li $v0,21
    syscall
lw $ra,0($sp)
addi $sp,$sp,4
j end_horizontal_extra_draw

drawScore:
addi $sp,$sp,-4
sw $ra,0($sp)

    li $a0,9
    li $v0,20
    syscall
    la $a0, str5 
    jal printString
    li $v0,21
    syscall
lw $ra,0($sp)
addi $sp,$sp,4
j end_horizontal_extra_draw

drawScorePoints:
addi $sp,$sp,-4
sw $ra,0($sp)

    li $a0,9
    li $v0,20
    syscall
    la $a0, str6 
    jal printString
    li $v0,21
    syscall
lw $ra,0($sp)
addi $sp,$sp,4
j end_horizontal_extra_draw


drawLives:
addi $sp,$sp,-4
sw $ra,0($sp)

    li $a0,9
    li $v0,20
    syscall
    la $a0, str7
    jal printString
    li $v0,21
    syscall
lw $ra,0($sp)
addi $sp,$sp,4
j end_horizontal_extra_draw


drawPoints:
addi $sp,$sp,-4
sw $ra,0($sp)

    li $a0,9
    li $v0,20
    syscall
    la $a0, str8
    jal printString
    li $v0,21
    syscall
lw $ra,0($sp)
addi $sp,$sp,4
j end_horizontal_extra_draw

drawEndLine:
addi $sp,$sp,-4
sw $ra,0($sp)

    li $a0,9
    li $v0,20
    syscall
    la $a0, str9
    jal printString
    li $v0,21
    syscall
lw $ra,0($sp)
addi $sp,$sp,4
j end_horizontal_extra_draw