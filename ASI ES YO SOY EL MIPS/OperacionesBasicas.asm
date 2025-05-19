.data
    msg: .asciiz "OPERACIONES BASICAS\n"
    textosuma: .asciiz "Suma: \n"
    textresta: .asciiz "\nResta: \n"
    
    simbsuma: .asciiz" + "
    simbresta: .asciiz" - "
    simbigual: .asciiz" = "
    
.text

main:
#declaracion de variables: 
	li $t0,15
	li $t1,10
	add $t2,$t0,$t1 #oeracion.
	
	#imprimir OPERACIONES BASICAS
	la $a0,msg
	li $v0,4
	syscall
	#IMPRIMIR SUMA: 	
	la $a0,textosuma
	li $v0,4
	syscall
	
	#IMPRIMIR PRIMER VALOR
	move $a0,$t0
	li $v0,1
	syscall
	#imrpimir simbolo + 
	la $a0,simbsuma
	li $v0,4
	syscall
#IMPRIMIR SEGUNDO VALOR
	move $a0,$t1
	li $v0,1
	syscall
	#imprimir = 
	la $a0,simbigual
	li $v0,4
	syscall
	
	#resultado de la suma.
	move $a0 , $t2
	li $v0,1
	syscall
	

	#recien aqui metere a la resta: 
	
	la $a0,textresta
	li $v0,4
	syscall
	#usare los valores que ya tengo previstos.
	sub $t5, $t0,$t1#AQUI PREPARO LA OPERACION
	
	
	#IMPRIMIR PRIMER VALOR
	move $a0,$t0
	li $v0,1
	syscall
	#llamar a simbolo resta:
	la $a0, simbresta
	li $v0,4
	syscall
	#IMPRIMIR 2d VALOR
	move $a0,$t1
	li $v0,1
	syscall
	#llamar a simbolo igual= 
	la $a0, simbigual
	li $v0,4
	syscall
	
	#resulado de resta a imprimir: 
	move $a0,$t5
	li $v0, 1
	syscall
	
	
	
	
	
	
	