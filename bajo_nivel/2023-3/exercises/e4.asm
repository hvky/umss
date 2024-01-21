; EDDY SEJAS ARZE   INFORMATICA
; 14442097          202202881


org 100h

; ##########     MACROS     ##########
include 'macros.asm'

problem macro cad
    PrintStr cad
    jmp start
endm


; ##########     PROGRAMA     ##########
start:
    PrintStr msg
    mov cl, 0
    mov bx, 0

    ciclo_input:
        call inputChar
        cmp al, 0Dh
        je evaluar
        cmp al, 30h
        jb error
        cmp al, 39h
        ja error

        sub al, 30h
        add cl, al

        mov ah, 0
        push ax
        mov ax, bx
        mov dx, 10
        mul dx
        pop dx
        add ax, dx
        mov bx, ax

        jmp ciclo_input

    evaluar:
        PrintStr msg_salto

        cmp bx, 100
        jb corto
        cmp bx, 255
        ja largo

        mov al, cl
        shr al, 1
        shl al, 1

        cmp al, cl
        je evaluar_par
        jmp evaluar_primo
        
        evaluar_par:
            shl bx, 15
            shr bx, 15

            cmp bx, 1
            je no_par
            jmp par

            no_par: PrintStr msg_negacion
            par:    PrintStr msg_par
                    jmp end

        evaluar_primo:
            mov ax, bx
            mov cx, 2
            div cl
            cmp dx, 0
            je no_primo
            inc cx

            ciclo_evaluar_primo:
                cmp cx, 17
                je primo

                push bx
                shr bx, 1
                cmp cx, bx
                ja primo
                pop bx

                mov ax, bx
                div cl
                cmp dx, 0
                je no_primo

                add cx, 2
                jmp ciclo_evaluar_primo

            no_primo: PrintStr msg_negacion
            primo:    PrintStr msg_primo
                      jmp end

    error: problem msg_error
    corto: problem msg_corto
    largo: problem msg_largo

end:
    int 20h


; ##########     PROCEDIMIENTOS     ##########
include 'procedimientos.asm'


; ##########     VARIABLES     ##########
msg          db 'Ingrese un numero entre [100 - 255]: $'
msg_error    db 0Ah, 0Dh, 'Caracter no valido!', 0Ah, 0Dh, '$'
msg_corto    db 'Numero muy corto!', 0Ah, 0Dh, '$'
msg_largo    db 'Numero muy grande!', 0Ah, 0Dh, '$'
msg_negacion db 'No $'
msg_primo    db 'Es primo$'
msg_par      db 'Es par$'
msg_salto    db 0Ah, 0Dh, '$'
