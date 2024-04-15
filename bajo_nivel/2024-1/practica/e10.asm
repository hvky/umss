org 100h

printChar macro c
  push ax
  mov dl, c
  mov ah, 2
  int 21h
  pop ax
endm

printStr macro str
  push ax
  mov dx, offset str
  mov ah, 9
  int 21h
  pop ax
endm

inputNum macro n, min
  local ciclo, end
  mov bl, 0
  mov cl, n
  mov ch, 0

  ciclo:
    mov ah, 7
    int 21h
    cmp al, 13
    je end
    cmp al, 30h
    jb ciclo
    cmp al, 39h
    ja ciclo
    printChar al
    push ax
    inc bl
    loop ciclo

  end:
    cmp bl, min
    jb ciclo
endm

inputStr macro n
  local ciclo, guardar, end
  mov bl, 0
  mov cl, n
  mov ch, 0

  ciclo:
    mov ah, 7
    int 21h
    cmp al, 13
    je end
    cmp al, ' '
    je guardar
    cmp al, 'A'
    jb ciclo
    cmp al, 'z'
    ja ciclo
    cmp al, 'Z'
    jbe guardar
    cmp al, 'a'
    jb ciclo

  guardar:
    printChar al
    push ax
    inc bl
    loop ciclo

  end:
    cmp bl, 0
    je ciclo
endm

verificarFecha macro x
  local error, pass
  cmp dl, 0
  je error
  cmp dl, x
  jbe pass
  error:
    printStr msg_err
    jmp fecha
  pass:
endm

print macro num
  local ciclo, ciclo2
  mov ax, num
  mov ah, 0
  mov bx, 10
  mov cx, 0

  ciclo:
    cmp ax, 0
    je ciclo2
    mov dx, 0
    div bx
    push dx
    inc cl
    jmp ciclo

  ciclo2:
    pop dx
    add dl, 30h
    printChar dl
    loop ciclo2
endm


inicio:
  printStr msg_nit
  inputNum 20, 5
  mov ch, 0
  mov cl, bl
  sub cl, 2

limpiar_nit:
  pop ax
  loop limpiar_nit

  pop bx
  pop ax
  sub al, 30h
  sub bl, 30h
  mov cl, 10
  mul cl
  add al, bl
  mov si, offset valores
  add si, 2
  mov [si], al

  printStr msg_nro
  inputNum 30, 1
  printStr msg_aut
  inputNum 30, 1

  printStr msg_nom
  inputStr 50
  mov ch, 0
  mov cl, bl
  mov ax, 0
  mov bx, 0

calcular_promedio:
  pop dx
  mov dh, 0
  cmp dl, ' '
  je calcular_promedio_pass
  add ax, dx
  inc bl
  calcular_promedio_pass:
    loop calcular_promedio

  mov dx, 0
  div bx
  mov si, offset valores
  mov [si], al

  printStr msg_mon
  inputNum 10, 1

fecha:
  printStr msg_fec
  mov bx, 0

day:
  call inputFecha
  verificarFecha 30
  printChar '/'

month:
  call inputFecha
  verificarFecha 12
  printChar '/'

year:
  call inputFecha
  mov si, offset valores
  inc si
  mov [si], bl

imprimir:
  mov si, offset valores
  printStr msg_1
  print [si]
  printStr msg_2
  inc si
  print [si]
  printStr msg_3
  inc si
  print [si]

fin: int 20h


inputFecha proc
  mov cx, 2
  mov dh, 0

  ciclo:
    mov ah, 7
    int 21h
    cmp al, 30h
    jb ciclo
    cmp al, 39h
    ja ciclo
    printChar al
    sub al, 30h
    add bl, al
    xchg al, dh
    mov dl, 10
    mul dl
    add dh, al
    loop ciclo

  mov dl, dh
ret
inputFecha endp


msg_nit db 13, 10, 'Ingrese el NIT: $'
msg_nro db 13, 10, 'Ingrese el Nro de Factura: $'
msg_aut db 13, 10, 'Ingrese el Nro de Autorizacion: $'
msg_nom db 13, 10, 'Ingrese el Nombre del Cliente: $'
msg_mon db 13, 10, 'Ingrese el Monto: $'
msg_fec db 13, 10, 'Ingrese la fecha en el formato DD/MM/AA: $'
msg_1   db 2 dup(13, 10), 'Primer Componente: $'
msg_2   db 13, 10, 'Segundo Componente: $'
msg_3   db 13, 10, 'Tercer Componente: $'
msg_err db 13, 10, 'La fecha ingresada no es valida!$'

valores db 0, 0, 0
