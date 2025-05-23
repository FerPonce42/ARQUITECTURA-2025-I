.data
msg_igual: .asciiz "Son iguales\n"
msg_diferentes: .asciiz "Son diferentes\n"
msg_menor: .asciiz "$t0 es menor que $t1\n"
msg_mayor_igual: .asciiz "$t0 es mayor o igual que $t1\n"
msg_solicitar: .asciiz "Ingresa un número: "

.text
main:
li $v0, 4
la $a0, msg_solicitar
syscall

li $v0, 5
syscall
move $t0, $v0

li $v0, 4
la $a0, msg_solicitar
syscall

li $v0, 5
syscall
move $t1, $v0

beq $t0, $t1, son_iguales
li $v0, 4
la $a0, msg_diferentes
syscall
j fin

son_iguales:
li $v0, 4
la $a0, msg_igual
syscall
j menor_que

menor_que:
slt $t2, $t0, $t1
bnez $t2, es_menor
li $v0, 4
la $a0, msg_mayor_igual
syscall
j fin

es_menor:
li $v0, 4
la $a0, msg_menor
syscall
j fin

fin:
li $v0, 10
syscall
