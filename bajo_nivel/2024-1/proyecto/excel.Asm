format PE GUI 4.0
entry inicio

include 'c:/fasm/include/Win32ax.inc'


; ********************     CONSTANTES     ********************
main									= 1
casilla_seleccionada	= 1001
btn_cancelar					= 1004
btn_confirmar					= 1005
btn_func							= 1006
input_expresion				= 1007
A1										= 1040
L20										= 1279


; ********************     MACROS     ********************
macro copiar orig,dest {
	invoke SendDlgItemMessage,[pWnd],orig,WM_GETTEXT,0FFh,buffer
	invoke SendDlgItemMessage,[pWnd],dest,WM_SETTEXT,0,buffer
}

macro esPrefijo cadX,cadY,dest {
	local while,is,not_is
	mov esi,cadX
	mov edi,cadY

	while:
		cmp byte[edi],0
		je not_is
		cmp byte[esi],0
		je is
		mov al,[esi]
		cmp al,[edi]
		jne not_is
		inc esi
		inc edi
		jmp while

	is:
		jmp dest
	not_is:
}

macro limpiarRegistro reg,size {
	push ecx edi eax
	mov ecx, size
	mov edi, reg
	xor eax, eax
	rep stosb
	pop eax edi ecx
}

macro searchN x,data,n {
	local while,while_2,next,no_esta,esta,end
	push esi ecx edi
	mov esi,data
	dec esi

	while:
		inc esi
		mov ecx,n
		mov edi,x

	while_2:
		cmp byte[esi],0
		je no_esta
		cmp byte[esi],1
		je while
		mov al,byte[edi]
		cmp byte[esi],al
		jne next
		inc edi
		inc esi
		loop while_2

		cmp byte[esi],1
		je esta
		cmp byte[esi],0
		je esta
		jmp next

	esta:
		mov eax,1
		jmp end
	next:
		cmp byte[esi],1
		je while
		cmp byte[esi],0
		je no_esta
		inc esi
		jmp next
	no_esta:
		mov eax,0
	end:
		pop edi ecx esi
}

macro obtenerId cad {
	push edi esi ebx ecx
	mov esi,cad
	xor ebx,ebx
	mov bl,byte[esi]
	sub bl,'a'

	inc esi
	cinvoke sscanf,esi,'%d',edi
	mov eax,dword[edi]
	mov ecx,12
	mul ecx
	add eax,ebx
	add eax,1028
	pop ecx ebx esi edi
}


; ********************     CODIGO     ********************
section '.code' code readable executable

inicio:
	invoke GetModuleHandle,0
	mov [Ist],eax
	invoke DialogBoxParam,eax,main,0,DlgProc,0 
fin:
	invoke ExitProcess,0


; ********************     PROCEDIMIENTOS     ********************
proc DlgProc,hWnd,uMsg,wParam,lParam
	push edi esi ebx

	mov eax,[uMsg]
	cmp	eax,WM_COMMAND
	je	jCOMMAND
	cmp	eax,WM_INITDIALOG
	je	jINITDIALOG
	cmp	eax,WM_CLOSE
	je	jCLOSE
	xor eax,eax
	jmp finish

jINITDIALOG:
	mov eax,[hWnd]
	mov [pWnd],eax

	mov [selected_id],A1

	mov eax,1
	jmp finish

jCOMMAND:
	mov eax,[wParam]
	mov ebx,eax
	shr ebx,16
	cmp ebx,EN_SETFOCUS
	je jSETFOCUS
	cmp	ebx,EN_CHANGE
	je modificando_input

	cmp eax,btn_cancelar
	je cancelar
	cmp eax,btn_confirmar
	je confirmar
	cmp eax,btn_func
	je funciones

	xor eax, eax
	jmp finish

cancelar:
	invoke SendDlgItemMessage,[hWnd],[selected_id],WM_SETTEXT,0,0
	mov eax,1
	jmp finish

funciones:
	mov eax,1
	jmp finish

confirmar:
	invoke GetDlgItemText,[hWnd],input_expresion,buffer,0FFh
	mov esi,buffer
	cmp byte[esi],'='
	jne no_hay_operacion
	mov ecx,eax

convertir_lowercase:
	cmp byte[esi],'A'
	jb convertir_lowercase_pass
	cmp byte[esi],'Z'
	ja convertir_lowercase_pass
	add byte[esi],32

