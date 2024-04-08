org 100h

printStr macro str
  push ax
  mov ah, 9
  mov dx, offset str
  int 21h
  pop ax
endm

printChar macro c
  push ax
  mov ah, 2
  mov dl, c
  int 21h
  pop ax
endm

print macro str, i
  local end
  mov dh, i
  shr dx, 8
  cmp dl, 0
  je end
  mov si, offset str
  add si, dx
  dec si
  printChar [si]
  dec i
end:
endm


inicio:
  printStr msg
  mov ah, 1
  mov cx, 0

input:
  int 21h
  cmp al, 13
  je procesar
  push ax
  inc cx
  jmp input

procesar:
  mov si, offset numbers
  mov di, offset characters
  xor ax, ax
  cmp cx, 0
  je fin

  ciclo_procesar:
    pop dx
    cmp dl, 30h
    jb character
    cmp dl, 7Ah
    ja character
    cmp dl, 39h
    jbe number
    cmp dl, 41h
    jb character
    cmp dl, 5Ah
    jbe upper
    cmp dl, 61h
    jb character

  lower:
    push si
    mov si, offset lowercase
    push ax
    mov ah, 0
    add si, ax
    pop ax
    mov [si], dl
    pop si
    inc al
    jmp ciclo_procesar_end
  
  character:
    mov [di], dl
    inc di
    inc bl
    jmp ciclo_procesar_end

  number:
    mov [si], dl
    inc si
    inc bh
    jmp ciclo_procesar_end

  upper:
    push di
    mov di, offset uppercase
    push ax
    shr ax, 8
    add di, ax
    pop ax
    mov [di], dl
    pop di
    inc ah

  ciclo_procesar_end:
    loop ciclo_procesar

imprimir:
  printStr msg_salto
  printStr msg_salto
  printStr msg_nums
  printChar 9
  printStr msg_cars
  printChar 9
  printStr msg_mays
  printChar 9
  printStr msg_mins

  call mayor
  ciclo_imprimir:
    printStr msg_salto
    print numbers, bh
    printStr msg_tab
    print characters, bl
    printStr msg_tab
    print uppercase, ah
    printStr msg_tab
    print lowercase, al
    loop ciclo_imprimir

fin: int 20h


mayor proc
  mov cl, al
  sub cl, bl
  js change_bl
  mov cl, al
  jmp pass_1
change_bl:
  mov cl, bl

pass_1:
  mov dl, ah
  sub dl, bh
  js change_bh
  mov dl, ah
  jmp pass_2
change_bh:
  mov dl, bh

pass_2:
  push ax
  mov al, cl
  sub al, dl
  jns pass_3
  mov cl, dl

pass_3:
  pop ax
  ret
mayor endp


msg         db 'Ingrese los caracteres: $'
msg_nums    db 'Numeros:$'
msg_cars    db 'Caracteres:$'
msg_mays    db 'Mayusculas:$'
msg_mins    db 'Minusculas:$'

msg_salto   db 13, 10, '$'
msg_tab     db 9, 9, '$'

numbers     db 100 dup(0)
characters  db 100 dup(0)
lowercase   db 100 dup(0)
uppercase   db 100 dup(0)
