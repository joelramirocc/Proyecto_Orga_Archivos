; FUNCIONES BASICAS ASM

.global printString
.global printChar
.global printInt
.global readInt
.global memset

start:
    jal main
    ; exit
    li $v0, 10
    syscall

printString:
    li $v0,4
    syscall
    jr $ra

printChar:
    li $v0,11
    syscall
    jr $ra

printInt:
    li $v0,1
    syscall
    jr $ra

readInt:
    li $v0,5
    syscall
    jr $ra

memset:
    .memset_loop:
        beqz $a2, .memset_end
        sb $a1, 0($a0)
        addiu $a0,$a0,1
        addiu $a2,$a2,-1
        j .memset_loop
    .memset_end:
        jr $ra