convertir_lowercase_pass:
	inc esi
	loop convertir_lowercase

	esPrefijo msg_suma,buffer,op_suma
	esPrefijo msg_prom,buffer,op_promedio
	esPrefijo msg_ordn,buffer,op_ordenamiento
	esPrefijo msg_si,buffer,op_si
	jmp formula_erronea

no_hay_operacion:
	copiar input_expresion,[selected_id]
	jmp confirmar_pass


; *************************** FUNCION SUMA
op_suma:
	mov esi,buffer
	add esi,6
	mov ebx,0

suma_inciar_contador:
	limpiarRegistro aux,0FFh
	mov edi,aux
	xor edx,edx

suma_ciclo_indices:
	cmp byte[esi],0
	je formula_erronea
	cmp byte[esi],';'
	je suma_agregar_id
	cmp byte[esi],')'
	je suma_agregar_id

	mov al,byte[esi]
	mov byte[edi],al
	inc edx
	inc edi
	inc esi
	jmp suma_ciclo_indices

suma_agregar_id:
	searchN aux,database,edx
	cmp eax,0
	je formula_erronea

	mov edi,ids
	mov eax,4
	mul ebx
	add edi,eax
	obtenerId aux
	mov dword[edi],eax

	inc ebx
	cmp byte[esi],')'
	je suma_fin_indices
	inc esi
	jmp suma_inciar_contador

suma_fin_indices:
	cmp ebx,0
	je formula_erronea
	mov esi,ids
	finit
	fldz

sumar:
	cmp ebx,0
	je sumar_fin

	invoke GetDlgItemText,[hWnd],dword[esi],buffer,0FFh
	cmp eax,0
	je valor_erroneo

	cinvoke sscanf,buffer,format_In,numero
	cmp eax,0
	je valor_erroneo

	fld [numero]
	faddp st1,st0
	add esi,4
	dec ebx
	jmp sumar

sumar_fin:
	fwait
	fstp [resultado]
	invoke sprintf,buffer,format_Out,dword[resultado],dword[resultado+4]
	invoke SetDlgItemText,[hWnd],[selected_id],buffer
	jmp confirmar_pass


; *************************** FUNCION PROMEDIO
op_promedio:
	mov esi,buffer
	add esi,10
	mov ebx,0

promedio_suma_inciar_contador:
	limpiarRegistro aux,0FFh
	mov edi,aux
	xor edx,edx

promedio_suma_ciclo_indices:
	cmp byte[esi],0
	je formula_erronea
	cmp byte[esi],';'
	je promedio_suma_agregar_id
	cmp byte[esi],')'
	je promedio_suma_agregar_id

	mov al,byte[esi]
	mov byte[edi],al
	inc edx
	inc edi
	inc esi
	jmp promedio_suma_ciclo_indices

promedio_suma_agregar_id:
	searchN aux,database,edx
	cmp eax,0
	je formula_erronea

	mov edi,ids
	mov eax,4
	mul ebx
	add edi,eax
	obtenerId aux
	mov dword[edi],eax

	inc ebx
	cmp byte[esi],')'
	je promedio_suma_fin_indices
	inc esi
	jmp promedio_suma_inciar_contador

promedio_suma_fin_indices:
	cmp ebx,0
	je formula_erronea
	mov esi,ids
	mov dword[cantidad_valores],ebx

	finit
	fldz

promedio_sumar:
	cmp ebx,0
	je promedio_sumar_fin

	invoke GetDlgItemText,[hWnd],dword[esi],buffer,0FFh
	cmp eax,0
	je valor_erroneo

	cinvoke sscanf,buffer,format_In,numero
	cmp eax,0
	je valor_erroneo

	fld [numero]
	faddp st1,st0
	add esi,4
	dec ebx
	jmp promedio_sumar

promedio_sumar_fin:
	fild [cantidad_valores]
	fdivp st1,st0
	fwait
	fstp [resultado]
	invoke sprintf,buffer,format_Out,dword[resultado],dword[resultado+4]
	invoke SetDlgItemText,[hWnd],[selected_id],buffer
	jmp confirmar_pass


; *************************** FUNCION ORDENAR
op_ordenamiento:
	mov esi,buffer
	add esi,9
	mov ebx,0

ordenamiento_inciar_contador:
	limpiarRegistro aux,0FFh
	mov edi,aux
	xor edx,edx

