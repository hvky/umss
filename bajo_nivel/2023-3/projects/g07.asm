; Este es un programa que permite el ingreso de N caracteres. 
; Guarda en una cadena solo los numeros. Hasta M maximo.
; Guarda en otra cadena las letras, Hasta M maximo.
; Guarda en otra cadena los caracteres especiales, Hasta M maximo.
; Y tambien muestra las cadenas.   

org 100h                ; Punto de inicio del programa

inicio:                 ; Etiqueta de inicio

  mov dx,offset cad1    ; Muestra el mensaje inicial
  mov ah,9
  int 21h

  mov dx,offset cad2    ; Pide al usuario que introduzca una cadena de caracteres
  mov ah,9
  int 21h

  mov dx,offset cad3    ; L�nea en blanco
  mov ah,9
  int 21h

  mov si,offset cadena   ; Inicializa el �ndice para la cadena de entrada
  mov ah,1

captura:
  int 21h               ; Captura un car�cter del usuario
  cmp al,13             ; Comprueba si es Enter (c�digo ASCII 13)
  je saltar             ; Salta al final de la captura si es Enter
  add bx,1              ; Incrementa el contador de caracteres
  mov [si],al           ; Almacena el car�cter en la cadena
  inc si
  jmp captura

saltar:
  mov ah,2
  mov dl,10             ; Imprime un salto de l�nea
  int 21h
  mov dl,13             ; Imprime un retorno de carro
  int 21h
  mov cx,bx             ; Guarda el n�mero total de caracteres en cx
  mov si,offset numeros ; Inicializa el �ndice para la cadena de n�meros

moverN:
  mov al,cadena[di]     ; Obtiene el car�cter de la cadena de entrada
  cmp al,48             ; Compara con '0' (c�digo ASCII)
  jb sig                ; Salta si es menor (no es un n�mero)
  cmp al,57             ; Compara con '9' (c�digo ASCII)
  ja sig                ; Salta si es mayor (no es un n�mero)
  mov [si],al           ; Almacena el n�mero en la cadena de n�meros
  inc si

sig:
  inc di
  loop moverN           ; Repite el bucle hasta que se procesen todos los caracteres
  mov dx,offset cad4    ; Muestra el mensaje de n�meros
  mov ah,9
  int 21h
  mov di,0              ; Inicializa el �ndice para mostrar n�meros

mostrarNumeros:
  mov ah,2
  mov dl,numeros[di]    ; Obtiene el n�mero de la cadena de n�meros
  cmp dl,'$'            ; Compara con el marcador de final de cadena
  je L                  ; Salta al final si llega al final de la cadena
  int 21h
  add di,1
  cmp di,10
  je L
  jmp mostrarNumeros

L:
  mov di,0
  mov cx,bx             ; Guarda el n�mero total de caracteres en cx
  mov si,offset letras   ; Inicializa el �ndice para la cadena de letras

moverL:
  mov al,cadena[di]     ; Obtiene el car�cter de la cadena de entrada
  cmp al,65             ; Compara con 'A' (c�digo ASCII)
  jb sig2               ; Salta si es menor (no es una letra)
  cmp al,90             ; Compara con 'Z' (c�digo ASCII)
  ja sig3               ; Salta si es mayor (no es una letra)
  mov [si],al           ; Almacena la letra en la cadena de letras
  inc si

sig3:
  cmp al,97             ; Compara con 'a' (c�digo ASCII)
  jb sig2               ; Salta si es menor (no es una letra)
  cmp al,122            ; Compara con 'z' (c�digo ASCII)
  ja sig2               ; Salta si es mayor (no es una letra)
  mov [si],al           ; Almacena la letra en la cadena de letras
  inc si

sig2:
  inc di
  loop moverL           ; Repite el bucle hasta que se procesen todos los caracteres
  mov dx,offset cad5    ; Muestra el mensaje de letras
  mov ah,9
  int 21h
  mov di,0              ; Inicializa el �ndice para mostrar letras

