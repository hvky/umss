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
			cmp al,'$'
			je esIgual
			cmp al,[di]
			jne terminar
			inc di
			inc si
			jmp siguiente
		esIgual:
			xor ax,ax
			jmp fin
		terminar:
			mov al,1
		fin:
			endm
	main:
	login:
		call clear
	ciclo:
		mostrar MsgBienvenido
		mostrar opcionJuego
		call leer
		cmp al,'1'
		je inicio
		cmp al,'2'
		je f2
	inicio:
		cmp opt,'0'
		je d1
		lea di,palabra
		lea si,mostrar1
		mostrar palabraOculta
		jmp c1
	d1:
		jmp f3
	c1:
		call leerSinEcho
		cmp al,13
		je s1
		mov [di],al
		mov [si],'_'
		inc di
		inc si
		mostrarCaracter
		jmp c1
	s1:
		mostrar vidas
		mostrar opt
		mostrar mostrar1
		lea di,adivina
		call leer
		cmp al,13
		je tier1
		inc number
		mov [di],al
		jmp s2
	tier1:
		cmp number,1
		jne case1
		lea di,palabra
		lea si,adivina
		mov al,[si]
		lea si,mostrar1
	tier2:
		cmp [di],'$'
		je v1	
		cmp [di],al
		je o1:
		inc di
		inc si
		jmp tier2
	c1:
		mov [si],al
		inc si
		inc di
		inc ver
		jmp tier2
	v1:
		cmp ver,0
		je error
		mostrar mostrar1
		jmp s1
	error:
		mostrar equivocado
		mov ver,00h
		mov number,00h
		dec opt
		jmp s1
	case1:
		comparar palabra,adivina
		cmp al,0
		jne salirError
		jmp s2
	salirError:
		mostrar errorPalabra
		mov ver,0
		mov number,0
		dec opt
		jmp s1
	s2:
		mostrar victoria
		jmp f2
	f3:
		mostrar derrota
		mostrar palabra
	f2:
			int 20h
	MsgBienvenido db 10,13,"**********************"
				  db 10,13,"   JUEGO AHORCADO     "
				  db 10,13,"**********************$"
	opcionJuego   db 10,13,"DESEA INICISR EL JUEGO:"
				  db 10,13,"PRESIONE 1 PARA INICIAR"
				  db 10,13,"PRESIONE 2 PARA RECHAZAR$"
	palabraOculta db 10,13"Ingrese la apalabra para adivinar: $"
	equivocado    db 10,13,"La LETRA esta equivocada$"
	errorPalabra  db 10,13,"La PALABRA esta equivocada$"
	victoria	  db 10,13,"FELISIDADES ADIVINASTE LA PALABRA$"
	derrota		  db 10,13,"PERDISTE NO ENCONTRASTE LA PALABRA$"
	vidas		  db 10,13,"TE QUEDAN LAS SIGUIENTES OPORTUNIDADES: $"
	letra		  db 10,13,"INGRESE LA LETRA QUE CREA CORRECTA: $"
	palabra		  db 50 dup('$')
	mostrar1	  db 50 dup('$')
	adivina 	  db 20 dup('$')
	opt			  equ '5'
	number		  equ 0
	ver			  equ 0
	
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
	mostrarCaracter:
		mov ah,2
		mov dl,'_'
		int 21h
	ret
	show:
		mov ah,9
		int 21h
	ret
	end main
	
;JUEGO AHORCADO
;CATIDAD DE OPORTUNIDADES
;ADIVINAR UNA PALABRA QUE SE MUESTRE LAS LETRAS SEGUN EL ASIERTO
;MENSAJES DE VICTORIA Y DERROTA

; ITERODUCIR UNA PALABRA REAL POR TECLDO
; LA PALABRA ITERODUCIDA NO TIENE QUE MOSTRARSE EN PANTALLA
; _ _ _ _ _ _ _ _ _

;MOSTRAR EN PANTALLA EL NUMERO DE OPORTUNIDADES RESTATATES

; _ E _ E _ _ _ _ _ 
 
;TELEVISOR
;PRENSA

;DE QUE LETRA ESTA FORMADA LA PALABRA

E
;_ E _ E _ _ _ _ _

;A

;LETRA INCORRECTA TE QUEDAN 4 OPORTUNIDADES MAS

;_ E _ E _ _ _ _ _

;PALABRA INCORRECTA

;_ E _ E _ _ _ _ _

;LETRA INCORRECTA TE QUEDAN 3 OPORTUNIDADES MAS

;TELEVISOR