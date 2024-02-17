; EDDY SEJAS ARZE   INFORMATICA
; 14442097          202202881


org 100h

; ##########     MACROS     ##########
include 'macros.asm'
GuardarRegistro macro pos
    mov si, offset registro + pos
    mov [si], bl
    mov [si + 1], bh
endm


; ##########     PROGRAMA     ##########
start:
    call mostrarMsg
    input_cadena_letras:
        call inputChar
        cmp al, 0Dh
        je procesar_letras

        inc cx
        push ax
        jmp input_cadena_letras

    procesar_letras:
        cmp cx, 0
        je segunda_parte

        mov si, offset mayusculas
        mov di, offset minusculas

        ciclo_procesar_letras:
            pop ax
            cmp al, 41h
            jb ciclo_procesar_letras_pass
            cmp al, 7Ah
            ja ciclo_procesar_letras_pass
            cmp al, 5Ah
            jbe guardar_may
            cmp al, 61h
            jb ciclo_procesar_letras_pass

            mov [di], al
            inc bh
            inc di
            jmp ciclo_procesar_letras_pass

            guardar_may:
                mov [si], al
                inc bl
                inc si

            ciclo_procesar_letras_pass:
                loop ciclo_procesar_letras

        GuardarRegistro 0


    segunda_parte:
        call mostrarMsg
        input_cadena_numeros:
            call inputChar
            cmp al, 0Dh
            je procesar_numeros

            inc cx
            push ax
            jmp input_cadena_numeros

        procesar_numeros:
            cmp cx, 0
            je imprimir

            mov si, offset numeros
            mov di, offset caracteres
            mov bx, 0

            ciclo_procesar_numeros:
                pop ax
                cmp al, 30h
                jb guardar_car
                cmp al, 7Ah
                ja guardar_car
                cmp al, 60h
                ja ciclo_procesar_numeros_pass
                cmp al, 5Ah
                ja guardar_car
                cmp al, 40h
                ja ciclo_procesar_numeros_pass
                cmp al, 39h
                ja guardar_car

                mov [si], al
                inc si
                inc bl
                jmp ciclo_procesar_numeros_pass

                guardar_car:
                    mov [di], al
                    inc di
                    inc bh

                ciclo_procesar_numeros_pass:
                    loop ciclo_procesar_numeros

            GuardarRegistro 2


    imprimir:
        PrintStr msg_mayusculas
        mov di, offset registro
        mov bx, [di]
        mov bh, 0
        mov si, offset mayusculas
        add si, bx

        imprimir_mayusuculas:
            cmp bl, 0
            je print_minusculas

            call print
            jmp imprimir_mayusuculas

        print_minusculas:
            PrintStr msg_minusculas
            inc di
            mov bx, [di]
            mov bh, 0
            mov si, offset minusculas
            add si, bx

            imprimir_minusculas:
                cmp bl, 0
                je print_numeros

                call print
                jmp imprimir_minusculas

        print_numeros:
            PrintStr msg_numeros
            inc di
            mov bx, [di]
            mov bh, 0
            mov si, offset numeros
            add si, bx

            imprimir_numeros:
                cmp bl, 0
                je print_caracteres

                call print
                jmp imprimir_numeros

        print_caracteres:
            PrintStr msg_caracteres
            inc di
            mov bx, [di]
            mov bh, 0
            mov si, offset caracteres
            add si, bx

            imprimir_caracteres:
                cmp bl, 0
                je end

                call print
                jmp imprimir_caracteres

end:
    int 20h


; ##########     PROCEDIMIENTOS     ##########
include 'procedimientos.asm'
mostrarMsg proc
    PrintStr msg_cadena
    mov cx, 0
    ret
mostrarMsg endp

print proc
    dec si
    PrintStr msg_salto
    PrintChar [si]
    dec bl
    ret
print endp


; ##########     VARIABLES     ##########
msg_cadena     db 0Ah, 0Dh, 'Ingrese una cadena: $'
msg_mayusculas db 0Ah, 0Dh, 'Mayusculas:$'
msg_minusculas db 0Ah, 0Dh, 'Minusculas:$'
msg_numeros    db 0Ah, 0Dh, 'Numeros:$'
msg_caracteres db 0Ah, 0Dh, 'Caracteres:$'
msg_salto      db 0Ah, 0Dh, 24h
mayusculas     db 255 dup(0)
minusculas     db 255 dup(0)
numeros        db 255 dup(0)
caracteres     db 255 dup(0)
registro       db 4 dup(0)
