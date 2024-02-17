; EDDY SEJAS ARZE   INFORMATICA
; 14442097          202202881


org 100h

; ##########     MACROS     ##########
include 'macros.asm'

imprimir macro b_, c_
    mov bx, b_
    mov cl, 0
    mov ch, c_
    call print_loop
endm


; ##########     PROGRAMA     ##########
start:
    fn: PrintStr msg_ingresar_fn
        mov cx, 0

        fn_input:
            call inputChar
            cmp al, 0Dh
            je fn_validar

            push ax
            inc cx
            jmp fn_input

        fn_validar:
            cmp cx, 2
            ja fn_error
            cmp cx, 0
            je fn_zero

            pop bx
            sub bl, 30h
            cmp bl, 9
            jbe fn_validar_pass
            sub bl, 7
            fn_validar_pass:

            cmp cx, 1
            je fn_save
            pop ax
            sub al, 30h
            cmp al, 9
            jbe fn_validar_pass_2
            sub al, 7
            fn_validar_pass_2:

            mov ah, 0
            mov cx, 10h
            mul cx
            add bl, al
            fn_save:
                mov dx, bx
                jmp op

            fn_error:
                PrintStr msg_error_num
                jmp fn
            fn_zero:
                mov ax, 0


    op: PrintStr msg_ingresar_signo
        call inputChar
        mov si[operador], al


    sn: PrintStr msg_ingresar_sn
        mov cx, 0

        sn_input:
            call inputChar
            cmp al, 0Dh
            je sn_validar

            push ax
            inc cx
            jmp sn_input

        sn_validar:
            cmp cx, 2
            ja sn_error
            cmp cx, 0
            je sn_zero

            pop bx
            sub bl, 30h
            cmp bl, 9
            jbe sn_validar_pass
            sub bl, 7
            sn_validar_pass:

            cmp cx, 1
            je sn_save
            pop ax
            sub al, 30h
            cmp al, 9
            jbe sn_validar_pass_2
            sub al, 7
            sn_validar_pass_2:

            mov ah, 0
            mov cx, 10h
            push dx
            mul cx
            add bl, al
            pop dx
            sn_save: jmp change

            sn_error:
                PrintStr msg_error_num
                jmp sn
            sn_zero:
                mov ax, 0


    ; DEJAR EN AX PRIMER NUMERO
    ; DEJAR EN BX SEGUNDO NUMERO
    ; DEJAR EN CL LA OPERACION
    change:
        mov bh, 0
        mov al, dl
        mov ah, 0
        mov cl, si[operador]

    operar:
        cmp cl, '+'
        je sumar
        cmp cl, '-'
        je restar
        cmp cl, '*'
        je multiplicar
        cmp cl, '/'
        je dividir
        jmp error

        sumar:
            add ax, bx
            jmp imprimir_

        restar:
            sub ax, bx
            jns positivo

            mov bx, 0FFFFh
            sub bx, ax
            inc bx
            mov ax, bx

            mov si, offset negativo
            mov [si], 1
            positivo: jmp imprimir_

        multiplicar: mul bx
                     jmp imprimir_

        dividir:
            cmp bx, 0
            je error
            mov dx, 0
            div bx
            jmp imprimir_

    imprimir_:
        mov si, offset negativo

        PrintStr msg_resultado_hexa
        cmp [si], 0
        je imprimir_hexa
        PrintChar '-'
        imprimir_hexa:
            imprimir 4, 4

        PrintStr msg_resultado_bin
        cmp [si], 0
        je imprimir_bin
        PrintChar '-'
        imprimir_bin:
            imprimir 16, 1
        jmp end

error: PrintStr msg_error

end: int 20h


; ##########     PROCEDIMIENTOS     ##########
include 'procedimientos.asm'

validator proc
    cmp al, 030h
    jb error
    cmp al, 46h
    ja error
    cmp al, 39h
    jbe end_validator
    cmp al, 41h
    jb error
    end_validator: ret
validator endp

print_loop proc
    loop_print:
        cmp bl, 0
        je end_print

        call convert
        PrintChar dl

        add cl, ch
        dec bx
        jmp loop_print

    end_print: ret
print_loop endp

convert proc
    push ax
    shl ax, cl
    push cx

    mov cl, 10h
    sub cl, ch
    shr ax, cl
    mov dx, ax

    pop cx
    pop ax

    add dl, 030h
    cmp dl, 3Ah
    jb end_convert
    add dl, 7
    end_convert: ret
convert endp


; ##########     VARIABLES     ##########
msg_ingresar_fn    db 0Ah, 0Dh, 'Ingrese el primer numero entre [0 - FF]: $'
msg_ingresar_sn    db 0Ah, 0Dh, 'Ingrese el segundo numero entre [0 - FF]: $'
msg_ingresar_signo db 0Ah, 0Dh, 'Ingrese un una operacion (+ - * /): $'
msg_resultado_hexa db 2 dup(0Ah, 0Dh), 'Resultado en Hexadecimal: $'
msg_resultado_bin  db 0Ah, 0Dh, 'Resultado en Binario: $'
msg_error_num      db 0Ah, 0Dh, 'Numero no valido$'
msg_error          db 0Ah, 0Dh, 'La operacion no es valida$'
operador           db 0
negativo           db 0
