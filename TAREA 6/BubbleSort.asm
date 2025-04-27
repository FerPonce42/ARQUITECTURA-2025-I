.data
array: .word 10,9,8,7,6,5
n: .word 6    # Número de elementos del array

msg: .asciiz "\nLista ordenada: "    

.text
.globl main

main:
    # Preparar parámetros para bubble_sort
    la $a0, array          # $a0 = dirección del primer elemento
    la $a1, array
    lw $t0, n
    addi $t0, $t0, -1      # n-1
    sll $t0, $t0, 2        # (n-1) * 4 bytes
    add $a1, $a1, $t0      # $a1 = dirección del último elemento

    jal bubble_sort        # Llama a bubble_sort

    # -------------------------
    # Imprimir mensaje "Lista ordenada:"
    # -------------------------
    la $a0, msg
    li $v0, 4               # syscall para imprimir string
    syscall

    # -------------------------
    # Imprimir el array ordenado
    # -------------------------
    la $t1, array           # cargar inicio del array en $t1
    lw $t2, n               # cargar número de elementos en $t2

print_loop:
    beqz $t2, end_print     # si $t2 == 0, terminar
    lw $a0, 0($t1)          # cargar el elemento actual
    li $v0, 1               # servicio de imprimir entero
    syscall

    # Imprimir espacio
    li $a0, 32              # código ASCII del espacio ' '
    li $v0, 11              # servicio imprimir carácter
    syscall

    addi $t1, $t1, 4        # siguiente dirección
    addi $t2, $t2, -1       # disminuir contador
    j print_loop

end_print:
    # Terminar el programaaa
    li $v0, 10
    syscall

# =================================
# PROCEDIMIENTO bubble_sort
# =================================
bubble_sort:
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $s0, 0($sp)

    move $s0, $a0           # $s0 = puntero inicial (primer elemento)

outer_loop:
    move $t0, $s0           # puntero al inicio
    move $t1, $a1           # puntero al final

inner_loop:
    beq $t0, $t1, next_outer  # si llegamos al final de la pasada
    lw $t2, 0($t0)          # cargar elemento actual
    lw $t3, 4($t0)          # cargar siguiente elemento
    ble $t2, $t3, skip_swap # si está en orden, no intercambiar

    # Intercambiar elementos
    sw $t3, 0($t0)
    sw $t2, 4($t0)

skip_swap:
    addi $t0, $t0, 4        # avanzar al siguiente par
    j inner_loop

next_outer:
    addi $a1, $a1, -4       # achicar zona a ordenar
    blt $a0, $a1, outer_loop # si quedan elementos, repetir

    lw $ra, 4($sp)
    lw $s0, 0($sp)
    addi $sp, $sp, 8
    jr $ra
