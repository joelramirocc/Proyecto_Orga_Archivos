.global draw_blocks

.data 
Str1: .byte "[TTTTTTTT]", 0
.text

;a0=>linea
;a1=>columna
;a2=>arrayPos
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
    li $v0,0
    j end_function

continue_draw:
    li $t0,3
    beq $a1,$t0,continue_draw_block
    li $t0,14
    beq $a1,$t0,continue_draw_block
    li $t0,25
    beq $a1,$t0,continue_draw_block
    li $t0,36
    beq $a1,$t0,continue_draw_block
    li $t0,47
    beq $a1,$t0,continue_draw_block
    li $t0,58
    beq $a1,$t0,continue_draw_block
    li $t0,69
    beq $a1,$t0,continue_draw_block
    li $t0,80
    beq $a1,$t0,continue_draw_block
    li $v0,0
    j end_function

continue_draw_block:
    ;leer status del bloque, si es 0 significa que esta destruido y no se debe pintar
    sll $t1, $a1,2
    add $t1,$t1,$a2
    lw $t1,0($a2)
    li $v0,1
    beq  $t1,$zero,end_function
    ;si es diferente de 0, entonces toca dibujar el bloque segun el color que le toca(1-2-3)
    ;el color representa el numero de golpes que necesita para destruirse
        move $a0,$t1
        li $v0,20
        syscall
        la $a0, Str1 
        jal printString
        li $v0,21
        syscall
        li $v0,1
end_function:
jr $ra