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
A2										= 1052
A3										= 1064
A4										= 1076
A5										= 1088
A6										= 1100
A7										= 1112
A8										= 1124
A9										= 1136
A10										= 1148
A11										= 1160
A12										= 1172
A13										= 1184
A14										= 1196
A15										= 1208
A16										= 1220
A17										= 1232
A18										= 1244
A19										= 1256
A20										= 1268


; ********************     MACROS     ********************
macro copiar orig,dest {
	invoke SendDlgItemMessage,[pWnd],orig,WM_GETTEXT,0FFh,buffer
	invoke SendDlgItemMessage,[pWnd],dest,WM_SETTEXT,0,buffer
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

	mov eax,1
	jmp finish

jCOMMAND:
	mov eax,[wParam]
	mov ebx,eax
	shr ebx,16
	cmp ebx,EN_SETFOCUS
	je jSETFOCUS
	cmp	ebx,EN_CHANGE
	je  cambio_texto

	cmp eax,btn_cancelar
	je cancelar
	cmp eax,btn_confirmar
	je confirmar
	cmp eax,btn_func
	je funciones

	xor eax, eax
	jmp finish

cancelar:
	jmp finish

confirmar:
	mov eax,[selected_id]
	test eax,eax
	jnz confirmar_pass
	mov [selected_id],A1

confirmar_pass:
	copiar input_expresion,[selected_id]
	jmp finish

funciones:
	jmp finish

cambio_texto:
	and eax,0FFFFh
	cmp eax,input_expresion
	je cambio_texto_pass
	mov ebx,eax
	copiar ebx,input_expresion

cambio_texto_pass:
	mov eax,1
	jmp finish

jSETFOCUS:
	and eax,0FFFFh
	mov [cnt_id],eax
	cmp eax,input_expresion
	je jSETFOCUS_pass

	mov [selected_id],eax
	invoke SendDlgItemMessage,[pWnd],eax,WM_GETTEXT,0FFh,buffer
	invoke lstrcmp,buffer,""
	cmp eax,0
	je jSETFOCUS_pass
	copiar [selected_id],input_expresion

jSETFOCUS_pass:
	mov eax,1
	jmp finish

jCLOSE:	
	invoke EndDialog,[hWnd],0
	mov eax,1

finish:
	pop ebx esi edi
	ret
endp


; ********************     MEMORIA     ********************
section '.data' data readable writeable

Ist  				dd 0
pWnd 				dd 0
cnt_id			dd 0
selected_id	dd 0
buffer			rd 0FFh
text				db 20 dup(0)
no_control	db "SIN INPUT SELECCIONADO",0


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
