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

copy macro origen, destino, n
  local ciclo
  mov si, offset origen
  mov di, offset destino
  mov cl, n
  mov ch, 0

  ciclo:
    mov bl, [si]
    mov bh, [di]
    mov [si], bh
    mov [di], bl
    inc si
    inc di
    loop ciclo
endm

inputNum macro n
  local ciclo, end
  mov si, offset aux
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
    mov [si], al
    inc si
    inc bl
    loop ciclo

  end:
    cmp bl, 0
    je ciclo
endm

inputStr macro n
  local ciclo, guardar, end
  mov si, offset aux
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
    mov [si], al
    inc si
    inc bl
    loop ciclo

  end:
    cmp bl, 0
    je ciclo
endm

evaluar macro str, data, len
  mov al, 1
endm


inicio:
  printStr msg_nombre
  inputStr 30
  copy aux, nombre, bl
  printStr msg_ap_paterno
  inputStr 20
  copy aux, ap_paterno, bl
  printStr msg_ap_materno
  inputStr 20
  copy aux, ap_materno, bl
  printStr msg_carnet
  inputNum 15
  copy aux, carnet, bl

input_telefono:
  printStr msg_numero
  inputNum 20
  evaluar aux, numeros, bl
  cmp al, 1
  je input_ciudad
  printStr msg_error_num
  jmp input_telefono

input_ciudad:
  copy aux, numero, bl
  printStr msg_ciudad
  inputStr 20
  evaluar aux, ciudades, bl
  cmp al, 1
  je input_correo
  printStr msg_error_ciudad
  jmp input_ciudad

input_correo:
  copy aux, ciudad, bl
  printStr msg_correo


input_password:
  printStr msg_pass
  mov cl, 0FFh
  mov bl, 0
  mov si, offset aux

  input_password_ciclo:
    mov ah, 7
    int 21h
    cmp al, 13
    je input_password_ciclo_end
    printChar '*'
    mov [si], al
    inc si
    inc bl
    loop input_password_ciclo

  input_password_ciclo_end:
    cmp bl, 0
    je input_password_ciclo
    mov cl, bl
    xor ax, ax

  evaluar_password:
    dec si
    cmp [si], 30h
    jb evaluar_password_pass
    cmp [si], 39h
    ja evaluar_password_pass
    mov al, 1

  evaluar_password_pass:
    cmp [si], 'A'
    jb evaluar_password_pass2
    cmp [si], 'Z'
    ja evaluar_password_pass2
    mov ah, 1

  evaluar_password_pass2:
    loop evaluar_password

  cmp al, 0
  je password_error
  cmp ah, 0
  je password_error
  copy aux, password, bl
  jmp imprimir_datos

  password_error:
    printStr msg_error_pass
    jmp input_password

imprimir_datos:
  printStr msg_salto
  printStr msg__nombre
  printStr Nombre
  printChar 0FFh
  printStr ap_paterno
  printChar 0FFh
  printStr ap_materno
  printStr msg__carnet
  printStr carnet
  printStr msg__numero
  printStr numero
  printStr msg__ciudad
  printStr ciudad
  printStr msg__correo
  printStr correo
  printStr msg__pass
  printStr password

fin: int 20h


msg_nombre        db 13, 10, 'Ingrese su nombre: $'
msg_ap_paterno    db 13, 10, 'Ingrese su apellido paterno: $'
msg_ap_materno    db 13, 10, 'Ingrese su apellido materno: $'
msg_carnet        db 13, 10, 'Ingrese su carnet de identidad: $'
msg_numero        db 13, 10, 'Ingrese su numero de celular: +$'
msg_ciudad        db 13, 10, 'Ingrese su ciudad: $'
msg_correo        db 13, 10, 'Ingrese su correo: $'
msg_pass          db 13, 10, 'Ingrese su password: $'
msg_salto         db 13, 10, '$'
msg__nombre       db 13, 10, 'Nombre Completo: $'
msg__carnet       db 13, 10, 'Carnet de Identidad: $'
msg__numero       db 13, 10, 'Numero de Celular: $'
msg__ciudad       db 13, 10, 'Ciudad: $'
msg__correo       db 13, 10, 'Correo Electronico: $'
msg__pass         db 13, 10, 'Password: $'
msg_error_num     db 13, 10, 'El telefono no pertenece a Bolivia!', 13, 10, '$'
msg_error_ciudad  db 13, 10, 'La ciudad proporcionada no pertenece Bolivia!', 13, 10, '$'
msg_error_pass    db 13, 10, 'El password debe contener almenos un numero y una letra mayuscula!', 13, 10, '$'

ciudades          db 'Cochabamba', 0, 'Beni', 0
                  db 'Santa Cruz', 0, 'La Paz', 0
                  db 'Tarija', 0, 'Oruro', 0
                  db 'Pando', 0, 'Potosi', 0
                  db 'Chuquisaca', 0
numeros           db '5916', 0, '5917', 0
correos           db 'gmail', 0, 'hotmail', 0, 'yahoo'

nombre            db 31 dup('$')
ap_paterno        db 21 dup('$')
ap_materno        db 21 dup('$')
carnet            db 16 dup('$')
numero            db 21 dup('$')
ciudad            db 21 dup('$')
correo            db 51 dup('$')
password          db 100h dup('$')
aux               db 100h dup(0)
