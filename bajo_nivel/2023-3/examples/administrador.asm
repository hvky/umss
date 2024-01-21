.model tiny
.code org 100h
	mostrar macro arg
		lea dx,arg
		call sh
	endm
	llenado macro arg1
		lea si,arg1
	t2:	
		call leer
		cmp al,13
		je t1
		mov [si],al
		inc si
		jmp t2
	t1:
	endm
	regt macro arg2,arg3
		mostrar nombre
		llenado arg2
		mostrar CI
		llenado arg3
	endm
	comparar macro arg4,arg5
		lea si,arg4
		lea di,arg5
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
		call clear
		mostrar MsgBienvenido
		mostrar cadNombre
		lea di,nombre
	s2:
		call leer
		cmp al,13
		je s1
		mov [di],al
		inc di
		jmp s2
	s1:
		mostrar cadPass
		lea di,pass
	s4:
		call leerSinEcho
		cmp al,13
		je s3
		mov [di],al
		call mostrarCaracter
		inc di
		jmp s4	
	s3:
		comparar user1,nombre
		cmp al,0
		je case1
		comparar user2,nombre
		cmp al,0
		je case2
		mostrar errorUsuario
		jmp main
	case1:
		mostrar reg1
		call leer
		cmp al,'1'
		je z1
		cmp al,'2'
		je z2
		mostrar error
		jmp case1
	z1:
		mostrar Empleado1
		mostrar CI1
		mostrar Empleado2
		mostrar CI2
		mostrar Empleado3
		mostrar CI3
	z2:
		jmp fin
	case2:
		mostrar reg2
		mostrar reg3
		mostrar reg4
		mostrar reg5
		call leer
		cmp al,'1'
		je l1
		cmp al,'2'
		je l2
		cmp al,'3'
		je l3
		cmp al,'4'
		je l4
		mostrar error
		jmp case2
	l4:
		jmp fin
	l3:
		mostrar Empleado1
		mostrar CI1
		mostrar Empleado2
		mostrar CI2
		mostrar Empleado3
		mostrar CI3
	l1:
		comparar Empleado1,buscador
		cmp al,0
		jne r1
		mostrar Empleado1
		mostrar CI1
		regt Empleado1,CI1		
	r1:
		comparar Empleado2,buscador
		cmp al,0
		jne r2
		mostrar Empleado2
		mostrar CI2
		regt Empleado2,CI2	
	r2:
		comparar Empleado3,buscador
		cmp al,0
		jne r3
		mostrar Empleado3
		mostrar CI3
		regt Empleado3,CI3	
	r3:
		mostrar noexiste
		jmp fin
	l2:	
		cmp cant,0
		jne x3
		regt Empleado3,CI3
	x3:
		cmp cant,1
		jne x4
		regt Empleado4,CI4
	x4:
		cmp cant,2
		jne x5
		regt Empleado5,CI5
	x5:
		mostrar RegistroLleno
fin:
		int 20h
	MsgBienvenido  db 10,13,"****************************"
				   db 10,13,"     INGRESO DE SISTEMA     "
				   db 10,13,"*****************************$"
	cadNombre 	   db 10,13,"Ingrese su usuario: $"
	cadPass		   db 10,13,"Ingrese su password: $"
	errorUsuario   db 10,13,"Error de usuario$"			
	reg1		   db 10,13,"DESEA VER LOS REGISTROS$"
	caso		   db 10,13,"PRESIONE 1 PARA SI"
				   db 10,13,"PRESIONE 2 PARA NO$"	
	reg2		   db 10,13,"DESEA MODIFICAR LOS REGISTROS PRESIONE 1$"
	reg3 		   db 10,13,"DESEA REGISTRA UN NUEVO EMPLEADO PRESIONE 2$"
	reg4		   db 10,13,"DESEA VER LOS REGISTROS PRESIONE 3$"
	reg5		   db 10,13,"DESEA SALIR DEL PROGRAMA PRESIONE 4$"
	error 		   db 10,13,"No es una opcion la que elegiste intete otravez$"
	RegistroLleno  db 10,13,"LA LISTA YA ESTA LLENA$"
	encontrar	   db 10,13,"Desea buscar un registro?"
	datos1		   db 10,13,"Ingrese el dato a buscar$"
	datos2		   db 10,13,"Ingrese los nuevos datos$"
	noexiste	   db 10,13,"Los datos ingresados no existen$"
	trabajador	   db 10,13,"Seleccione el registro deceado$"
	user1 		   db 'Alex',0
	user2	 	   db 'Administrador',0
	passDB1	       db 'ABCD',0
	passDB2	       db '1234',0
	nombre		   db 50 dup('$')
	pass		   db 50 dup('$')
	buscador	   db 50 dup('$')
	Empleado1	   db 50 dup('$')
	Empleado2 	   db 50 dup('$')
	Empleado3	   db 50 dup('$')
	CI1 	       db 20 dup('$')
	CI2 	       db 20 dup('$')
	CI3 	       db 20 dup('$')
	cant		   equ 0
	x 			   equ 5
	
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
		mov dl,'*'
		int 21h
	ret
	show:
		mov ah,9
		int 21h
	ret
	end main
	
;CREAR UN PROGRAMA QUE TENGA ACCESO AUN REGISTRO DE 3 PERSONAS
;DICHO PROGRAMA TIENE QUE TENER ACCESO MEDIANTE CREDENCIALES
;LOS CUALES DEBEN DE SER DE 2 TIPOS UNO QUE SOLO TENGA LECTURA DE DATOS Y EL OTRO QUE PUEDA MODIFICAR LOS DATOS
;-- NOMBRE -- CI -- CEL -- EDAD --
;2 CLASES DE USUARIOS ---- U NORMAL --- VER REGISTRO COMPLETO --- VER CASO ESPECIFICO
; 						---  U ADMINISTRADOR --- VER REGISTRO COMPLETO --- VER CASO ESPECIFICO ---- MODIFICAR CADA REGISTRO
;VARIABLE QUE ME IDENTIFIQUE EN QUE REGISTRO ESTOY
;LISTAS O CARACTER ESPECIAL