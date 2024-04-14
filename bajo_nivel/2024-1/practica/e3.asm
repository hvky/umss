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
  mov dl, c
  mov ah, 2
  int 21h
  pop ax
endm

print2k macro incr, desp, lim
  local ciclo, pass
  mov cl, 0

  ciclo:
    cmp cl, lim
    je inicio
    mov bx, ax
    shl bx, cl
    shr bx, desp
    cmp bl, 9
    jbe pass
    add bl, 7

  pass:
    add bl, 30h
    printChar bl
    add cl, incr
    jmp ciclo
endm

inputOp macro op1, op2, op3, op4 lim_inf
  local ciclo

  ciclo:
    mov ah, 7
    int 21h
    cmp al, lim_inf
    jb ciclo
    cmp al, 34h
    ja ciclo

  printChar al
  cmp al, 31h
  je op1
  cmp al, 32h
  je op2
  cmp al, 33h
  je op3
  cmp al, 34h
  je op4
endm

inputVal macro msg
  local ciclo, ciclo2, error, end_ciclo

  mov cx, 10
  ciclo:
    printStr msg
    mov bx, 0

  ciclo2:
    mov ah, 7
    int 21h
    cmp al, 13
    je end_ciclo
    cmp al, 30h
    jb ciclo2
    cmp al, 39h
    ja ciclo2

    printChar al
    sub al, 30h
    mov ah, 0
    xchg ax, bx
    mul cx
    add ax, bx
    xchg ax, bx
    cmp bx, 0FFh
    ja error
    jmp ciclo2
  
  error:
    printStr valor_erroneo
    jmp ciclo

  end_ciclo:
endm


inicio:
  printStr menu
  mov si, offset valores
  inputOp input_valores, input_operacion, input_base, resultado, 30h
  jmp fin

input_valores:
  inputVal msg_valor_1
  mov [si], bl
  inc si
  inputVal msg_valor_2
  mov [si], bl
  mov di, offset hay_valores
  mov [di], 1
  jmp inicio

input_operacion:
  add si, 2
  printStr msg_op_operacion
  inputOp op_suma, op_resta, op_multiplicacion, op_division, 31h
  op_suma:            mov [si], 1
                      jmp inicio
  op_resta:           mov [si], 2
                      jmp inicio
  op_multiplicacion:  mov [si], 3
                      jmp inicio
  op_division:        mov [si], 4
                      jmp inicio

input_base:
  add si, 3
  printStr msg_op_base
  inputOp b_binario, b_decimal, b_octal, b_hexadecimal, 31h
  b_binario:      mov [si], 1
                  jmp inicio
  b_decimal:      mov [si], 2
                  jmp inicio
  b_octal:        mov [si], 3
                  jmp inicio
  b_hexadecimal:  mov [si], 4
                  jmp inicio

resultado:
  mov di, offset hay_valores
  cmp [di], 0
  je resultados_error_num

  add si, 2
  cmp [si], 0
  je resultados_error_operacion
  inc si
  cmp [si], 0
  je resultados_error_base

  printStr msg_resultado
  sub si, 3
  mov al, [si]
  inc si
  mov bl, [si]
  inc si
  mov ah, 0
  mov bh, 0

  cmp [si], 1
  je sumar
  cmp [si], 2
  je restar
  cmp [si], 3
  je multiplicar

  dividir:
    cmp bl, 0
    jne dividir_no_error
    printStr operacion_inv
    jmp inicio

    dividir_no_error:
      div bl
      mov ah, 0
      jmp imprimir_resultado

  multiplicar:
    mul bx
    jmp imprimir_resultado

  restar:
    sub ax, bx
    jns imprimir_resultado
    printChar '-'
    mov cl, 0FFh
    sub cl, al
    inc cl
    mov al, cl
    mov ah, 0
    jmp imprimir_resultado

  sumar:
    add ax, bx

imprimir_resultado:
  mov si, offset valores
  add si, 3
  cmp [si], 1
  je binario
  cmp [si], 2
  je decimal
  cmp [si], 3
  je octal

  hexadecimal:  print2k 4, 12, 16
  binario:      print2k 1, 15, 16

  octal:
    mov bx, ax
    shr bx, 13
    add bl, 30h
    printChar bl
    shl ax, 1
    print2k 3, 13, 15

  decimal:
    mov bx, 10
    mov cx, 0
    cmp ax, 0
    jne ciclo_decimal
    printChar 30h
    jmp ciclo_decimal_fin

    ciclo_decimal:
      cmp ax, 0
      je ciclo_imprimir_decimal
      mov dx, 0
      div bx
      push dx
      inc cl
      jmp ciclo_decimal

    ciclo_imprimir_decimal:
      pop ax
      add al, 30h
      printChar al
      loop ciclo_imprimir_decimal

  ciclo_decimal_fin:
    jmp inicio

resultados_error_num:       printStr msg_sin_valores
                            jmp inicio
resultados_error_operacion: printStr msg_sin_operacion
                            jmp inicio
resultados_error_base:      printStr msg_sin_base
                            jmp inicio

fin:
  printStr msg_fin
  int 20h


menu              db 2 dup(13, 10), '1) Ingresar numeros'
                  db 13, 10, '2) Ingresar operacion'
                  db 13, 10, '3) Ingresar base'
                  db 13, 10, '4) Mostrar resultado',
                  db 13, 10, '0) Salir', 13, 10, '$'
msg_fin           db 13, 10, 'Finalizando el programa...$'
msg_sin_valores   db 13, 10, 'Falta ingresar los valores!$'
msg_sin_operacion db 13, 10, 'Falta ingresar la operacion!$'
msg_sin_base      db 13, 10, 'Falta ingresar la base!$'
msg_resultado     db 13, 10, 'El resultado es: $'
msg_op_operacion  db 13, 10, 'Seleccione el operador 1)Suma, 2)Resta, 3)Multiplicacion, 4)Division: $'
msg_op_base       db 13, 10, 'Seleccione la base 1)Binario, 2)Decimal, 3)Octal, 4)Hexadecimal: $'
operacion_inv     db 13, 10, 'Error, no se puede dividir entre 0!$'
msg_valor_1       db 13, 10, 'Ingrese el primer valor [0 - 255]: $'
msg_valor_2       db 13, 10, 'Ingrese el segundo valor [0 - 255]: $'
valor_erroneo     db 13, 10, 'El valor es muy grane!, ingrese otro$'

hay_valores       db 0
valores           db 0, 0, 0, 0
