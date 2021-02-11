.global main

.data 
Str1: .byte "texto ", 0
.text

main:
addi $sp,$sp,-4
sw $ra,0($sp)
jal draw

lw $ra,0($sp)
addi $sp,$sp,4
jr $ra

;EasyASM --sc-handler ./b/libsc-plugin.so  --run easm_crt.asm principal.asm  drawLevel.asm