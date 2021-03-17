.global update_values
;a0= array

update_values:
    addi $sp,$sp,4
    sw $ra,0($sp)
        
    jal update_nave
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

    li $t4,0
    beq $t1,$t4,maybe_rebote_horizontal

    li $t4,1
    beq $t1,$t4,maybe_rebote_horizontal_colision

    


    ;LIMITE INFERIOR
    li $t4,11
    slt $t5,$t1,$t4
    li $t4,1
    ;t5=1 cuando es menor, continuar dibujando, si es 1, calculos
    beq $t5,$t4,move_ball_calculate
    li $t4,28
    slt $t5,$t1,$t4

    bne $t5,$zero,move_ball_default
    j move_ball_calculate_nave


update_nave:
        li $t4,56
        sll $t4,$t4,2
        add $t4,$t4,$a0
        lw $t4,0($t4)
     
    li $t0,97
    beq $a1,$t0,left_update_nave

    li $t0,100
    beq $a1,$t0,rigth_update_nave

        j end_update_nave

left_update_nave:
    addi $t5,$t4,-3
    li $t7,2
    slt $t6,$t5,$t7
    beq $t6,$zero,write_left_value
    j resolve_left_min

    resolve_left_min:
        li $t5,2
        j write_left_value

    write_left_value:
        li $t4,56
        sll $t4,$t4,2
        add $t4,$t4,$a0
        sw $t5,0($t4)
    j end_update_nave
rigth_update_nave:
    addi $t5,$t4,3
    li $t7,81
    slt $t6,$t5,$t7
    beq $t6,$zero,resolve_rigth_min
    j write_left_value

    resolve_rigth_min:
        li $t5,81
        j write_rigth_value
    write_rigth_value:
        li $t4,56
        sll $t4,$t4,2
        add $t4,$t4,$a0
        sw $t5,0($t4)
    j end_update_nave

end_update_nave:
jr $ra

move_ball_default:
    add $t5,$t1,$t2

    ;escribir fila
    li $t1,57
    sll $t1,$t1,2
    add $t1,$t1,$a0
    sw $t5,0($t1)

    ;j end_update_values
    ;2-90
    li $t4,4 
    beq $t3,$t4, move_right
    j move_left
    move_left:
        li $t4,7
        slt $t4,$t0,$t4
            beq $t4,$zero,move_default_left

                li $t4,4
                li $t3,60
                sll $t3,$t3,2
                add $t3,$t3,$a0
                sw $t4,0($t3)

                li $t4,2
                j write_columna     
            move_default_left:
                add $t4,$t0,$t3
                j write_columna
    move_right:
        li $t4,86
        slt $t4,$t0,$t4
            bne $t4,$zero,move_default_right

                li $t4,-4
                li $t3,60
                sll $t3,$t3,2
                add $t3,$t3,$a0
                sw $t4,0($t3)

                li $t4,90     
                j write_columna
            move_default_right:
                add $t4,$t0,$t3
                j write_columna


write_columna:
    ;escribir columna
    li $t0,58
    sll $t0,$t0,2
    add $t0,$t0,$a0
    sw $t4,0($t0)

continue_move_ball_default:
    j end_update_values



end_update_values:
    lw $ra,0($sp)
    addi $sp,$sp,-4
    jr $ra



move_ball_calculate_nave:

    li $t4,-1
    beq $t2,$t4,move_ball_default
     
    li $t4,56
    sll $t4,$t4,2
    add $t4,$t4,$a0
    lw $t4,0($t4)

    slt $t5, $t0,$t4
    bne $t5,$zero,leave_live

    addi $t6,$t4,10
    slt $t5, $t0,$t6
    beq $t5,$zero,leave_live


    li $t5,-1
    li $t2,59
    sll $t2,$t2,2
    add $t2,$t2,$a0
    sw $t5,0($t2)


    li $t5,27
    ;escribir fila
    li $t1,57
    sll $t1,$t1,2
    add $t1,$t1,$a0
    sw $t5,0($t1)

    ;actualizar angulo, dependiendo donde golpee el balon
    ;t4 = posicion inicial de la nave
    addi $t5,$t4,4
    slt $t5,$t0,$t5
    bne $t5,$zero,less_angle
    
    addi $t5,$t4,6
    slt $t5,$t0,$t5
    bne $t5,$zero,regular_angle

    j more_angle
    
    regular_angle:
        li $t5,0
        li $t3,60
        sll $t3,$t3,2
        add $t3,$t3,$a0
        sw $t5,0($t3)
        j continue_move_ball_calculate_nave
    less_angle:
        li $t5,-4
        li $t3,60
        sll $t3,$t3,2
        add $t3,$t3,$a0
        sw $t5,0($t3)
        j continue_move_ball_calculate_nave
    more_angle:
        li $t5,4
        li $t3,60
        sll $t3,$t3,2
        add $t3,$t3,$a0
        sw $t5,0($t3)
        j continue_move_ball_calculate_nave



    continue_move_ball_calculate_nave:
    add $t5,$t0,$t5
    li $t0,58
    sll $t0,$t0,2
    add $t0,$t0,$a0
    sw $t5,0($t0)


    j end_update_values
leave_live:
    ;obtener vidas
    li $t9,64
    sll $t9,$t9,2
    add $t9,$t9,$a0
    lw $t8,0($t9)
    addi $t8,$t8,-1
    sw $t8,0($t9)
    j end_update_values


move_ball_calculate:
;t0 columna
;t1 fila
;t2 direccion
;t3 angulo
    li $t4,10
    beq $t1,$t4,maybe_free_movement
    j end_colisions

