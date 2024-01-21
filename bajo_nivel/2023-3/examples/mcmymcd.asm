.model tiny
.code org 100h
	mostrar macro arg
		lea dx,arg
		call show
	endm
	llenado macro arg1,arg2
	s2:
		call leer
		cmp al,13
		je fin
		sub al,30
		mov arg2,al
		mul arg1,10
		add arg1,arg2
		jmp s2
	fin:
		endm
	main:
	login:
		call clear
		mostrar number1
		llenado NRO1,aux
		mostrar number2
		llenado NRO2,aux
		mostrar number3
		llenado NRO3,aux
		
	ciclo: 
		mov ah,0
		mov al,CONT
		mov bl,NRO1
		div bl
		cmp ah,0
		je parte1 
	bc:
		inc cont
		jmp ciclo

	parte1:
		mov ah,0
		mov al,CONT
		mov bl,NRO2
		div bl
		cmp ah,0
		je parte2 
		jmp bc
	parte2:
		mov ah,0
		mov al,CONT
		mov bl,NRO3
		div bl
		cmp ah,0
		je parte3 
		jmp bc
	parte3:
		mov al,cont
		mov MCM,al
		mov al,NRO1
		mov bl,NRO2
		mul bl
		mov al,NRO3
		mul bl
		mov al,MCM
		div bl 
		mov MCD,al 
		mostrar txtmcd
		mostrar MCD
		mostrar txtmcm
		mostrar MCM		
	f2:
		int 20h
	MsgBienvenido db 10,13,"**********************"
				  db 10,13,"     BIENVENIDO       "
				  db 10,13,"**********************$"
	number1 	  db 10,13,"Ingrese el primer numero$"
	number2		  db 10,13,"Ingrese el segundo numero$"
	number3		  db 10,13,"Ingrese el tercer numero$"
	txtmcm		  db 10,13,"El MCM es: $"
	txtmcd		  db 10,13,"El MCD es: $"
	NRO1		  db 0
	NRO2		  db 0
	NRO3		  db 0
	MCM			  db 0
	MCD			  db 0
	CONT		  db 0
	aux			  db 0
	
	clear:
		mov al,3
		int 21h
	ret
	leer:
		mov ah,1
		int 21h
	ret
	leerSinEcho:
		mov ah,7
		int 21h
	ret
	mostrarAsterisco:
		mov ah,2
		mov dl,'*'
		int 21h
	ret
	show:
		mov ah,9
		int 21h
	ret
	end main
	
	;CREAR UN PROGRAMA QUE SE PUEDA INGRESAR CUALQUIER CANTIDAD DE NUMEROS DE LOS CUALES SE PUEDA REALIZAR EL MCM Y MCD 
	;3-- 3 6 9 12 15
	;5-- 5 10 15
	;1 5
	;1 3