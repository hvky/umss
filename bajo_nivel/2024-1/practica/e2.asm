org 100h

printChar macro c
  push ax
  push dx
  mov dl, c
  mov ah, 2
  int 21h
  pop dx
  pop ax
endm

printStr macro str
  push ax
  push dx
  mov dx, offset str
  mov ah, 9
  int 21h
  pop dx
  pop ax
endm

print macro num
  local ciclo, sig, imprimir end
  push bx
  mov cx, 0
  mov ax, num
  mov bx, 10

  ciclo:
    cmp ax, 0
    je sig
    mov dx, 0
    div bx
    push dx
    inc cx
    jmp ciclo

  sig:
    cmp cx, 0
    jne imprimir
    printChar 30h
    jmp end
  
  imprimir:
    pop dx
    add dl, 30h
    printChar dl
    loop imprimir

  end:
    pop bx
endm


inicio:
  printStr msg_1
  call input
  cmp bl, 0
  ja guardar

  printStr msg_primos
  printChar 30h
  printStr msg_total
  printChar 30h
  jmp fin

guardar:
  mov cx, bx
  mov dx, bx
  printStr msg_2

ciclo_guardar:
  printStr msg_salto
  call input
  push bx
  loop ciclo_guardar

procesar:
  mov si, offset info
  mov [si], dl
  inc si
  mov cl, dl
  mov bx, 0
  mov dx, 0

evaluar:
  pop ax
  mov ah, 0
  add bx, ax
  add dx, ax
  inc [si]
  push bx
  push cx
  mov cl, 2
  mov bl, al

  evaluar_primo:
    cmp cl, bl
    jae es_primo
    mov ah, 0
    div cl
    cmp ah, 0
    je no_es_primo
    mov al, bl
    inc cl
    jmp evaluar_primo
  
  es_primo:
    cmp bl, 1
    ja evaluar_primo_fin

  no_es_primo:
    mov bh, 0
    sub dx, bx
    dec [si]

  evaluar_primo_fin:
    pop cx
    pop bx
  loop evaluar

resultados:
  printStr msg_primos
  mov ax, dx
  mov cx, [si]
  mov ch, 0
  mov dx, 0
  div cx
  print ax

  printStr msg_total
  print bx

fin: int 20h


input proc
  push cx
  mov cx, 2
  mov bl, 0

ciclo:
  mov ah, 7
  int 21h
  cmp al, 13
  je ciclo_end
  cmp al, 30h
  jb ciclo
  cmp al, 39h
  ja ciclo

  printChar al
  sub al, 30h
  xchg al, bl
  mov dh, 10
  mul dh
  add al, bl
  xchg bl, al
  loop ciclo

ciclo_end:
  pop cx
  mov bh, 0
ret
input endp


msg_1       db 13, 10, 'Ingrese N: $'
msg_2       db 2 dup(13, 10), 'Ingrese los valores:$'
msg_primos  db 2 dup(13, 10), 'El promedio de los primos es: $'
msg_total   db 13, 10, 'La normal de todos es: $'
msg_salto   db 13, 10, '$'
info        db 0, 0