ordenamiento_ciclo_indices:
	cmp byte[esi],0
	je formula_erronea
	cmp byte[esi],';'
	je ordenamiento_agregar_id
	cmp byte[esi],':'
	je ordenamiento_agregar_id

	mov al,byte[esi]
	mov byte[edi],al
	inc edx
	inc edi
	inc esi
	jmp ordenamiento_ciclo_indices

ordenamiento_agregar_id:
	searchN aux,database,edx
	cmp eax,0
	je formula_erronea

	mov edi,ids
	mov eax,4
	mul ebx
	add edi,eax
	obtenerId aux
	mov dword[edi],eax

	inc ebx
	cmp byte[esi],':'
	je ordenamiento_agregar_
	inc esi
	jmp ordenamiento_inciar_contador

ordenamiento_agregar_:
	cmp ebx,0
	je formula_erronea
	mov dword[cantidad_valores],ebx
	inc esi
	xor ebx,ebx
	xor ecx,ecx

ordenamiento_agregar__ciclo:
	cmp byte[esi],')'
	je ordenamiento_agregar__fin_ciclo
	cmp byte[esi],0
	je formula_erronea

	mov bl,byte[esi]
	inc esi
	inc ecx
	jmp ordenamiento_agregar__ciclo

ordenamiento_agregar__fin_ciclo:
	cmp ecx,1
	ja formula_erronea
	cmp bl,'0'
	jb formula_erronea
	cmp bl,'1'
	ja formula_erronea

	mov byte[ord_aux],bl
	mov esi,ids
	mov edi,ord_valores
	mov ebx,dword[cantidad_valores]

ordenar_verificar_valores:
	cmp ebx,0
	je ordenar

	invoke GetDlgItemText,[hWnd],dword[esi],buffer,0FFh
	cmp eax,0
	je valor_erroneo
	cinvoke sscanf,buffer,format_In,edi
	cmp eax,0
	je valor_erroneo

	add edi,8
	add esi,4
	dec ebx
	jmp ordenar_verificar_valores

ordenar:
	mov esi,ord_valores
	mov ebx,dword[cantidad_valores]
	mov ecx,0
	finit

ordenar_ciclo:
	cmp ebx,0
	je op_ordenamiento_fin
	mov ecx,[cantidad_valores]

ordenar_ciclo_2:
	cmp ecx,ebx
	je ordenar_ciclo_2_pass

	fld qword[edi]
	fld qword[edi+8]

	cmp byte[ord_aux],'1'
	je ordenar_may_men
	jmp ordenar_men_may

ordenar_may_men:
	fcompp
	fnstsw ax
	sahf
	jna ordenar_ciclo_2_pass
	jmp ordenar_ciclo_2_sig

ordenar_men_may:
	fcompp
	fnstsw ax
	sahf
	jnb ordenar_ciclo_2_pass
	jmp ordenar_ciclo_2_sig

ordenar_ciclo_2_sig:
	push ecx ebx
	mov eax,dword[edi]
	mov ebx,dword[edi+4]
	mov ecx,dword[edi+8]
	mov edx,dword[edi+12]

	mov dword[edi],ecx
	mov dword[edi+4],edx
	mov dword[edi+8],eax
	mov dword[edi+12],ebx
	pop ebx ecx

	sub edi,8
	dec ecx
	jmp ordenar_ciclo_2

ordenar_ciclo_2_pass:
	dec ebx
	mov edi,esi
	add esi,8
	jmp ordenar_ciclo

op_ordenamiento_fin:
	mov ebx,[cantidad_valores]
	mov esi,ord_valores
	mov edi,ids

op_ordenamiento_fin_ciclo:
	cmp ebx,0
	je confirmar_pass

	invoke sprintf,buffer,format_Out,dword[esi],dword[esi+4]
	invoke SetDlgItemText,[hWnd],dword[edi],buffer
	add esi,8
	add edi,4
	dec ebx
	jmp op_ordenamiento_fin_ciclo


; *************************** FUNCION SI
op_si:
	mov esi,buffer
	add esi,4
	mov ebx,0

op_si_iniciar_contador:
	limpiarRegistro aux,0FFh
	mov edi,aux
	xor edx,edx

op_si_ciclo_1:
	cmp byte[esi],0
	je formula_erronea
	cmp byte[esi],';'
	je op_si_agregar_id
	cmp byte[esi],':'
	je op_si_agregar_id

	mov al,byte[esi]
	mov byte[edi],al
	inc edx
	inc edi
	inc esi
	jmp op_si_ciclo_1

