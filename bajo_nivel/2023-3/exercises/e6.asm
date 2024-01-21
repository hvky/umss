; EDDY SEJAS ARZE   INFORMATICA
; 14442097          202202881


org 100h

; ##########     MACROS     ##########
include 'macros.asm'

printInput macro msg
    PrintStr msg
    mov dx, 0
endm

input macro et_err, et_dest, et_loop
    call inputChar

    cmp al, 0Dh
    je et_dest
    cmp al, 30h
    jb et_err
    cmp al, 39h
    ja et_err
    cmp dx, 99
    ja et_err

    call inputP
    jmp et_loop
endm

error macro et_dest
    PrintStr msg_error
    jmp et_dest
endm

printNum macro num, diff, operator, signo
    push cx

    mov ch, 0
    mov cl, num
    call printNumP
    PrintStr operator

    ; mov ch, 0
    mov cl, diff
    call printNumP
    PrintStr msg_igual

    mov cx, bx
    PrintChar signo
    call printNumP
    PrintStr msg_salto

    pop cx
endm


; ##########     PROGRAMA     ##########
start:
    PrintStr msg

    fn: printInput msg_n1
        fn_input_loop: input fn_error, fn_save, fn_input_loop

        fn_error: error fn

        fn_save:
            cmp dx, 0FFh
            ja fn_error
            mov bx, dx

    sn: printInput MSG_N2
        sn_input_loop: input sn_error, sn_save, sn_input_loop

        sn_error: error sn

        sn_save:
            cmp dx, 0FFh
            ja sn_error

            cmp dx, bx
            jb sn_change

            mov cx, dx
            jmp tn

            sn_change:
                mov cx, bx
                mov bx, dx

    tn: printInput msg_n3
        tn_input_loop: input tn_error, tn_save, tn_input_loop

        tn_error: error tn

        tn_save:
            cmp dx, 0FFh
            ja sn_error

            cmp dx, bx
            jbe change_min
            cmp dx, cx
            jb change_mid
            jmp evaluate

            change_min:
                push bx
                mov bx, dx
                mov dx, cx
                pop cx
                jmp evaluate

            change_mid:
                push cx
                mov cx, dx
                pop dx

; ***************     Segunda Parte     ***************
; guardar en bx el resutado de las operaciones

    evaluate:
    add_:
        PrintStr msg_sep
        mov ax, 1

        add_loop:
            cmp al, 0Bh
            je sub_

            push bx
            mov bx, dx
            add bl, al
            printNum dl, al, msg_suma, 0
            pop bx

            inc al
            jmp add_loop

    sub_:
        PrintStr msg_sep
        mov ax, 1

        sub_loop:
            cmp al, 0Bh
            je mul_

            push bx
            mov dx, cx
            sub dx, ax
            js sub_signo

            mov bx, dx
            printNum cl, al, msg_resta, 0
            jmp sub_loop_pass

            sub_signo:
                mov bx, 0FFFFh
                sub bx, dx
                inc bx
                printNum cl, al, msg_resta, '-'

            sub_loop_pass:
                pop bx
                inc al
                jmp sub_loop

    mul_:
        PrintStr msg_sep
        mov cx, bx
        mov ax, 1

        mult_loop:
            cmp al, 0Bh
            je end

            push ax
            mul cx
            mov bx, ax
            pop ax
            printNum cl, al, msg_mult, 0

            inc al
            jmp mult_loop

end:
    int 20h


; ##########     PROCEDIMIENTOS     ##########
include 'procedimientos.asm'

inputP proc
    sub al, 30h
    push ax
    mov ax, dx
    mov dx, 10
    mul dx
    mov dx, ax
    pop ax
    add dl, al
ret
inputP endp

printNumP proc
    push ax
    push dx
    push bx
    mov ax, cx
    mov bx, 10
    mov cx, 0

    cmp ax, 0
    ja print_loop
    PrintChar 30h
    jmp print_num_end

    print_loop:
        cmp ax, 0
        je print_end

        mov dx, 0
        div bx
        push dx
        inc cx
        jmp print_loop

    print_end:
        pop dx
        add dl, 30h
        PrintChar dl
        loop print_end

    print_num_end:
        pop bx
        pop dx
        pop ax
ret
printNumP endp


; ##########     VARIABLES     ##########    
msg       db 0Ah, 0Dh, 'Ingresar 3 numeros en el rango [0 - 255]$'
msg_n1    db 0Ah, 0Dh, 'Primer numero: $'
msg_n2    db 0Ah, 0Dh, 'Segundo numero: $'
msg_n3    db 0Ah, 0Dh, 'Tercer numero: $'
msg_suma  db ' + $'
msg_resta db ' - $'
msg_mult  db ' x $'
msg_igual db ' = $'
msg_salto db 0Ah, 0Dh, 24h
msg_sep   db 2 dup(0Ah, 0Dh), 20 dup('*'), 2 dup(0Ah, 0Dh), 24h
msg_error db 2 dup(0Ah, 0Dh), 'Numero no valido!', 2 dup(0Ah, 0Dh), 24h
