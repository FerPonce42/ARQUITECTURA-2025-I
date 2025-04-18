## Fibonacci.asm

# SECCION DE INSTRUCCIONES (.text)
.text
.globl __start

__start:
la $a0, Fiboprt #pseudoinstrucción
li $v0, 4	#pseudoinstrucción
syscall
li $v0, 5	#pseudoinstrucción
syscall
addi $t8,$v0,0         # valor de teclado en $t8
li $t0,0
li $t1,1

la $a0,Fibost1	#pseudoinstrucción
li $v0,4	#pseudoinstrucción
syscall               # "La serie Fibonacci de "
addi $a0,$t8,0
li $v0,1	#pseudoinstrucción
syscall               # n
la $a0,Fibost2	#pseudoinstrucción
li $v0,4 	#pseudoinstrucción
syscall               # " terminos es: "
li $a0,1	#pseudoinstrucción
li $v0,1	#pseudoinstrucción
syscall               # 1, ...
la $a0,coma	#pseudoinstrucción
li $v0,4	#pseudoinstrucción
syscall
      li   $t4,2	#pseudoinstrucción
      beq  $t8,$0,fin
      bltz $t8,fin
loop: add  $t2,$t0,$t1  # fibonacci
      addi $a0,$t2,0  
      li $v0,1	#pseudoinstrucción
      syscall
      beq $t4,$t8,fin
      la $a0,coma	#pseudoinstrucción
      li $v0,4	#pseudoinstrucción
      syscall
      addi $t4,$t4,1
      addi $t0,$t1,0
      addi $t1,$t2,0
      
      j loop

fin:  
      la $a0,endl	#pseudoinstrucción
      li $v0,4	#pseudoinstrucción
      syscall
      li $v0,10	#pseudoinstrucción
      syscall

# SECCION DE VARIABLES EN MEMORIA (.data)
.data
Fiboprt: .asciiz "Ingresar numero de terminos:"
Fibost1: .asciiz "La serie Fibonacci de "
Fibost2: .asciiz " terminos es: "
coma:    .asciiz ", "
endl:    .asciiz "\n"