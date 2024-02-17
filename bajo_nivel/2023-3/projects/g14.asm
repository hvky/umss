org 100h   

mostrarMsj macro arg
  mov ah, 09h
  mov dx, offset arg
  int 21h
endm

mostrarGanador macro puntos jugador
  mostrarMsj mensajeGanador
  mostrarMsj jugador
  call espacio
  call guion
  call espacio
  mostrarMsj mensajePuntos2
  mov ah, 02h
  mov dl, puntos
  mov ax,0 
  mov bx,0
  mov al,dl
  mov bl,10
  div bl 
  mov ch,ah
  mov cl,al
  mov ah,2
  mov dl,cl
  add dl, 30h
  int 21h
  mov dl,ch 
  add dl, 30h
  int 21h
endm

agregarA macro puntos jugador
  mostrarMsj mensajePuntos
  mostrarMsj jugador
  mov ah, 02h ; 02h mostrar caracter en dl
  mov dl, 3ah ; 3ah = :
  int 21h
  call espacio
  mov ah, 01h ; 01h ingresar 1 caracter y se guarda en al
  int 21h
  sub al, 30h ; 30h = 0
  add puntos, al
endm

main:
  call ingresarRondas
  mostrarMsj mensajeNombre
  mov si, offset jugador1
  call agregarJugador
  mostrarMsj mensajeNombre
  mov si, offset jugador2
  call agregarJugador
  mov si, 0
  call agregarPuntos
  call buscarGanador  
  
endMain:int 20h

ingresarRondas proc
  call limpiar
  mostrarMsj mensajeRondas
  mov ah, 01h ; 01h ingresar un caracter
  int 21h
  cmp al, 31h ; 31h = 1
  jb ingresarRondas
  cmp al, 39h ; 39h = 9
  ja ingresarRondas
  sub al, 30h ; 30h = 0
  mov rondas, al
  ret
ingresarRondas endp 

agregarJugador proc
  mov ah, 01h
  int 21h
  cmp al, 0dh ; 0dh = tecla enter
  je retornar
  mov [si], al
  inc si
  loop agregarJugador
  ret
agregarJugador endp

agregarPuntos proc
  mov al, rondas
  mov ah, 0
  cmp si, ax
  jae retornar
  mostrarMsj mensajeRonda
  call mostrarRonda
  agregarA puntos1 jugador1
  agregarA puntos2 jugador2
  inc si
  inc ronda
  mostrarMsj mensajeSep
  loop agregarPuntos
  ret
agregarPuntos endp

mostrarRonda proc
  mov ah, 02h
  mov dl, ronda
  add dl, 30h
  int 21h
  ret
mostrarRonda endp

buscarGanador proc
  mov ah, puntos1
  mov al, puntos2
  cmp ah, al
  je mostrarEmpate
  jg mostrarGanador1
  jmp mostrarGanador2
  ret
buscarGanador endp

mostrarEmpate:
  mostrarMsj mensajeEmpate
  jmp fin
  
mostrarGanador1:
  mostrarGanador puntos1, jugador1
  jmp fin

mostrarGanador2:
  mostrarGanador puntos2, jugador2
  jmp fin


limpiar proc
  mov ah, 06h
  mov al, 00h
  mov bh, 07h
  mov cx, 0
  mov dx, 184fh
  int 10h
  ret
limpiar endp


espacio proc
  mov ah, 02h
  mov dl, 20h ; 20h = tecla espacio
  int 21h
  ret
espacio endp

guion proc
  mov ah, 02h
  mov dl, 2dh ; 2dh = guion
  int 21h
  ret
guion endp

retornar: ret

fin: int 20h

mensajeNombre db 10, 13, "Ingrese su nombre: ", "$"
jugador1 db 10 dup('$')
jugador2 db 10 dup('$')
rondas db 0
ronda db 1
puntos1 db 0
puntos2 db 0
mensajePuntos db 10, 13, "Puntaje ", "$"
mensajePuntos2 db 10, 13, "Con Un Puntaje De:", "$"
mensajeSep db 10, 13, "-------------------------", "$"
mensajeRonda db 10, 13, "Ronda--------------------", "$"
mensajeGanador db 10, 13, "El ganador es: ", "$"
mensajeEmpate db 10, 13, "Empate", "$"
mensajeRondas db 13, "Numero de rondas (1-9): ", "$"



