## Fibonacci.asm

# SECCION DE INSTRUCCIONES (.text)
.text
.globl __start

__start:
la $a0, Fiboprt #pseudoinstrucci�n
li $v0, 4	#pseudoinstrucci�n
syscall
li $v0, 5	#pseudoinstrucci�n
syscall
addi $t8,$v0,0         # valor de teclado en $t8
li $t0,0
li $t1,1

la $a0,Fibost1	#pseudoinstrucci�n
li $v0,4	#pseudoinstrucci�n
syscall               # "La serie Fibonacci de "
addi $a0,$t8,0
li $v0,1	#pseudoinstrucci�n
syscall               # n
la $a0,Fibost2	#pseudoinstrucci�n
li $v0,4 	#pseudoinstrucci�n
syscall               # " terminos es: "
li $a0,1	#pseudoinstrucci�n
li $v0,1	#pseudoinstrucci�n
syscall               # 1, ...
la $a0,coma	#pseudoinstrucci�n
li $v0,4	#pseudoinstrucci�n
syscall
      li   $t4,2	#pseudoinstrucci�n
      beq  $t8,$0,fin
      bltz $t8,fin
loop: add  $t2,$t0,$t1  # fibonacci
      addi $a0,$t2,0  
      li $v0,1	#pseudoinstrucci�n
      syscall
      beq $t4,$t8,fin
      la $a0,coma	#pseudoinstrucci�n
      li $v0,4	#pseudoinstrucci�n
      syscall
      addi $t4,$t4,1
      addi $t0,$t1,0
      addi $t1,$t2,0
      
      j loop

fin:  
      la $a0,endl	#pseudoinstrucci�n
      li $v0,4	#pseudoinstrucci�n
      syscall
      li $v0,10	#pseudoinstrucci�n
      syscall

# SECCION DE VARIABLES EN MEMORIA (.data)
.data
Fiboprt: .asciiz "Ingresar numero de terminos:"
Fibost1: .asciiz "La serie Fibonacci de "
Fibost2: .asciiz " terminos es: "
coma:    .asciiz ", "
endl:    .asciiz "\n"