; EDDY SEJAS ARZE   INFORMATICA
; 14442097          202202881


org 100h

; ##########     MACROS     ##########
include 'macros.asm'

inputNum macro sig, val, err
    call inputChar
    cmp al, 0Dh
    je val
    cmp al, 30h
    jb err
    cmp al, 39h
    ja err

    cmp bx, 99
    ja err

    call inputNumP
    jmp sig
endm

imprimir macro b_, c_
    mov bx, b_
    mov cl, 0
    mov ch, c_
    call print_loop
endm


; ##########     PROGRAMA     ##########
start:
    PrintStr msg_ini

    fn: mov bx, 0
        PrintStr msg_fn
        fn_input: inputNum fn_input, fn_validar, fn_error
        fn_error: PrintStr msg_error
                  jmp fn
        fn_validar:
            cmp bx, 0FFh
            ja fn_error
            mov ch, 0
            mov cl, bl

    sn: mov bx, 0
        PrintStr msg_sn
        sn_input: inputNum sn_input, sn_validar, sn_error
        sn_error: PrintStr msg_error
                  jmp sn
        sn_validar:
            cmp bx, 0FFh
            ja sn_error

    ; primer numero -> cx | segundo numero -> bx
    op: PrintStr msg_op
        call inputChar
        cmp al, '+'
        je sumar
        cmp al, '-'
        je restar
        cmp al, '*'
        je multiplicar
        cmp al, '/'
        je dividir
        PrintStr msg_error
        jmp op

        sumar:
            add cx, bx
            mov ax, cx
            jmp sis

        restar:
            sub cx, bx
            jns restar_pass

            mov ax, 0FFFFh
            sub ax, cx
            inc ax
            mov si[negativo], '-'
            jmp sis

            restar_pass:
                mov ax, cx
                jmp sis

        multiplicar:
            mov ax, cx
            mul bx
            jmp sis

        dividir:
            cmp bx, 0
            je error
            mov ax, cx
            div bx
            jmp sis

            error:
                PrintStr msg_error
                jmp end

    ; resultado -> ax
    sis:
        PrintStr msg_sis
        push ax
        call inputChar
        mov bl, al
        pop ax

        cmp bl, 'B'
        je binario
        cmp bl, 'D'
        je decimal
        cmp bl, 'H'
        je hexadecimal
        ; cmp bl, 'b'
        ; je binario
        ; cmp bl, 'd'
        ; je decimal
        ; cmp bl, 'h'
        ; je hexadecimal
        PrintStr msg_error
        jmp sis

        binario:
            call otp
            mov cx, 10h

            binario_loop:
                mov dx, ax
                push cx
                mov bx, cx
                mov cx, 10h
                sub cx, bx
                shl dx, cl
                pop cx

                shr dx, 0Fh
                add dl, 30h
                PrintChar dl
                loop binario_loop
            jmp end

        decimal:
            call otp
            mov bx, 0Ah
            mov cx, 0

            decimal_loop:
                cmp ax, 0
                je decimal_print

                mov dx, 0
                div bx
                push dx
                inc cx
                jmp decimal_loop

            decimal_print:
                pop dx
                add dl, 30h
                PrintChar dl
                loop decimal_print
            jmp end

        hexadecimal:
            call otp
            mov cx, 4
            mov bx, 0

            hexadecimal_loop:
                mov dx, ax
                push cx
                mov cx, bx
                shl dx, cl
                pop cx
                shr dx, 0Ch
                add bx, 4

                add dl, 30h
                cmp dl, 39h
                jbe print_hexa

                add dl, 7
                print_hexa:
                    PrintChar dl
                    loop hexadecimal_loop

end:
    int 20h


; ##########     PROCEDIMIENTOS     ##########
include 'procedimientos.asm'

inputNumP proc
    sub al, 30h
    mov ah, 0
    push ax
    mov ax, bx
    mov dx, 10
    mul dx
    pop bx
    add bx, ax
ret
inputNumP endp

otp proc
    PrintStr msg_res
    PrintChar negativo
ret
otp endp


; ##########     VARIABLES     ##########
msg_ini   db 0Ah, 0Dh, 56 dup('*')
          db 0Ah, 0Dh, '*', 54 dup(0), '*'
          db 0Ah, 0Dh, '*   Ingrese dos numeros en sistema decimal [0 - 255]   *'
          db 0Ah, 0Dh, '*', 54 dup(0), '*'
          db 0Ah, 0Dh, 56 dup('*'), 24h
msg_fn    db 2 dup(0Ah, 0Dh), 'Primer numero: $'
msg_sn    db 0Ah, 0Dh, 'Segundo numero: $'
msg_res   db 0Ah, 0Dh, 'Resultado: $'
msg_op    db 0Ah, 0Dh, 'Ingrese una operacion (+ - * /): $'
msg_sis   db 0Ah, 0Dh, 'Seleccione el sistema numerico (B D H): $'
msg_error db 2 dup(0Ah, 0Dh), 'Operacion no valida!', 0Ah, 0Dh, 24h
negativo  db 0
