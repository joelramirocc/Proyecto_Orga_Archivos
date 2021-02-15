.global start_game

start_game:
addi $sp,$sp,-248
;                       guardar apuntador
sw $ra,244($sp)
;                       guardar angulo inicial del balon
li $t0,2
sw $t0,240($sp)
;                       guardar direccion del balon
li $t0,1
sw $t0,236($sp)
;                       guardar posicion del arreglo
move $a0,$sp
move $s6,$sp
;                       guardar posicion en "x" de la nave
li $t0,37
sw $t0,224($sp)
;                       guardar posicion en "y" del balon
li $t0,24
sw $t0,228($sp)
;                       guardar posicion en "x" del balon
li $t0,3
sw $t0,232($sp)
;                       asignar valores iniciales de los bloques
li $a1,56
jal function_get_bloques

move $a0,$sp
jal draw

lw $ra,244($sp)
addi $sp,$sp,248
jr $ra
