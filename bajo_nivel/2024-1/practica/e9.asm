org 100h

printStr macro str
  push ax
  mov dx, offset str
  mov ah, 9
  int 21h
  pop ax
endm

printChar macro c
  push ax
  push dx
  mov dl, c
  mov ah, 2
  int 21h
  pop dx
  pop ax
endm

printDecimal macro n
  local ciclo, ciclo_sig
  mov al, n
  mov dl, 10
  mov cx, 0

  ciclo:
    cmp al, 0
    je ciclo_sig
    mov ah, 0
    div dl
    push ax
    mov ah, 0
    inc cx
    jmp ciclo

  ciclo_sig:
    pop ax
    add ah, 30h
    printChar ah
    loop ciclo_sig
endm

sort macro cad, aux
  local ciclo, ciclo_interno, ciclo_interno2, ciclo_interno_pass, ciclo_pass, cambiar
  mov cx, 10
  mov al, 0
  mov bl, 0

  ciclo:
    mov si, offset cad
    mov ah, 0
    add si, ax
    mov bh, bl
    push si

  ciclo_interno:
    cmp bh, 0
    je ciclo_pass
    mov ah, al

  ciclo_interno2:
    cmp [di], 0
    je ciclo_pass
    cmp [si], 0
    je cambiar
    mov dl, [si]
    cmp dl, [di]
    jbe cambiar
    jmp ciclo_interno_pass

  cambiar:
    sub ah, 21
    intercambio cad
    intercambio aux

  ciclo_interno_pass:
    dec bh
    jmp ciclo_interno

  ciclo_pass:
    pop si
    mov di, si
    inc bl
    add al, 21
    loop ciclo
endm

intercambio macro cad
  local ciclo
  push cx
  push ax
  mov cx, 20
  mov si, offset cad
  shr ax, 8
  add si, ax
  mov di, si
  add di, 21

  ciclo:
    mov al, [si]
    mov ah, [di]
    mov [di], ah
    mov [si], al
    loop ciclo
  
  pop ax
  pop cx
endm

print macro cad
  local ciclo, end
  mov si, offset cad
  add si, bx

  ciclo:
    cmp [si], 0
    je end
    printChar [si]
    inc si
    jmp ciclo

  end:
endm


inicio:
  printStr msg_1
  mov bl, 1

c_input:
  cmp bl, 11
  je c_input_end
  printStr msg_sal
  printDecimal bl
  printStr msg_2
  mov si, offset partes
  call input
  printStr msg_sal
  printDecimal bl
  printStr msg_3
  mov si, offset marcas
  call input
  inc bl
  jmp c_input

c_input_end:
  printStr msg_4
  mov ah, 7
  mov cx, 10

input_op:
  int 21h
  cmp al, 31h
  jb input_op
  cmp al, 32h
  ja input_op
  printChar al
  cmp al, 31
  je sort_parte

sort_marca:
  sort marcas, partes
  jmp imprimir

sort_parte:
  sort partes, marcas

imprimir:
  printStr msg_5
  mov cx, 10
  mov bx, 0

ciclo_imprimir:
  printStr msg_sal
  print partes
  printChar 9
  printChar 9
  printChar 9
  print marcas
  add bx, 21
  loop ciclo_imprimir

fin: int 20h


input proc
  mov al, bl
  dec al
  mov dl, 0

  cicloI_input:
    cmp al, 0
    je passI_input
    add si, 21
    dec al
    jmp cicloI_input

  passI_input:
    mov cx, 20

  ciclo_input:
    mov ah, 7
    int 21h
    cmp al, 13
    je end_input
    cmp al, ' '
    je pass_input
    cmp al, 'A'
    jb ciclo_input
    cmp al, 'z'
    ja ciclo_input
    cmp al, 'Z'
    jbe pass_input
    cmp al, 'a'
    jb ciclo_input

  pass_input:
    printChar al
    mov [si], al
    inc si
    inc dl
    loop ciclo_input

  end_input:
    cmp dl, 0
    je ciclo_input
ret
input endp


msg_1   db 13, 10, 'Ingrese 10 partes con su respectiva marca$'
msg_2   db ' Parte: $'
msg_3   db ' Marca: $'
msg_4   db 13, 10, '1) Ordenar por parte, 2) Ordenar por marca: $'
msg_5   db 13, 10, 'Partes:', 3 dup(9), 'Marcas:$'
msg_sal db 13, 10, '$'
partes  db 0FFh dup(0)
marcas  db 0FFh dup(0)