op_si_agregar_id:
	searchN aux,database,edx
	cmp eax,0
	je formula_erronea

	mov edi,ids
	mov eax,4
	mul ebx
	add edi,eax
	obtenerId aux
	mov dword[edi],eax

	inc ebx
	cmp byte[esi],':'
	je op_si_evaluar_operador
	inc esi
	jmp op_si_ciclo_1

op_si_evaluar_operador:
	cmp ebx,2
	jne formula_erronea
	inc esi
	limpiarRegistro operador,0FFh
	mov edi,operador
	xor ebx,ebx

op_si_evaluar_operador_ciclo:
	cmp byte[esi],0
	je formula_erronea
	cmp byte[esi],';'
	je op_si_guardar_operador

	mov al,byte[esi]
	mov byte[edi],al
	inc esi
	inc edi
	inc ebx
	jmp op_si_evaluar_operador_ciclo

op_si_guardar_operador:
	searchN operador,database_op,ebx
	cmp eax,0
	je formula_erronea
	inc esi
	limpiarRegistro si_yes,0FFh
	mov edi,si_yes
	xor ebx,ebx

op_si_evaluar_yes:
	cmp byte[esi],0
	je formula_erronea
	cmp byte[esi],':'
	je op_si_guardar_yes

	mov al,byte[esi]
	mov byte[edi],al
	inc esi
	inc edi
	inc ebx
	jmp op_si_evaluar_yes

op_si_guardar_yes:
	cmp ebx,0
	je formula_erronea
	inc esi
	limpiarRegistro si_no,0FFh
	mov edi,si_no
	xor ebx,ebx

op_si_evaluar_no:
	cmp byte[esi],0
	je formula_erronea
	cmp byte[esi],')'
	je op_si_guardar_no

	mov al,byte[esi]
	mov byte[edi],al
	inc esi
	inc edi
	inc ebx
	jmp op_si_evaluar_no

op_si_guardar_no:
	cmp ebx,0
	je formula_erronea


op_si_fin:
	invoke MessageBox,0,'FUNCION SI FINALIZADO',0,MB_ICONWARNING
	jmp confirmar_pass


; *************************** ETIQUETAS EXTRA
valor_erroneo:
	invoke MessageBox,[pWnd],'Alguno/s de los valores no son valido/s!','ERROR VALOR',MB_ICONWARNING
	invoke SetDlgItemText,[pWnd],[selected_id],errorValor
	jmp confirmar_pass

formula_erronea:
	invoke MessageBox,[pWnd],'La formula proporcionada no es correcta!','ERROR FORMULA',MB_ICONERROR
	invoke SetDlgItemText,[pWnd],[selected_id],error
	jmp confirmar_pass

confirmar_pass:
	mov eax,1
	jmp finish

modificando_input:
	and eax,0FFFFh
	cmp eax,input_expresion
	je modificando_input_pass
	mov ebx,eax
	copiar ebx,input_expresion
	jmp modificando_input_pass

modificando_input_pass:
	mov eax,1
	jmp finish

jSETFOCUS:
	and eax,0FFFFh
	mov [cnt_id],eax
	cmp eax,input_expresion
	je jSETFOCUS_pass

	mov [selected_id],eax
	copiar [selected_id],input_expresion
	jmp jSETFOCUS_pass

jSETFOCUS_pass:
	mov eax,1
	jmp finish

jCLOSE:	
	invoke EndDialog,[hWnd],0
	mov eax,1
	jmp finish

finish:
	pop ebx esi edi
	ret
endp


; ********************     MEMORIA     ********************
section '.data' data readable writeable

Ist  							dd 0
pWnd 							dd 0
cnt_id						dd 0
selected_id				dd 0
buffer						rd 0FFh

error							db '#',0xBF,'NOMBRE?',0
errorValor				db '#',0x21,'VALOR!',0
msg_suma					db '=suma(',0
msg_prom					db '=promedio(',0
msg_ordn					db '=ordenar(',0
msg_si						db '=si(',0
format_Out				db '%.7f',0
format_In					db '%lf',0

aux								db 100h dup(0)
ids								dd 100h dup(0)
numero						dq 0
resultado					dq 0
cantidad_valores	dd 0
ord_aux						db 0
ord_valores				dq 100h dup(0)
si_yes						db 100h dup(0)
si_no							db 100h dup(0)
operador					db 100h dup(0)

database_op	db '<',1,'>',1,'<=',1,'>=',1,'==',1,'!=',0

