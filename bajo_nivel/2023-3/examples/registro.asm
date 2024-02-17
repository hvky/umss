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
	s3:
		mostrar opcionRegistro
		cmp al,'1'
		je s1
		cmp al,'2'
		je s2
		mostrar error
		jmp s3
	s2:
		jmp c3
	s1:
		cmp cant,5
		jne x1
		regt Empleado1,CI1
	x1:
		cmp cant,4
		jne x2
		regt Empleado2,CI2
	x2:
		cmp cant,3
		jne x3
		regt Empleado3,CI3
	x3:
		cmp cant,2
		jne x4
		regt Empleado4,CI4
	x4:
		cmp cant,1
		jne x5
		regt Empleado5,CI5
	x5:
		mostrar RegistroLleno
	c3:
		mostrar encontrar
		cmp al,'8'
		je c1
		cmp al,'9'
		je c2
		mostrar error
		jmp c3
	c2:
		jmp reg1
	c1:
		mostrar datos
		llenado buscador
		lea di,buscador
		cmp [di],'0'
		jb y1
		cmp [di],'9'
		ja y1
		jmp y2
	y1:
		comparar Empleado1,buscador
		cmp al,0
		jne r1
		mostrar Empleado1
		mostrar CI1
		mostrar asis1
	r1:
		comparar Empleado2,buscador
		cmp al,0
		jne r2
		mostrar Empleado2
		mostrar CI2
		mostrar asis2
	r2:
		comparar Empleado3,buscador
		cmp al,0
		jne r3
		mostrar Empleado3
		mostrar CI3
		mostrar asis3
	r3:
		comparar Empleado4,buscador
		cmp al,0
		jne r4
		mostrar Empleado4
		mostrar CI4
		mostrar asis4
	r4:
		comparar Empleado5,buscador
		cmp al,0
		jne r5
		mostrar Empleado5
		mostrar CI5
		mostrar asis5
	r5:
		mostrar noexiste
		jmp c1
	y2:
		comparar CI1,buscador
		cmp al,0
		jne r1
		mostrar Empleado1
		mostrar CI1
		mostrar asis1
	r1:
		comparar CI2,buscador
		cmp al,0
		jne r2
		mostrar Empleado2
		mostrar CI2
		mostrar asis2
	r2:
		comparar CI3,buscador
		cmp al,0
		jne r3
		mostrar Empleado3
		mostrar CI3
		mostrar asis3
	r3:
		comparar CI4,buscador
		cmp al,0
		jne r4
		mostrar Empleado4
		mostrar CI4
		mostrar asis4
	r4:
		comparar CI5,buscador
		cmp al,0
		jne r5
		mostrar Empleado5
		mostrar CI5
		mostrar asis5
	r5:
		mostrar noexiste
		jmp c1
	reg1:
		mostrar trabajador
		call leer
		cmp al,31
		jb d1
		cmp al,35
		ja d1
		jmp d2
	d1:
		mostrar error
		jmp reg1
	d2:
		mov layer,al
		cmp layer,31
		jne q1
		lea si,asis1
		mostrar Registro
		call leer
		add si,work
		mov [si],al
		jmp tmr
	q1:
		cmp layer,32
		jne q2
		lea si,asis2
		mostrar Registro
		call leer
		add si,work
		mov [si],al
		jmp tmr
	q2:
		cmp layer,33
		jne q3
		lea si,asis3
		mostrar Registro
		call leer
		add si,work
		mov [si],al
		jmp tmr	
	q3:
		cmp layer,34
		jne q4
		lea si,asis4
		mostrar Registro
		call leer
		add si,work
		mov [si],al
		jmp tmr
	q4:
		lea si,asis5
		mostrar Registro
		call leer
		add si,work
		mov [si],al
	tmr:
		inc work
		mostrar asist
		call leer
		cmp al,31
		je cont
		cmp al,32
		je fin
	cont:
		cmp cant,31
		ja see
		lea si,asis1
	laos:
		cmp [si],'A'
		jne ret1
		cmp [si],'$'
		je f2
		inc A
		inc si
		jmp laos
	ret1:
		cmp [si],'R'
		jne fal1
		inc R
		cmp R,5
		jb to1
		inc F
		mov R,0
		cmp F,3
		je des1
	to1:
		inc si
		jmp laos
	fal1:
		inc F
		cmp F,3
		je des1
		jmp laos
	des1:
		mostrar despido	
		jmp fin
	f2:		
		mostrar A
		mostrar R
		mostrar F
	fin:
		int 20h
	MsgBienvenido  db 10,13,"****************************"
				   db 10,13,"   REGISTRO DE EMPLEADOS    "
				   db 10,13,"*****************************$"
	opcionRegistro db 10,13,"DESEA REGISTRA UN NUEVO EMPLEADO:"
				   db 10,13,"PRESIONE 1 PARA SI"
				   db 10,13,"PRESIONE 2 PARA NO$"
	error 		   db 10,13,"No es una opcion la que elegiste intete otravez$"
	RegistroLleno  db 10,13,"LA LISTA YA ESTA LLENA$"
	Registro	   db 10,13,"Ingrese el registro de asistencia$"
	nombre		   db 10,13,"Ingrese el nombre del empleado: $"
	CI		 	   db 10,13,"Ingrese la cedula del empleado: $"
	encontrar	   db 10,13,"Desea buscar un registro?"
				   db 10,13,"PRESIONE 8 PARA SI"
				   db 10,13,"PRESIONE 9 PARA NO$"
	datos		   db 10,13,"Ingrese el dato a buscar$"
	asist		   db 10,13,"Desea ver la sistencia del mes"
				   db 10,13,"PRESIONE 1 PARA SI"
				   db 10,13,"PRESIONE 2 PARA NO$"
	noexiste	   db 10,13,"Los datos ingresados no existen$"
	trabajador	   db 10,13,"Seleccione el registro deceado$"
	retrasos	   db 10,13,"Los retrasos en el mas son: $"
	faltas		   db 10,13,"Las faltas en el mas son: $"
	despido		   db 10,13,"EL EMPLEADO ESTA DESPEDIDO$"
	buscador	   db 50 dup('$')
	Empleado1	   db 50 dup('$')
	Empleado2 	   db 50 dup('$')
	Empleado3	   db 50 dup('$')
	Empleado4 	   db 50 dup('$')
	Empleado5 	   db 50 dup('$')
	CI1 	       db 20 dup('$')
	CI2 	       db 20 dup('$')
	CI3 	       db 20 dup('$')
	CI4 	       db 20 dup('$')
	CI5 	       db 20 dup('$')
	asis1		   db 40 dup('$')
	asis2		   db 40 dup('$')
	asis3		   db 40 dup('$')
	asis4		   db 40 dup('$')
	asis5		   db 40 dup('$')
	cant 		   equ 5
	work 		   equ 0
	layer		   equ 0
	F			   equ 0
	R			   equ 0
	D			   equ 0
	A			   equ 0
	
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
	
	
;CREAR UNA TABLA DE REGISTRO DE PRESENCIA PARA UN MAXIMO DE 5 OBREROS ---- nombre --- CI  5 OBREROS
;DICHA TABLA DEBE PERMITIRME REGISTRAR LA LLEGADA DE LOS OBREROS SI FALTARON, SE RETRASARON O LLEGARON A TIEMPO --- F -- R --- A
;EL TIEMPO DE REGISTRO ES DE TODO UN MES, AL FINAL ME DEBE DE DECIR LOS DESCUENTOS DE LOS OBREROS --- 30 DIAS DE TRABAJO ---MOSTRAR REGISTRO
;CONSIDERANDO QUE 5 RETRASOS ES IGUALA A UNA FALTA Y 3 FALTAS ES UN DESPIDO ---- D 5R = F --- 3F = D

;DEBE EN LIMITAR 3 QUE NO DEBE PASAR 5
;F R T ----------   5R = F   3F = DESPIDO
;0.3 --- 0.6 
;0.3 --- 0.06
