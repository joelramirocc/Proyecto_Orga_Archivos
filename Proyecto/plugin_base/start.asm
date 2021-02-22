.global start_game

start_game:
addi $sp,$sp,-248
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
li $t0,37
sw $t0,224($sp)
;                       guardar posicion en "y" del balon
li $t0,26
sw $t0,228($sp)
;                       guardar posicion en "x" del balon
li $t0,24
sw $t0,232($sp)
;                       asignar valores iniciales de los bloques
li $a1,56
jal function_get_bloques

jal principal_while

lw $ra,244($sp)
addi $sp,$sp,248
jr $ra

principal_while:
    move $t0,$sp
    addi $sp,$sp,-8
    sw $ra,0($sp)
    sw $s0,4($sp)
    move $s0,$t0
    li $v0,27
    syscall
    j start_while

start_while:

    move $a0,$s0
    li $v0,24
    syscall
    jal update_values
    jal draw
    li $v0,24
    syscall
    li $v0,25
    syscall
    li $t0,32 
    beq $t0,$v0,end_principal_while
    j start_while

end_principal_while:
    lw $ra,0($sp)
    lw $s0,4($sp)
    addi $sp,$sp,8
    jr $ra