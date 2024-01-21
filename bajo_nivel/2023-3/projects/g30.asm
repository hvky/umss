; Realizar un programa que permita el ingreso de una fecha (dia, mes, a�o).
; Ingresando otra fecha mostrar la fecha reciente, la fecha pasada y su diferencia.
; Se asumir� que cada mes tiene 30 d�as y cada a�o 365 d�as.
; ingresar fecha uno 02/02/2021
; ingresar fecha dos 04/02/2021
; muestra fecha reciente
; muestra fecha pasada
; muestra la diferenica en dias

org 100h
macro salto
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
endm
leerCharCE macro
	mov ah,1
	int 21h
endm
mostrarChar macro c
    push ax
    push dx
        mov ah,2
        mov dl,c
        int 21h
    pop  dx
    pop  ax
endm

mostrarCadena macro cadena
	push ax
	push dx
		mov ah,9
		mov dx,offset cadena
		int 21h
	pop dx
	pop ax
endm
mostrarNumero macro n
    local incrementar,mnFin
    push ax
    push dx
        mov dl,n
        cmp dl,9
        ja  incrementar
        add dl,30h
        jmp mnFin
	incrementar:			
        add dl,37h			
	mnFin:
        mostrarChar dl        
    pop  dx
    pop  ax
endm

mostrarNumeroBase macro num,base 
    local c1,mostrarDB,mostrarPN
    push ax
    push bx
    push cx
    push dx
        mov ax,num
        mov bx,base
        mov cx,0 		
    c1:
    	cmp ax,base
        jb  mostrarDB
        mov dx,0
        div bx
        push dx
        inc cx
        jmp c1
    mostrarDB:
        push ax			
        inc  cx			
    mostrarPN:
        pop dx                 
        mostrarNumero dl
        loop mostrarPN
    pop dx
    pop cx
    pop bx
    pop ax
endm

leerCadena macro contenedor,maxDig
	local lee,finLeerCadena
	push ax
	push si
	mov si,0
	lee:
		cmp si,maxDig
		je  finLeerCadena
		leerCharCE
		cmp al,13				
		je  finLeerCadena
		mov contenedor[si],al
		inc si
		jmp lee
	finLeerCadena:
	mov contenedor[si],'$'		
	salto						
	pop si
	pop ax
endm


guardarValor macro dir,char1,char2
    push ax
    push bx        
        mov ax,0
        mov al,char1
        sub al,30h
        mov bl,10
        mul bl
        mov bx,0
        mov bl,char2
        sub bl,30h
        add ax,bx
        mov dir,ax
    pop bx
    pop ax   
endm
guardaryear macro c1,c2,c3,c4
    push ax
    push bx
    push cx        
        mov ax,0
        mov al,c1
        sub al,30h
        mov bl,10
        mul bl
        mul bl
        mul bl
        mov cx,0
        mov cl,c2
        sub cl,30h
        mul bl
        mul bl
        add ax,cx
        mov cx,0
        mov cl,c3
        sub cl,30h
        mul bl
        mov cx,0
        mov cl,c4       
        add ax,cx
        mov year,ax
    pop cx
    pop bx
    pop ax   
endm

inicio: 
    leerCadena fecha1,10
    leerCadena fecha2,10
    mov si,offset fecha1
    mov di,offset fecha2
    
    guardaryear [si+6],[si+7],[si+8],[si+9]
    mov ax,year
    guardaryear [di+6],[di+7],[di+8],[di+9]
    mov bx,year
    cmp ax,bx
    je cMes
    sub ax,bx
    js nres
    jmp nn
nres:
    neg ax
    xchg si,di
nn:
    mov cx,16Dh
    mul cx
    mov dif,ax        
cMes:
    guardarValor mes,[si+3],[si+4]
    mov ax,mes
    guardarValor mes,[di+3],[di+4]
    mov bx,mes   
    cmp ax,bx
    je cDias
    sub ax,bx
    js nres2
    jmp nn2
nres2:
    neg ax
    xchg si,di
nn2:
    mov cl,1Eh
    mul cl
    add dif,ax
cDias:
    guardarValor dia,[si],[si+1]
    mov ax,dia
    guardarValor dia,[di],[di+1]
    mov bx,dia   
    cmp ax,bx
    je mresfin
    sub ax,bx
    js nres3
    jmp nn3
nres3:
    neg ax
    xchg si,di
nn3:
    add dif,ax
mresfin:
    mostrarCadena separador
    mov ah,9
    mov dx,si
    int 21h
    salto
    mov ah,9
    mov dx,di
    int 21h
   mostrarCadena separador
   mostrarNumeroBase dif,10
fin:
int 20h
dia dw 0
mes dw 0
year dw 0
fecha1 db 15 dup('$')
fecha2 db 15 dup('$')
separador db 10,13,'------------------------------',10,13,'$'
dif dw 0
