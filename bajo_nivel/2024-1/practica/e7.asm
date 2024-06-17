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

sort macro vls, n
  local ciclo, ciclo_interno, ciclo_pass
  mov si, offset vls
  mov cx, 3

  ciclo:
    mov al, [si]
    mov bl, cl
    push si

  ciclo_interno:
    cmp bl, n
    je ciclo_pass
    dec si
    cmp al, [si]
    jae ciclo_pass

    mov ah, [si]
    mov [si], al
    inc si
    mov [si], ah
    dec si
    inc bl
    jmp ciclo_interno

  ciclo_pass:
    pop si
    inc si
    loop ciclo
endm

print macro num
  local ciclo, end
  push bx
  push cx
  xor bx, bx
  mov bx, num
  mov ch, 10
  mov cl, 6

  ciclo:
    cmp ch, 0
    je end

    push bx
    shl bx, cl
    shr bx, 0Fh
    add bl, 30h
    printChar bl
    inc cl
    dec ch
    pop bx
    jmp ciclo

  end:
    pop cx
    pop bx
endm

printOperacion macro op, cnt
  printStr msg_salto
  printHexa [si]
  printChar 0FFh
  printChar op
  printChar 0FFh
  printHexa cnt
  printChar 0FFh
  printChar 61
  printChar 0FFh
endm

printHexa macro num
  local pass, pass2
  push bx
  mov bh, 0
  mov bl, num

  ror bx, 4
  add bl, 30h
  cmp bl, 39h
  jbe pass
  add bl, 7
  pass: printChar bl
  
  shr bx, 12
  add bl, 30h
  cmp bl, 39h
  jbe pass2
  add bl, 7
  pass2: printChar bl

  pop bx
endm


inicio:
  mov si, offset valores
  printStr msg_primer
  call input
  mov [si], bl
  inc si
  printStr msg_segundo
  call input
  mov [si], bl
  inc si
  printStr msg_tercero
  call input
  mov [si], bl

  sort valores, 3
  mov si, offset valores

suma:
  printStr msg_salto
  printStr msg_suma
  add si, 2
  mov bx, 1

ciclo_suma:
  cmp bl, 11h
  je division
  printOperacion '+', bl
  mov al, [si]
  mov ah, 0
  mov bh, 0
  add ax, bx
  print ax
  inc bl
  jmp ciclo_suma

division:
  printStr msg_salto
  printStr msg_div
  dec si
  mov bx, 1

ciclo_division:
  cmp bl, 11h
  je resta
  printOperacion 246, bl
  mov dx, 0
  mov ax, 0
  mov al, [si]
  div bx
  print ax
  inc bl
  jmp ciclo_division

resta:
  printStr msg_salto
  printStr msg_resta
  dec si
  mov bx, 1

ciclo_resta:
  cmp bl, 11h
  je fin
  printOperacion '-', bl
  mov al, [si]
  sub al, bl
  jns ciclo_resta_sig
  printChar '-'
  mov cl, 0FFh
  sub cl, al
  inc cl
  ciclo_resta_sig: print cx
  inc bl
  jmp ciclo_resta

fin: int 20h


input proc
  mov ah, 7
  mov cx, 2
  mov bx, 0

  ciclo:
    int 21h
    cmp al, 30h
    jb ciclo
    cmp al, 'F'
    ja ciclo
    cmp al, 'A'
    jae ciclo_pass
    cmp al, 39h
    ja ciclo

  ciclo_pass:
    printChar al
    sub al, 30h
    cmp al, 9
    jbe ciclo_pass_2
    sub al, 7

  ciclo_pass_2:
    push ax
    mov ah, 0
    or bx, ax
    shl bx, 4
    pop ax
    loop ciclo

  shr bx, 4
  ret
input endp


msg_primer  db 13, 10, 'Ingrese el primer numero: $'
msg_segundo db 13, 10, 'Ingrese el segundo numero: $'
msg_tercero db 13, 10, 'Ingrese el tercer numero: $'
msg_salto   db 13, 10, '$'
msg_suma    db 13, 10, 'Tabla de Suma:$'
msg_div     db 13, 10, 'Tabla de Division:$'
msg_resta   db 13, 10, 'Tabla de Resta:$'
valores     db 3 dup(0)
