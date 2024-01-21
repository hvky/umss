; EDDY SEJAS ARZE   INFORMATICA
; 14442097          202202881


org 100h

; ##########     MACROS     ##########
include 'macros.asm'


; ##########     PROGRAMA     ##########
start:
    PrintStr msg_bienvenida

    input_usuario:
        mov cx, 0
        PrintStr msg_usuario

        input_usuario_loop:
            call inputChar
            cmp al, 0Dh
            je input_usuario_save
            push ax
            inc cx
            jmp input_usuario_loop

        input_usuario_save:
            cmp cx, 0
            je error_empty_usuario
            mov si, offset usuario
            add si, cx
            jmp input_usuario_save_loop

            error_empty_usuario:
                PrintStr msg_empty
                jmp input_usuario

            input_usuario_save_loop:
                pop ax
                dec si
                mov [si], al
                loop input_usuario_save_loop

    input_nombre:
        mov cx, 0
        PrintStr msg_nombre

        input_nombre_loop:
            call inputChar
            cmp al, 0Dh
            je input_nombre_save
            cmp al, 'A'
            jb input_error_nombre
            cmp al, 'z'
            ja input_error_nombre
            cmp al, 'a'
            jae input_nombre_loop_pass
            cmp al, 'Z'
            jbe input_nombre_loop_pass

            input_error_nombre:
                PrintStr msg_error
                jmp input_nombre

            input_nombre_loop_pass:
                push ax
                inc cx
                jmp input_nombre_loop

        input_nombre_save:
            cmp cx, 0
            je error_empty_nombre
            mov si, offset nombre
            add si, cx
            jmp input_nombre_save_loop

            error_empty_nombre:
                PrintStr msg_empty
                jmp input_nombre

            input_nombre_save_loop:
                pop ax
                dec si
                mov [si], al
                loop input_nombre_save_loop

    input_ap_pat:
        mov cx, 0
        PrintStr msg_ap_pat

        input_ap_pat_loop:
            call inputChar
            cmp al, 0Dh
            je input_ap_pat_save
            cmp al, 'A'
            jb input_error_ap_pat
            cmp al, 'z'
            ja input_error_ap_pat
            cmp al, 'a'
            jae input_ap_pat_loop_pass
            cmp al, 'Z'
            jbe input_ap_pat_loop_pass

            input_error_ap_pat:
                PrintStr msg_error
                jmp input_ap_pat

            input_ap_pat_loop_pass:
                push ax
                inc cx
                jmp input_ap_pat_loop

        input_ap_pat_save:
            cmp cx, 0
            je error_empty_ap_pat
            mov si, offset ap_pat
            add si, cx
            jmp input_ap_pat_save_loop

            error_empty_ap_pat:
                PrintStr msg_empty
                jmp input_ap_pat

            input_ap_pat_save_loop:
                pop ax
                dec si
                mov [si], al
                loop input_ap_pat_save_loop

    input_ap_mat:
        mov cx, 0
        PrintStr msg_ap_mat

        input_ap_mat_loop:
            call inputChar
            cmp al, 0Dh
            je input_ap_mat_save
            cmp al, 'A'
            jb input_error_ap_mat
            cmp al, 'z'
            ja input_error_ap_mat
            cmp al, 'a'
            jae input_ap_mat_loop_pass
            cmp al, 'Z'
            jbe input_ap_mat_loop_pass

            input_error_ap_mat:
                PrintStr msg_error
                jmp input_ap_mat

            input_ap_mat_loop_pass:
                push ax
                inc cx
                jmp input_ap_mat_loop

        input_ap_mat_save:
            cmp cx, 0
            je error_empty_ap_mat
            mov si, offset ap_mat
            add si, cx
            jmp input_ap_mat_save_loop

            error_empty_ap_mat:
                PrintStr msg_empty
                jmp input_ap_mat

            input_ap_mat_save_loop:
                pop ax
                dec si
                mov [si], al
                loop input_ap_mat_save_loop


