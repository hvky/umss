
include 'emu8086.inc'
org 100h

inicio:
    mov cx, 10           ; Inicializa el contador para leer 10 caracteres para el nombre de usuario
    mov si, offset usuario   ; Inicializa el puntero al buffer 'usuario'
    mov bx, 0            ; Inicializa el contador de caracteres ingresados a 0
    print 'Ingrese Usuario:'

ciclo_usuario:
    mov ah, 7            ; Utiliza la interrupci�n 21h para leer un caracter sin eco
    int 21h
    cmp al, 13           ; Compara el caracter le�do con el retorno de carro (Enter)
    je actualizar_usuario         ; Salta a la etiqueta 'actualizar_usuario' si se presion� Enter
    mov [si], al         ; Almacena el caracter en el buffer 'usuario'
    mov dl, '*'          ; Muestra un asterisco en lugar del caracter ingresado
    mov ah, 2
    int 21h
    inc si               ; Mueve el puntero al siguiente elemento del buffer
    inc bl               ; Incrementa el contador de caracteres ingresados
    loop ciclo_usuario   ; Repite el ciclo hasta leer 10 caracteres para el nombre de usuario

actualizar_usuario:
    mov si, offset usuario   ; Reinicia el puntero al buffer 'usuario'
    mov dl, 13           ; Muestra un retorno de carro
    mov ah, 2
    int 21h
    mov dl, 10           ; Muestra un salto de l�nea
    int 21h
    mov cl, bl           ; Guarda la cantidad de caracteres ingresados en 'cl'
    print 'Su usuario es:'
    jmp mostrar_usuario  ; Salta a la etiqueta 'mostrar_usuario' para mostrar el nombre de usuario

mostrar_usuario:
    mov ah, 2            ; Utiliza la interrupci�n 21h para mostrar el nombre de usuario
    mov dl, [si]
    int 21h
    inc si               ; Mueve el puntero al siguiente caracter del buffer
    loop mostrar_usuario ; Repite hasta mostrar todos los caracteres del nombre de usuario

    mov cx, 10           ; Inicializa el contador para leer 10 caracteres para la contrase�a
    mov si, offset aux   ; Inicializa el puntero al buffer 'aux'
    mov bx, 0            ; Inicializa el contador de caracteres ingresados a 0
   
    mov dl, 13           ; Muestra un retorno de carro
    mov ah, 2
    int 21h
    mov dl, 10           ; Muestra un salto de l�nea
    int 21h
    print 'Ingrese Contrase�a:'

ciclo_contrase�a:
    mov ah, 7            ; Utiliza la interrupci�n 21h para leer un caracter sin eco
    int 21h
    cmp al, 13           ; Compara el caracter le�do con el retorno de carro (Enter)
    je actualizar_contrase�a         ; Salta a la etiqueta 'actualizar_contrase�a' si se presion� Enter
    mov [si], al         ; Almacena el caracter en el buffer 'aux'
    mov dl, '*'          ; Muestra un asterisco en lugar del caracter ingresado
    mov ah, 2
    int 21h
    inc si               ; Mueve el puntero al siguiente elemento del buffer
    inc bl               ; Incrementa el contador de caracteres ingresados
    loop ciclo_contrase�a   ; Repite el ciclo hasta leer 10 caracteres para la contrase�a

actualizar_contrase�a:
    mov si, offset aux   ; Reinicia el puntero al buffer 'aux'
    mov dl, 13           ; Muestra un retorno de carro
    mov ah, 2
    int 21h
    mov dl, 10           ; Muestra un salto de l�nea
    int 21h
    mov cl, bl           ; Guarda la cantidad de caracteres ingresados en 'cl'
    print 'Su contrase�a es:'
    jmp mostrar_contrase�a  ; Salta a la etiqueta 'mostrar_contrase�a' para mostrar la contrase�a

mostrar_contrase�a:
    mov ah, 2            ; Utiliza la interrupci�n 21h para mostrar la contrase�a
    mov dl, [si]
    int 21h
    inc si               ; Mueve el puntero al siguiente caracter del buffer
    loop mostrar_contrase�a ; Repite hasta mostrar todos los caracteres de la contrase�a

fin:
    int 20h               ; Termina el programa

usuario db dup(10)        ; Reserva espacio para el buffer 'usuario' de 10 bytes
aux db dup(10)            ; Reserva espacio para el buffer 'aux' de 10 bytes