database		db 'a1',1,'a2',1,'a3',1,'a4',1,'a5',1,'a6',1,'a7',1,'a8',1,'a9',1,'a10',1,\
							 'a11',1,'a12',1,'a13',1,'a14',1,'a15',1,'a16',1,'a17',1,'a18',1,'a19',1,'a20',1,\
							 'b1',1,'b2',1,'b3',1,'b4',1,'b5',1,'b6',1,'b7',1,'b8',1,'b9',1,'b10',1,\
							 'b11',1,'b12',1,'b13',1,'b14',1,'b15',1,'b16',1,'b17',1,'b18',1,'b19',1,'b20',1,\
							 'c1',1,'c2',1,'c3',1,'c4',1,'c5',1,'c6',1,'c7',1,'c8',1,'c9',1,'c10',1,\
							 'c11',1,'c12',1,'c13',1,'c14',1,'c15',1,'c16',1,'c17',1,'c18',1,'c19',1,'c20',1,\
							 'd1',1,'d2',1,'d3',1,'d4',1,'d5',1,'d6',1,'d7',1,'d8',1,'d9',1,'d10',1,\
							 'd11',1,'d12',1,'d13',1,'d14',1,'d15',1,'d16',1,'d17',1,'d18',1,'d19',1,'d20',1,\
							 'e1',1,'e2',1,'e3',1,'e4',1,'e5',1,'e6',1,'e7',1,'e8',1,'e9',1,'e10',1,\
							 'e11',1,'e12',1,'e13',1,'e14',1,'e15',1,'e16',1,'e17',1,'e18',1,'e19',1,'e20',1,\
							 'f1',1,'f2',1,'f3',1,'f4',1,'f5',1,'f6',1,'f7',1,'f8',1,'f9',1,'f10',1,\
							 'f11',1,'f12',1,'f13',1,'f14',1,'f15',1,'f16',1,'f17',1,'f18',1,'f19',1,'f20',1,\
							 'g1',1,'g2',1,'g3',1,'g4',1,'g5',1,'g6',1,'g7',1,'g8',1,'g9',1,'g10',1,\
							 'g11',1,'g12',1,'g13',1,'g14',1,'g15',1,'g16',1,'g17',1,'g18',1,'g19',1,'g20',1,\
							 'h1',1,'h2',1,'h3',1,'h4',1,'h5',1,'h6',1,'h7',1,'h8',1,'h9',1,'h10',1,\
							 'h11',1,'h12',1,'h13',1,'h14',1,'h15',1,'h16',1,'h17',1,'h18',1,'h19',1,'h20',1,\
							 'i1',1,'i2',1,'i3',1,'i4',1,'i5',1,'i6',1,'i7',1,'i8',1,'i9',1,'i10',1,\
							 'i11',1,'i12',1,'i13',1,'i14',1,'i15',1,'i16',1,'i17',1,'i18',1,'i19',1,'i20',1,\
							 'j1',1,'j2',1,'j3',1,'j4',1,'j5',1,'j6',1,'j7',1,'j8',1,'j9',1,'j10',1,\
							 'j11',1,'j12',1,'j13',1,'j14',1,'j15',1,'j16',1,'j17',1,'j18',1,'j19',1,'j20',1,\
							 'k1',1,'k2',1,'k3',1,'k4',1,'k5',1,'k6',1,'k7',1,'k8',1,'k9',1,'k10',1,\
							 'k11',1,'k12',1,'k13',1,'k14',1,'k15',1,'k16',1,'k17',1,'k18',1,'k19',1,'k20',1,\
							 'l1',1,'l2',1,'l3',1,'l4',1,'l5',1,'l6',1,'l7',1,'l8',1,'l9',1,'l10',1,\
							 'l11',1,'l12',1,'l13',1,'l14',1,'l15',1,'l16',1,'l17',1,'l18',1,'l19',1,'l20',0


; ********************     RECURSOS     ********************
section '.idata' import data readable writeable
	library kernel32,'KERNEL32.DLL',\
					user32,'USER32.DLL',\
					gdi32,'GDI32.DLL',\
					msvcrt,'MSVCRT.DLL'

	include 'c:/fasm/include/api/kernel32.inc'
	include 'c:/fasm/include/api/user32.inc'
	include 'c:/fasm/include/api/gdi32.inc'

	import msvcrt,\
			sprintf,'sprintf',\
			sscanf,'sscanf'

section '.rsrc' resource from 'excel.res' data readable
