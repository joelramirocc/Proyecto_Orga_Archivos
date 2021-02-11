.global main

main:
li $a0,40
li $v0,22
syscall


;EasyASM --sc-handler ./b/libsc-plugin.so  --run easm_crt.asm principal.asm