mostrarLetras:
  mov ah,2
  mov dl,letras[di]     ; Obtiene la letra de la cadena de letras
  cmp dl,'$'            ; Compara con el marcador de final de cadena
  je Otross             ; Salta al siguiente conjunto si llega al final de la cadena
  int 21h
  add di,1
  cmp di,10
  je Otross
  jmp mostrarLetras

Otross:
  mov di,0              ; Inicializa el �ndice para procesar otros caracteres
  mov cx,bx             ; Guarda el n�mero total de caracteres en cx
  mov si,offset otros   ; Inicializa el �ndice para la cadena de otros caracteres

moverO:
  mov al,cadena[di]     ; Obtiene el car�cter de la cadena de entrada
  cmp al,34             ; Compara con '"' (c�digo ASCII)
  jb sig5               ; Salta si es menor (no es un otro caracter)
  cmp al,48             ; Compara con '0' (c�digo ASCII)
  jb sig4               ; Salta si es menor (no es un otro caracter)
  cmp al,58             ; Compara con ':' (c�digo ASCII)
  jb sig5               ; Salta si es menor (no es un otro caracter)
  cmp al,65             ; Compara con 'A' (c�digo ASCII)
  jb sig4               ; Salta si es menor (no es un otro caracter)
  cmp al,91             ; Compara con 'Z' (c�digo ASCII)
  jb sig5               ; Salta si es menor (no es un otro caracter)
  cmp al,97             ; Compara con 'a' (c�digo ASCII)
  jb sig4               ; Salta si es menor (no es un otro caracter)
  cmp al,168            ; Compara con '�' (c�digo ASCII)
  je sig4               ; Salta si es igual (no es un otro caracter)
  cmp al,96             ; Compara con '`' (c�digo ASCII)
  ja sig5               ; Salta si es mayor (no es un otro caracter)

sig4:
  mov [si],al           ; Almacena el otro caracter en la cadena de otros caracteres
  inc si

sig5:
  inc di
  loop moverO           ; Repite el bucle hasta que se procesen todos los caracteres
  mov dx,offset cad6    ; Muestra el mensaje de otros caracteres
  mov ah,9
  int 21h
  mov di,0              ; Inicializa el �ndice para mostrar otros caracteres

mostrarOtros:
  mov ah,2
  mov dl,otros[di]      ; Obtiene el otro caracter de la cadena de otros caracteres
  cmp dl,'$'            ; Compara con el marcador de final de cadena
  je F                  ; Salta al final si llega al final de la cadena
  int 21h
  add di,1
  cmp di,10
  je F
  jmp mostrarOtros

F:
  mov ah,2
  mov dl,10             ; Imprime un salto de l�nea
  int 21h
  mov dl,13             ; Imprime un retorno de carro
  int 21h
  mov dx,offset cad1    ; Muestra el mensaje de despedida
  mov ah,9
  int 21h

fin:
  int 20h                ; Fin del programa

cad1 db 13,10, "     ----- * * * * * * * * * * * ----- $"        ; Mensaje de l�nea decorativa
cad2 db 13,10,13,10, " -> Introduzca N caracteres:$"             ; Mensaje de instrucci�n al usuario
cad3 db 13,10,13,10,"     $"                                     ; L�nea en blanco
cad4 db 13,10,"    Numeros: $"                                   ; Mensaje de n�meros
cad5 db 13,10,"     Letras: $"                                   ; Mensaje de letras
cad6 db 13,10," Especiales: $"                                ; Mensaje de otros caracteres
cadena db 110 dup('$')                                        ; Cadena de entrada (m�ximo 110 caracteres)
numeros db 110 dup('$')                                       ; Cadena de n�meros (m�ximo 110 caracteres)
letras db 110 dup('$')                                        ; Cadena de letras (m�ximo 110 caracteres)
otros db 110 dup('$')                                         ; Cadena de otros caracteres (m�ximo�110�caracteres)