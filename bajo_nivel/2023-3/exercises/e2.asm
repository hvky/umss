; EDDY SEJAS ARZE   INFORMATICA
; 14442097          202202881


org 100h

; ##########     MACROS     ##########
include 'macros.asm'

printInput macro msg
    PrintStr msg
    mov dx, 0
endm

save macro dest, err, et
    call inputChar

    cmp al, 0Dh
    je dest
    cmp al, 30h
    jb err
    cmp al, 39h
    ja err
    cmp dl, 9
    ja err

    call saveP
    jmp et
endm

validator macro lim, c_, err
    cmp dl, 0
    je err
    cmp dl, lim
    ja err
    shl dx, c_
    or bx, dx
endm

error macro msg, et
    PrintStr msg
    mov bx, 0
    jmp et
endm

print macro l, r
    push ax
    shl ax, l
    shr ax, r
    call printP
    pop ax
endm


; ##########     PROGRAMA     ##########
start:
    pf:
        PrintStr msg_ingresar_1
        pf_day:
            printInput msg_day
            pf_day_loop: save pf_month, pf_error, pf_day_loop

        pf_month:
            validator 30, 0, pf_error
            printInput msg_month
            pf_month_loop: save pf_year, pf_error, pf_month_loop

        pf_year:
            validator 12, 5, pf_error
            printInput msg_year
            pf_year_loop: save pf_end, pf_error, pf_year_loop

    pf_error:
        error msg_error, pf

    pf_end:
        shl dx, 9
        or bx, dx
        mov si[aux], bx
        mov bx, 0

; ***************     Segunda Fecha     ***************
    sf:
        PrintStr msg_ingresar_2
        sf_day:
            printInput msg_day
            sf_day_loop: save sf_month, sf_error, sf_day_loop

        sf_month:
            validator 30, 0, sf_error
            printInput msg_month
            sf_month_loop: save sf_year, sf_error, sf_month_loop

        sf_year:
            validator 12, 5, sf_error
            printInput msg_year
            sf_year_loop: save sf_end, sf_error, sf_year_loop

    sf_error:
        error msg_error, sf

    sf_end:
        shl dx, 9
        or bx, dx

; ***************     Comparacion     ***************
    mov ax, si[aux]
    cmp ax, bx
    jae print_date

    push ax
    mov ax, bx
    pop bx

    print_date:
        PrintStr msg_fecha_reciente
        call printDateP

        mov cx, ax
        mov ax, bx
        PrintStr msg_fecha_pasada
        call printDateP

        ; cx -> reciente | ax -> pasado
        mov si, offset aux

        proccess_year:
            mov bx, cx
            mov dx, ax
            shr bx, 9
            shr dx, 9

            sub bl, dl
            push ax
            mov ax, bx
            mov bx, 365
            mul bx
            mov [si], ax
            pop ax

        proccess_month:
            mov bx, cx
            mov dx, ax
            shl bx, 7
            shl dx, 7
            shr bx, 12
            shr dx, 12

            cmp bl, dl
            jae proccess_month_aux

            sub dl, bl
            push ax
            mov ax, dx
            mov bx, 30
            mul bx
            sub [si], ax
            pop ax
            jmp proccess_day

            proccess_month_aux:
                sub bl, dl
                push ax
                mov ax, bx
                mov bx, 30
                mul bx
                add [si], ax
                pop ax

        proccess_day:
            ; no hace falta seguir guardando las fechas
            shl cx, 11
            shl ax, 11
            shr cx, 11
            shr ax, 11

            cmp cl, al
            jae proccess_day_aux

            sub al, cl
            sub [si], ax
            jmp print_diff

            proccess_day_aux:
                sub cl, al
                add [si], cx

        print_diff:
            PrintStr msg_diferencia
            mov ax, [si]
            mov cx, 0
            mov bx, 10

            print_diff_loop:
                cmp al, 0
                je print_diff_end

                div bx
                push dx
                mov dx, 0
                inc cx
                jmp print_diff_loop

            print_diff_end:
                cmp cx, 0
                ja print_diff_end_loop

                PrintChar 30h
                jmp end

            print_diff_end_loop:
                pop dx
                add dx, 30h
                PrintChar dl
                loop print_diff_end

end:
    int 20h


; ##########     PROCEDIMIENTOS     ##########
include 'procedimientos.asm'

saveP proc
    sub al, 30h
    push ax
    mov ax, dx
    mov dx, 0Ah
    mul dx
    mov dx, ax
    pop ax
    add dl, al
ret
saveP endp

printDateP proc
    print 11, 11
    PrintChar '/'
    print 7, 12
    PrintChar '/'
    PrintChar 32h
    PrintChar 30h
    print 0, 9
ret
printDateP endp

printP proc
    cmp al, 0
    je pass

    mov dl, 10
    div dl

    pass:
        add al, 30h
        add ah, 30h
        PrintChar al
        PrintChar ah
ret
printP endp


; ##########     VARIABLES     ##########
msg_ingresar_1     db 0Ah, 0Dh, 'Ingrese la primer fecha$'
msg_ingresar_2     db 2 dup(0Ah, 0Dh), 'Ingrese la segunda fecha$'
msg_fecha_reciente db 2 dup(0Ah, 0Dh), 'Fecha reciente: $'
msg_fecha_pasada   db 0Ah, 0Dh, 'Fecha pasada: $'
msg_diferencia     db 2 dup(0Ah, 0Dh), 'Dias de diferencia: $'
msg_day            db 0Ah, 0Dh, 'Dia (1 - 30): $'
msg_month          db 0Ah, 0Dh, 'Mes (1 - 12): $'
msg_year           db 0Ah, 0Dh, 'A', 0A4h, 'o (0 - 99): 20$'
msg_error          db 0Ah, 0Dh, 'Fecha no valida!$'
aux                dw 0
