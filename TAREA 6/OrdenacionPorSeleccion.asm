.data
array: .word 5, 8, 1, 3    # ejemplo de arreglo
n: .word 4                # n�mero de elementos

.text
.globl main
main:
  la $a0, array           # $a0 = direcci�n de inicio
  la $a1, array
  lw $t0, n
  addi $t0, $t0, -1
  sll $t0, $t0, 2         # n-1 elementos * 4 bytes
  add $a1, $a1, $t0       # $a1 = direcci�n del �ltimo elemento
  
  jal sort                # llama a sort

  li $v0, 10              # exit
  syscall
# ---
sort:
  beq $a0, $a1, done       # �un solo elemento? Ya est� ordenado
  jal max                  # llama a max
  lw $t0, 0($a1)           # carga el �ltimo elemento
  sw $t0, 0($v0)           # copia el �ltimo elemento a la posici�n del m�ximo
  sw $v1, 0($a1)           # mueve el m�ximo a la �ltima posici�n
  addi $a1, $a1, -4        # retrocede el puntero 'last'
  j sort                   # repite
done:
  jr $ra                   # vuelve al main
# ----
max:
  move $t1, $a0            # copia first a t1 (posici�n actual)
  lw $t2, 0($t1)           # carga el primer elemento
  move $v0, $t1            # inicialmente, la direcci�n del m�ximo
  move $v1, $t2            # inicialmente, el valor del m�ximo

loop_max:
  beq $t1, $a1, end_max    # si llegamos al final, salir
  addi $t1, $t1, 4         # avanzar al siguiente elemento
  lw $t3, 0($t1)           # cargar siguiente valor
  blt $t3, $v1, loop_max   # si t3 < v1, seguir buscando
  move $v0, $t1            # nueva direcci�n del m�ximo
  move $v1, $t3            # nuevo valor m�ximo
  j loop_max

end_max:
  jr $ra
