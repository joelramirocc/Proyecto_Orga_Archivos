.global update_values
;a0= array

update_values:
    addi $sp,$sp,4
    sw $ra,0($sp)

    ;obtener columna
    li $t0,58
    sll $t0,$t0,2
    add $t0,$t0,$a0
    lw $t0,0($t0)

    ;obtener fila
    li $t1,57
    sll $t1,$t1,2
    add $t1,$t1,$a0
    lw $t1,0($t1)
    
    ;obtener direccion
    li $t2,59
    sll $t2,$t2,2
    add $t2,$t2,$a0
    lw $t2,0($t2)
    
    ;obtener angulo
    li $t3,60
    sll $t3,$t3,2
    add $t3,$t3,$a0
    lw $t3,0($t3)

    ;10-28
    ;$t0-$t3

    li $t4,12
    slt $t5,$t0,$t4
    li $t4,1
    ;t5=1 cuando es menor, continuar dibujando, si es 1, calculos
    beq $t5,$t4,move_ball_calculate
    li $t4,26
    slt $t5,$t0,$t4
    #show $t0
    #show $t4 
    #show $t5
    beq $t5,$zero,move_ball_default
    j move_ball_calculate

move_ball_calculate:
    j end_update_values

move_ball_default:
    addi $t4,$t0,4
    add $t5,$t1,$t2

    ;obtener columna
    li $t0,58
    sll $t0,$t0,2
    add $t0,$t0,$a0
    sw $t4,0($t0)

    ;obtener fila
    li $t1,57
    sll $t1,$t1,2
    add $t1,$t1,$a0
    sw $t5,0($t1)
    


    j end_update_values



end_update_values:
    lw $ra,0($sp)
    addi $sp,$sp,-4
    jr $ra