; #####     comparaciones     #####
    input_correo:
        mov cx, 0
        mov dx, 0
        mov bx, 0
        mov di, offset correo_aux
        PrintStr msg_correo

        input_correo_loop:
            call inputChar
            cmp al, 0Dh
            je input_correo_save

            cmp al, 40h
            je activar_arroba
            jmp input_sin_arroba
            activar_arroba:
                mov bx, 1

            input_sin_arroba:
                cmp bx, 1
                jne input_correo_loop_pass
                cmp al, 40h
                je input_correo_loop_pass
                mov [di], al
                inc di
                inc dx

            input_correo_loop_pass:
                push ax
                inc cx
                jmp input_correo_loop

        input_correo_save:
            mov si, offset correo_aux
            cmp dx, 5
            jne comp_hotmail
            jmp comp_gmail

            comp_hotmail:
                cmp dx, 7
                jne correo_error
                mov di, offset hotmail

                comp_hotmail_loop:
                    cmp dx, 0
                    je cumple_correo
                    mov bx, [di]
                    cmp [si], bx
                    jne correo_error
                    dec dx
                    jmp comp_hotmail_loop

            comp_gmail:
                mov di, offset gmail

                comp_gmail_loop:
                    cmp dx, 0
                    je cumple_correo
                    mov bx, [di]
                    cmp [si], bx
                    jne correo_error
                    dec dx
                    jmp comp_gmail_loop

            correo_error:
                PrintStr msg_correo_error
                jmp input_correo

            cumple_correo:
                mov si, offset correo
                add si, cx

                input_correo_save_loop:
                    pop ax
                    dec si
                    mov [si], al
                    loop input_correo_save_loop

    input_pass:
        mov cx, 0
        mov dx, 0
        mov bx, 0
        PrintStr msg_pass

        input_pass_loop:
            mov ah, 08h
            int 21h
            cmp al, 0Dh
            je input_pass_save
            PrintChar '*'

            cmp al, 30h
            jb incrementar_caracter
            cmp al, 39h
            jbe incrementar_numero
            cmp al, 'A'
            jb incrementar_caracter
            cmp al, 'Z'
            jbe incrementar_mayuscula
            cmp al, 'a'
            jb incrementar_caracter
            cmp al, 'z'
            jbe incrementar_minuscula
            jmp incrementar_caracter

            incrementar_caracter:
                inc dh
                jmp input_pass_loop_end
            incrementar_numero:
                inc dl
                jmp input_pass_loop_end
            incrementar_mayuscula:
                inc bl
                jmp input_pass_loop_end
            incrementar_minuscula:
                inc bh

            input_pass_loop_end:
                push ax
                inc cx
                jmp input_pass_loop

        input_pass_save:
            cmp bh, 0
            je inseguro
            cmp bl, 0
            je inseguro
            cmp dl, 0
            je inseguro
            cmp dh, 0
            je inseguro

            mov si, offset pass
            add si, cx
            pass_save_loop:
                pop ax
                dec si
                mov [si], al
                loop pass_save_loop

            jmp imprimir_informacion

        inseguro:
            PrintStr msg_inseguro
            jmp input_pass


    imprimir_informacion:
        PrintStr msg_exito
        PrintStr msg_print_usuario
        PrintStr usuario
        PrintStr msg_print_nombre
        PrintStr nombre
        PrintStr msg_print_ap_pat
        PrintStr ap_pat
        PrintStr msg_print_ap_mat
        PrintStr ap_mat
        PrintStr msg_print_correo
        PrintStr correo
        PrintStr msg_print_pass
        PrintStr pass

end:
    int 20h


; ##########     PROCEDIMIENTOS     ##########
include 'procedimientos.asm'


; ##########     VARIABLES     ##########
msg_bienvenida    db 0Ah, 0Dh, 20 dup('*')
                  db 0Ah, 0Dh, '*', 18 dup(0), '*'
                  db 0Ah, 0Dh, '*    BIENVENIDO    *'
                  db 0Ah, 0Dh, '*', 18 dup(0), '*'
                  db 0Ah, 0Dh, 20 dup('*'), 0Ah, 0Dh, 24h
msg_usuario       db 0Ah, 0Dh, 'Ingrese su Usuario: $'
msg_nombre        db 0Ah, 0Dh, 'Ingrese su Nombre: $'
msg_ap_pat        db 0Ah, 0Dh, 'Ingrese su Apellido Paterno: $'
msg_ap_mat        db 0Ah, 0Dh, 'Ingrese su Apellido Materno: $'
msg_correo        db 0Ah, 0Dh, 'Ingrese su Correo Electronico: $'
msg_pass          db 0Ah, 0Dh, 'Ingrese su Contrase', 0A4h, 'a: $'
msg_exito         db 2 dup(0Ah, 0Dh), 'Registro Exitoso!', 0Ah, 0Dh, 24h
msg_empty         db 2 dup(0Ah, 0Dh), 'El campo no puede estar vacio!', 0Ah, 0Dh, 24h
msg_error         db 2 dup(0Ah, 0Dh), 'Caracter no valido!', 0Ah, 0Dh, 24h
msg_correo_error  db 2 dup(0Ah, 0Dh), 'Correo no valido!', 0Ah, 0Dh, 24h
msg_inseguro      db 2 dup(0Ah, 0Dh), 'El password debe de contener almenos 1 minuscula, 1 mayuscula, 1 numero y un caracter especial!', 0Ah, 0Dh, 24h
msg_print_usuario db 0Ah, 0Dh, 'Usuario: $'
msg_print_nombre  db 0Ah, 0Dh, 'Nombre: $'
msg_print_ap_pat  db 0Ah, 0Dh, 'Apellido Paterno: $'
msg_print_ap_mat  db 0Ah, 0Dh, 'Apellido Materno: $'
msg_print_correo  db 0Ah, 0Dh, 'Correo: $'
msg_print_pass    db 0Ah, 0Dh, 'Contrase', 0A4h, 'a: $'
usuario           db 255 dup('$')
nombre            db 255 dup('$')
ap_pat            db 255 dup('$')
ap_mat            db 255 dup('$')
correo            db 255 dup('$')
pass              db 255 dup('$')
correo_aux        db 7 dup(0)
gmail             db 'gmail'
hotmail           db 'hotmail'