maybe_free_movement:
    li $t4,1
    beq $t2,$t4,free_movement
    j calculate_movement

calculate_movement:
    j end_colisions

free_movement:
    j move_ball_default

end_colisions:
    j end_update_values


rebote_horizontal:
    ;t0 columna
    ;t1 fila
    ;t2 direccion
    ;t3 angulo

    ;cambio de direccion
    li $t9,-1
    mult $t2,$t9
    mflo $t4
    li $t2,59
    sll $t2,$t2,2
    add $t2,$t2,$a0
    sw $t4,0($t2)
    move $t2,$t4
    
    li $t9,7
    slt $t9,$t0,$t9
    li $t8,1
    beq $t9,$t8,maybe_left_change
    
    li $t9,86
    slt $t9,$t0,$t9
    beq $t9,$zero,maybe_right_change
    j cambio_columna


    maybe_right_change:
    li $t9,4
    beq $t3,$t9,right_change
        j cambio_columna

    right_change:
        ; cambio de angulo
        li $t9,-1
        mult $t3,$t9
        mflo $t4

        li $t3,60
        sll $t3,$t3,2
        add $t3,$t3,$a0
        sw $t4,0($t3)        
        j end_rebote_horizontal

    maybe_left_change:
    li $t9,-4
    beq $t3,$t9,left_change
        j cambio_columna

    left_change:
        ; cambio de angulo
        li $t9,-1
        mult $t3,$t9
        mflo $t4

        li $t3,60
        sll $t3,$t3,2
        add $t3,$t3,$a0
        sw $t4,0($t3)
        j end_rebote_horizontal


cambio_columna:
    ;mover columna
    add $t9,$t0,$t3
    li $t0,58
    sll $t0,$t0,2
    add $t0,$t0,$a0
    sw $t9,0($t0)
    j end_rebote_horizontal

end_rebote_horizontal:
    j end_colisions


maybe_rebote_horizontal:
    ;t2 => direccion
    li $t4,-1
    beq $t2,$t4,rebote_horizontal
    li $t4,1
    j colision_horizontal_abajo


    ;t0 columna
    ;t1 fila
    ;t2 direccion
    ;t3 angulo
    ;t4 valor a mult para obtener la colision, es necesario en viarlo al momento de llamar a la funcion de colisiones


colision_horizontal_abajo:
    li $t9,-4
    beq $t3,$t9,colision_horizontal_abajo_left
    li $t9,4
    beq $t3,$t9,colision_horizontal_abajo_rigth
    j colision_horizontal_abajo_rect


colision_horizontal_abajo_rect:

    ;ESPACIOS INTERMEDIOS
    li $t8,1
    li $t9,2
    beq $t0,$t9,move_to_column_rect
    li $t9,13
    beq $t0,$t9,move_to_column_rect
    
    slt $t9,$t0,$t9
    li $t5,0
    beq $t9,$t8,colision_to_column_rect

    li $t9,24
    beq $t0,$t9,move_to_column_rect

    slt $t9,$t0,$t9
    li $t5,1
    beq $t9,$t8,colision_to_column_rect

    li $t9,35
    beq $t0,$t9,move_to_column_rect

    slt $t9,$t0,$t9
    li $t5,2
    beq $t9,$t8,colision_to_column_rect

    li $t9,46
    beq $t0,$t9,move_to_column_rect

    slt $t9,$t0,$t9
    li $t5,3
    beq $t9,$t8,colision_to_column_rect
    
    li $t9,57
    beq $t0,$t9,move_to_column_rect

    slt $t9,$t0,$t9
    li $t5,4
    beq $t9,$t8,colision_to_column_rect
    
    li $t9,68
    beq $t0,$t9,move_to_column_rect

    slt $t9,$t0,$t9
    li $t5,5
    beq $t9,$t8,colision_to_column_rect
    
    li $t9,79
    beq $t0,$t9,move_to_column_rect

    slt $t9,$t0,$t9
    li $t5,6
    beq $t9,$t8,colision_to_column_rect
    
    li $t9,90
    beq $t0,$t9,move_to_column_rect

    slt $t9,$t0,$t9
    li $t5,7
    beq $t9,$t8,colision_to_column_rect
    
    ;ESPACIOS INTERMEDIOS FIN

    j end_maybe_rebote_horizontal_colision

colision_to_column_rect:
    mult $t4,$t5
    mflo $t8
    li $t9,4
    mult $t8,$t9
    mflo $t8

    addi $t8,$t8,4
    add $t8,$t8,$sp
    lw $t9,0($t8)
    
    beq $t9,$zero,move_to_column_rect
    addi $t9,$t9,-1 ;ACTUALIZAR PUNTOS
    sw $t9,0($t8)    
    li $t9,-1
    mult $t9,$t2
    mflo $t9

    li $t2,59
    sll $t2,$t2,2
    add $t2,$t2,$a0
    sw $t9,0($t2)

    j end_maybe_rebote_horizontal_colision

move_to_column_rect:
    li $t9,1
    add $t9,$t1,$t9
    ;actualizar fila
    li $t1,57
    sll $t1,$t1,2
    add $t1,$t1,$a0
    sw $t9,0($t1)
    move $t1,$t9 
    
    j end_maybe_rebote_horizontal_colision

colision_horizontal_abajo_left:
    j end_maybe_rebote_horizontal_colision

colision_horizontal_abajo_rigth:
    j end_maybe_rebote_horizontal_colision


maybe_rebote_horizontal_colision:
    j end_maybe_rebote_horizontal_colision
end_maybe_rebote_horizontal_colision:
    j end_colisions