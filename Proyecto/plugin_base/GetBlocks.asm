.global function_get_bloques
;a0 =>array
;a1 =>size

function_get_bloquess:
#show $a0
jr $ra

function_get_bloques:
    li $t0,0
    for_main:
        slt $t1,$t0,$a1
        beq $t1,$zero,end_for
            li $v0,22
            syscall
            ;move $t2,$v0
            li $t2,3
            sll $t3,$t0,2
            add $t3,$t3,$a0
            sw $t2,0($t3)
            addi $t0,$t0,1
            j for_main
    end_for:
        jr $ra
