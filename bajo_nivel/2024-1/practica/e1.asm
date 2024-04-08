org 100h

printStr macro str
  mov dx, offset str
  mov ah, 9
  int 21h
endm

printChar macro c
  mov dl, c
  mov ah, 2
  int 21h
endm

input macro lim_inf, lim_sup, actual, destino
  local ciclo, procesar, error
  mov cx, 2
  mov dx, 0

  ciclo:
    mov ah, 7
    int 21h

    cmp al, 13
    je procesar
    cmp al, 30h
    jb ciclo
    cmp al, 39h
    ja ciclo

    mov dl, al
    mov ah, 2
    int 21h

    sub dl, 30h
    mov ax, 0
    mov al, dh
    mov ch, 10
    mul ch
    mov ch, 0
    add al, dl
    mov dh, al
    loop ciclo

  procesar:
    cmp dh, lim_inf
    jb error
    cmp dh, lim_sup
    ja error
    shr dx, 8
    jmp destino

  error:
    printStr msg_error
    jmp actual
endm

print macro izq, der
  local ciclo, pass, end
  mov cl, 0

  ciclo:
    mov ax, bx
    cmp cl, 10h
    je end

    shl ax, cl
    shr ax, der

    add al, 30h
    cmp al, 3Ah
    jb pass
    add al, 7

    pass:
      printChar al
      add cl, izq
      jmp ciclo

  end:
endm


inicio:
  printStr msg_day
  input 1, 30, inicio, procesar_day
  procesar_day:
    mov bx, dx

month:
  printStr msg_month
  input 1, 12, month, procesar_month
  procesar_month:
    shl bx, 4
    or bx, dx

year:
  printStr msg_year
  input 0, 99, year, procesar_year
  procesar_year:
    shl bx, 7
    or bx, dx

imprimir:
  printStr msg_registro
  print 1 15
  printStr salto
  print 4 12

  push bx
  shr bx, 11
  printStr msg_dia_
  print 1 15
  printStr salto
  print 4 12
  pop bx

  push bx
  shl bx, 5
  shr bx, 12
  printStr msg_month_
  print 1 15
  printStr salto
  print 4 12
  pop bx

  shl bx, 9
  shr bx, 9
  printStr msg_year_
  print 1 15
  printStr salto
  print 4 12

fin: int 20h


msg_day       db 13, 10, 'Ingrese el dia [01 - 30]: $'
msg_month     db 13, 10, 'Ingrese el mes [01 - 12]: $'
msg_year      db 13, 10, 'Ingrese el a', 0A4h, 'o [00 - 99]: $'
msg_error     db 13, 10, 'Fecha no valida!$'
salto         db 13, 10, '$'
msg_registro  db 2 dup(13, 10), 'Registro:', 13, 10, '$'
msg_dia_      db 13, 10, 'Dia:', 13, 10, '$'
msg_month_    db 13, 10, 'Mes:', 13, 10, '$'
msg_year_     db 13, 10, 'A', 0A4h, 'o:' , 13, 10, '$'
