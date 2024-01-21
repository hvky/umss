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
			mov al,[si]
			cmp al,'$'
			je final
			cmp al,[di]
			jne comp1
			inc si
			inc di
			cmp [di],'$'
			jne siguiente
			pop cx
			inc cx
			push cx
			lea di,arg2
			jmp siguiente
		comp1:
			lea di,arg2
			inc si
			jmp siguiente
		final:
	endm
	
	main:
	login:
		call clear
		mov cx,cant
	ciclo:
		push cx
		mostrar MsgBienvenido
		mostrar cadena1
		lea di,cad1
	s2:
		call leer
		cmp al,13
		je s1
		mov [di],al
		inc di
		jmp s2
	s1:
		mostrar cadena2
		lea di,cad2
	s3:
		call leer
		cmp al,13
		je s4
		mov [di],al
		inc di
		jmp s3
	s4:
		comparar cadena1,cadena2
		pop cx
		cmp cx,0
		je s5
		add cx,30
		mov cant,cx
		mostrar SiEs
		mostrar cant
		jmp f2
	s5:
		mostrar NoEs
	f2:
		int 20h
	MsgBienvenido db 10,13,"**********************"
				  db 10,13,"     BIENVENIDO       "
				  db 10,13,"**********************$"
	cadena1		  db 10,13,"Ingrese la primera cadena: $"
	cadena2		  db 10,13,"Ingrese la segunda cadena: $"
	SiEs	      db 10,13,"La cadena SI es una subcadena$"
	NoEs		  db 10,13,"La cadena NO es una subcadena$"
	cad1		  db 50 dup('$')
	cad2		  db 50 dup('$')
	cant		  equ 0
		
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
	
;INTRODUCIR DOS CADENAS DE TALAMNERA QUE PUEDA VERIFICAR SI LA CADENA INGRESADA ES UNA SUB CADENA DE LA ANTERIOR --- 2cad ---
;Y CUANTAS VECES SE REPITE DICHA CADENA ---cant---


; "LA CASA DE PEPITO ESTA AL FRENTE"
;"A "