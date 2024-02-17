;REALIZAR UN PROGRAMA QUE PERMITA EL INGRESO DE UN CORREO ELECTRONICO
;ESTE PROGRAMA DEBE SER VALIDO PARA HOTAMIL, GMAIL Y YAHOO
;DEBE DE MOSTRAR SI LAS CREDENCIALES SON CORRECTAS O INCORRECTAS
;DEBE TENER UN MAXIMO DE 3 INTENTOS
.model tiny
.code org 100h
	mostrar macro arg
		lea dx,arg
		call show
	endm
	comparar macro arg1,arg2
		lea si,arg1
		lea di,arg2
		siguiente:
			mov al.[si]
			cmp al,0
			je esIgual
			cmp al,[di]
			jne terminar
			inc di
			inc si
			jmp siguiente
		esIgual:
			xor ax,ax ;XOR 1,0 -- 1  0,0 --- 0 AND 1,1 --- 1 X,Z --- 0 OR 1,X ---- 1  0,0 ----- 0 NOT 1 --- 0  0---1
			jmp fin
		terminar:
			mov al,1
		fin:
			endm
	main:
	login:
		call clear
		mov cx,opt
	ciclo:
		push cx
		mostrar MsgBienvenido
		mostrar cadNombre
		lea di,nombre
		C1:
			call leer
			cmp al,13
			je ter1
			cmp al,'@'
			je ter2
			mov [di],al
			inc di
			jmp C1
		ter2:
			lea di,co1
		C2:
			call leer
			cmp al,13
			je ter1
			mov [di],al
			inc di
			jmp C2
		ter1:
			mostrar cadPass
			lea di,pass
		ciclo:
			call leerSinEcho
			cmp al,13
			je ter3
			mov [di],al
			call mostrarAsterisco
			inc di
			jmp ciclo
		ter3:
			lea si,nombre
			lea di, co1
			cmp [si],'@'
			je C3
			mov [di],[si]
			inc si
			jmp ter3
		C3:
			comparar co1,nombreDb
			cmp al,0
			jne salirError
			lea si,nombre
			lea di, co1
		C5:
			cmp [si],'@'
			je C4
			inc si
			jmp C5
		C4:
			inc si
			cmp [si],'$'
			je C6
			mov [di],[si]
			inc di
			jmp C4
		C6:	
			comparar co1,co2
			cmp al,0
			je C7
			comparar co1,co3
			cmp al,0
			je C7
			comparar co1.co4
			cmp al,0
			jne salirError
		C7:
			comparar passDb,pass
			cmp al,0
			je salirCorrecto
		salirError:
			mostrar errorUsuario
			mostrar otra
			call clear
			pop cx
			dec cx
			cmp cs,0
			je fin
			push cx
			loop ciclo
		salirCorrecto:
			mostrar autorizado
			jmp f2
		fin:
			mostrar ban
		f2:
			int 20h
	MsgBienvenido db 10,13,"**********************"
				  db 10,13,"     BIENVENIDO       "
				  db 10,13,"**********************$"
	cadNombre 	  db 10,13,"Ingrese su correo: $"
	cadPass		  db 10,13"Ingrese su password: $"
	autorizado    db 10,13,"Esta autorizado para"
				  db 10,13,"Entrar al Sistema $"
	errorUsuario  db 10,13,"Error de usuario$"
	otra		  db 10,13,"Vuelva a Intentarlo$"
	ban			  db 10,13,"Usted queda BLOQUEADO$"
	nombre		  db 50 dup('$')
	pass		  db 50 dup('$')
	co1			  db 20 dup('$')
	nombreDb	  db 'Alex',0
	passDb		  db '12345',0
	co2			  db 'yahoo.com',0
	co3			  db 'hotmail.com',0
	co4			  db 'gmail.com',0
	opt			  equ 3
	
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
	
;REALIZAR UN PROGRAMA QUE PERMITA EL INGRESO DE UN CORREO ELECTRONICO
;ESTE PROGRAMA DEBE SER VALIDO PARA HOTAMIL, GMAIL Y YAHOO
;DEBE DE MOSTRAR SI LAS CREDENCIALES SON CORRECTAS O INCORRECTAS
;DEBE TENER UN MAXIMO DE 3 INTENTOS