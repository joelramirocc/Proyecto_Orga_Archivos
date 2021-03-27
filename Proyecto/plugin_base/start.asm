.global start_game

start_game:
addi $sp,$sp,-264


;                       guardar vidas
li $t0,2
sw $t0,256($sp)
;                       guardar puntos
li $t0,0
sw $t0,260($sp)

sw $s0,248($sp)
sw $s1,252($sp)
;                       guardar apuntador
sw $ra,244($sp)
;                       guardar angulo inicial del balon
li $t0,4
sw $t0,240($sp)
;                       guardar direccion del balon
li $t0,-1
sw $t0,236($sp)
;                       guardar posicion del arreglo
move $a0,$sp
move $s6,$sp
;                       guardar posicion en "x" de la nave
li $t0,34
sw $t0,224($sp)
;                       guardar posicion en "y" del balon
li $t0,27
sw $t0,228($sp)
;                       guardar posicion en "x" del balon
li $t0,42
sw $t0,232($sp)
;                       asignar valores iniciales de los bloques
li $a1,30
jal function_get_bloques
li $s1,0
jal principal_while

lw $ra,244($sp)
lw $s0,248($sp)
lw $s1,252($sp)
addi $sp,$sp,264
jr $ra

principal_while:
    move $t0,$sp
    addi $sp,$sp,-8
    sw $ra,0($sp)
    sw $s0,4($sp)
    move $s0,$t0
    li $v0,27
    syscall
    jal draw
    j start_while
start_while:
    lw $t9,264($sp)
    beq $t9,$zero,end_principal_while
    li $v0,29
    syscall
    li $v0,25
    syscall
    
    li $t0,112
    beq $t0,$v0,pause_state
    
    li $t0,32
    beq $t0,$v0,end_principal_while  
        j continue_while

pause_state:
    li $v0,29
    syscall

    bne $s1,$zero,no_pause
            li $s1,1
        j start_while    
no_pause:
    li $s1,0
    j start_while


continue_while:
    
    bne $s1,$zero,start_while
    move $a0,$s0
    move $a1,$v0
    li $v0,24
    syscall
    jal update_values
    
    ;li $v0,24
    ;syscall
    jal draw
    j start_while

end_principal_while:
    lw $ra,0($sp)
    lw $s0,4($sp)
    addi $sp,$sp,8
    jr $ra

    