.text
.globl __start
__start:
la $a0, prm1
li $v0,4
syscall

la $a0, orig
li $v0,4
syscall

la $s0, orig         # Dirección base de la cadena
li $t0,0             # Contador / offset
li $t2,1             # Se simula que ya se leyó un espacio
li $t3,0
li $t4,0
li $t6, 0x20         # ASCII de espacio
li $t7, 0x61         # ASCII 'a'
li $t8, 0x7a         # ASCII 'z'

add $t0, $t0, $s0    # $t0 = dirección actual de recorrido

loop:
  lb $t1, 0($t0)             # Leer byte actual
  beq $t1,$zero,endLoop      # Si es null, fin del texto

  slt $t3,$t1,$t7            # t3 = 1 si t1 < 'a'
  slt $t4,$t8,$t1            # t4 = 1 si t1 > 'z'
  or  $t3,$t3,$t4            # t3 = 1 si no está en rango minúsculas

  beq $t2,$zero, nospace     # Si antes no se leyó espacio, no hacer nada
  bne $t3,$zero, nospace     # Si no es minúscula, tampoco hacer nada

  addi $t1,$t1,-32           # Convertir a mayúscula
  sb   $t1,0($t0)            # Guardar cambio

nospace:
  bne $t1,$t6, nospacenow    # Si no es espacio, poner $t2 = 0
  li $t2, 1
  j endspace

nospacenow:
  li $t2, 0

endspace:
  addi $t0,$t0,1             # Avanzar al siguiente carácter
  j loop

endLoop:
  la $a0, prm2
  li $v0,4
  syscall

  la $a0, orig
  li $v0,4
  syscall

  li $v0, 10
  syscall

.data
orig: .asciiz "la cadena original con letras todas minusculas"
prm1: .asciiz "Original: "
prm2: .asciiz "\nUpcased : "
