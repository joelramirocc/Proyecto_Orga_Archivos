.global main

.data 
Str1: .byte "texto ", 0
.text

main:
addi $sp,$sp,-4
sw $ra,0($sp)
li $v0,24
syscall
jal start_game
lw $ra,0($sp)
addi $sp,$sp,4
jr $ra

;EasyASM --sc-handler ./b/libsc-plugin.so  --run easm_crt.asm principal.asm GetBlocks.asm drawBlocks.asm drawLevel.asm start.asm

;cd Proyecto_Orga_Archivos/Proyecto/plugin_base
;pactl set-sink-volume @DEFAULT_SINK@ +10%
