org 100h

printChar macro c
  push ax
  mov dl, c
  mov ah, 2
  int 21h
  pop ax
endm

sort macro cad
  local ciclo, ciclo2, pass
  mov si, offset cad
  mov cl, bl
  mov ch, 0
  mov dh, 0

  ciclo:
    mov al, [si]
    mov dl, dh

  ciclo2:
    cmp dl, 0
    je pass
    cmp al, [di]
    jae pass
    mov ah, [di]

    mov [di], al
    inc di
    mov [di], ah
    sub di, 2
    dec dl
    jmp ciclo2

  pass:
    mov di, si
    inc si
    inc dh
    loop ciclo
endm


inicio:
  mov dx, offset msg
  mov ah, 9
  int 21h
  mov cx, 0FFh
  mov si, offset cad
  mov bx, 0

ciclo_input:
  mov ah, 7
  int 21h
  cmp al, 13
  je procesar
  cmp al, 'A'
  Jb ciclo_input
  cmp al, 'z'
  ja ciclo_input
  cmp al, 'Z'
  jbe ciclo_input_save
  cmp al, 'a'
  jb ciclo_input

  ciclo_input_save:
    printChar al
    mov [si], al
    inc bl
    inc si
    loop ciclo_input

procesar:
  cmp bl, 0
  je ciclo_input
  sort cad

  mov si, offset cad
  mov di, offset val
  mov bp, offset ans
  mov al, [si]
  mov [di], 1
  inc si
  mov cl, bl
  mov ch, 0
  mov bx, 1

ciclo_procesar:
  cmp al, [si]
  je ciclo_procesar_aumentar
  inc di
  mov [bp], al
  mov [di], 1
  inc bp
  inc bl
  jmp ciclo_procesar_pass

ciclo_procesar_aumentar:
  inc [di]

ciclo_procesar_pass:
  mov al, [si]
  inc si
  loop ciclo_procesar

  sort val
  mov si, offset val
  mov di, offset ans
  inc si
  mov bh, [si]

ciclo:
  cmp bl, 0
  je fin
  mov cl, bh
  mov al, [di]
  printChar 13
  printChar 10

ciclo2:
  printChar al
  loop ciclo2
  inc di
  dec bl
  jmp ciclo

fin: int 20h


msg db 'Introduzca los caracteres: $'
cad db 100h dup(0)
val db 60 dup(0)
ans db 60 dup(0)
