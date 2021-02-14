.global draw_blocks

;a0=>linea
;a1=>columna
;v0=true
draw_blocks:
    li $t0,1
    beq $a0,$t0,continue_draw
    li $t0,2
    beq $a0,$t0,continue_draw
    li $t0,4
    beq $a0,$t0,continue_draw
    li $t0,5
    beq $a0,$t0,continue_draw
    li $t0,6
    beq $a0,$t0,continue_draw
    li $t0,8
    beq $a0,$t0,continue_draw
    li $t0,9
    beq $a0,$t0,continue_draw
    j end_function

continue_draw:

end_function:
jr $ra


    