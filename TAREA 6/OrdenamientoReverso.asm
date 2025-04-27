sort_rev:
  beq $a0, $a1, done_rev  # �un solo elemento? Ya est� ordenado
  jal min                # llama a min (nuevo procedimiento)
  lw $t0, 0($a1)          # carga el �ltimo elemento
  sw $t0, 0($v0)          # copia el �ltimo elemento a la posici�n del m�nimo
  sw $v1, 0($a1)          # mueve el m�nimo al final
  addi $a1, $a1, -4       # retrocede el puntero
  j sort_rev
done_rev:
  jr $ra
# ----
min:
  move $t1, $a0            # copia first a t1 (posici�n actual)
  lw $t2, 0($t1)           # carga el primer elemento
  move $v0, $t1            # inicialmente, direcci�n del m�nimo
  move $v1, $t2            # valor m�nimo inicial

loop_min:
  beq $t1, $a1, end_min    # si llegamos al final, salir
  addi $t1, $t1, 4         # avanzar al siguiente
  lw $t3, 0($t1)           # cargar siguiente valor
  bgt $t3, $v1, loop_min   # si t3 > v1, seguir buscando
  move $v0, $t1            # nueva direcci�n del m�nimo
  move $v1, $t3            # nuevo m�nimo
  j loop_min

end_min:
  jr $ra
