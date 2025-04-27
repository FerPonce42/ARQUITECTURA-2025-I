sort_rev:
  beq $a0, $a1, done_rev  # ¿un solo elemento? Ya está ordenado
  jal min                # llama a min (nuevo procedimiento)
  lw $t0, 0($a1)          # carga el último elemento
  sw $t0, 0($v0)          # copia el último elemento a la posición del mínimo
  sw $v1, 0($a1)          # mueve el mínimo al final
  addi $a1, $a1, -4       # retrocede el puntero
  j sort_rev
done_rev:
  jr $ra
# ----
min:
  move $t1, $a0            # copia first a t1 (posición actual)
  lw $t2, 0($t1)           # carga el primer elemento
  move $v0, $t1            # inicialmente, dirección del mínimo
  move $v1, $t2            # valor mínimo inicial

loop_min:
  beq $t1, $a1, end_min    # si llegamos al final, salir
  addi $t1, $t1, 4         # avanzar al siguiente
  lw $t3, 0($t1)           # cargar siguiente valor
  bgt $t3, $v1, loop_min   # si t3 > v1, seguir buscando
  move $v0, $t1            # nueva dirección del mínimo
  move $v1, $t3            # nuevo mínimo
  j loop_min

end_min:
  jr $ra
