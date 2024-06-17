org 100h

printChar macro c
  mov ah, 2
  mov dl, c
  int 21h
endm

printStr macro str
  mov dx, offset str
  mov ah, 9
  int 21h
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

search macro cad, data
  local ciclo, ciclo2, volver_a_empezar, incrementar, evaluar, fin
  mov di, offset data
  mov dx, 0

  ciclo:
    mov si, offset cad
    mov ch, 0
    mov cl, bl

  ciclo2:
    cmp [di], 0
    je volver_a_empezar
    cmp [di], 1
    je fin
    mov al, [si]
    cmp al, [di]
    jne volver_a_empezar
    inc si
    inc di
    loop ciclo2
  jmp evaluar

  volver_a_empezar:
    cmp [di], 1
    jbe incrementar
    inc di
    jmp volver_a_empezar
  
  incrementar:
    cmp [di], 1
    je fin
    inc di
    jmp ciclo

  evaluar:
    cmp [di], 1
    ja volver_a_empezar
    mov dx, 1
  fin:
endm


inicio:
  printStr msg_nombre
  inputStr 30
  printStr msg_ap_paterno
  inputStr 20
  printStr msg_ap_paterno
  inputStr 20
  printStr msg_carnet
  inputNum 15, 5

  printStr msg_telefono
  inputNum 15, 5
  cmp bl, 7
  jne barrio
  mov ah, 0
  mov cl, bl

ciclo_telefono:
  pop ax
  loop ciclo_telefono

  cmp al, 34h
  jne barrio
  mov si, offset aux
  mov [si], 1

barrio:
  printStr msg_barrio
  inputStr 30
  mov cl, bl
  mov si, offset barrio_cad
  mov ah, 0
  add si, cx

ciclo_barrio:
  pop ax
  dec si
  mov [si], al
  loop ciclo_barrio

  search barrio_cad, barrios
  mov si, offset aux
  inc si
  mov [si], dl

imprimir:
  mov si, offset aux
  cmp [si], 0
  je tel_no_factible
  inc si
  cmp [si], 0
  je bar_no_factible
  printStr msg_factible
  jmp fin

tel_no_factible:
  printStr msg_noF_tel
  printStr msg_noFactible
  jmp fin

bar_no_factible:
  printStr msg_noF_bar
  printStr msg_noFactible

fin: int 20h


msg_nombre      db 13, 10, 'Ingrese su nombre: $'
msg_ap_paterno  db 13, 10, 'Ingrese su apellido paterno: $'
msg_ap_materno  db 13, 10, 'Ingrese su apellido materno: $'
msg_carnet      db 13, 10, 'Ingrese su carnet de identidad: $'
msg_telefono    db 13, 10, 'Ingrese su telefono: 4$'
msg_barrio      db 13, 10, 'Ingrese su barrio/zona: $'
msg_noFactible  db 13, 10, 'No Factible$'
msg_factible    db 2 dup(13, 10), 'Factible$'
msg_noF_tel     db 2 dup(13, 10), 'El telefono no pertenece a la region!$'
msg_noF_bar     db 2 dup(13, 10), 'El barrio/zona no pertenece a Cercado!$'

barrios         db 'Muyurina', 0, 'Cala Cala', 0, 'Las Cuadras', 0
                db 'Sarco',    0, 'Hipodromo', 0, 'Ushpa Ushpa', 0
                db 'La Maica', 0, 'Jaihuayco', 0, 'Lacma',       1
aux             db 0, 0
barrio_cad      db 30 dup(0)