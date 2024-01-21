;Ejercicio: dado un numero decimal, convertirlo a binario y hexadecimal  (tope de   )


;;;;;;;;;;;;;;;;;;;;;;; Macro para la division  ;;;;;;;;;;;;;;;;;;;;;;;
division macro pd
local ciclo, fin    
  mov cont, 0             
 ciclo:                  
 xor dx, dx               
 div pd                   
 push dx                  
 inc cont                 
 cmp ax, pd               
 jb fin                   
 jmp ciclo                
 
fin:                     
endm

;;;;;;;;;;;;;;;;;;;, Macro para convertir a hexadecimal  A=10,B=11,C=12,D=13,E=14,F=15 
 
hex macro num             
 mov al, num             
 mov ah, 0               
 mov bl, 10              
 div bl                  
 mov si, offset exa      
 shr ax, 8               
 add si, ax              
 mov dl, [si]          
 mov ah, 2               
 int 21h                 
endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; INICIO DEL PROGRAMA ;;;;;;;;;;;;;;;;;;;;;;;;
org 100h 

mov dx, offset decimal    
mov ah, 9                 
int 21h                   
mov cx,1
inicio:
  mov ah, 1               
  int 21h                 
  cmp al, 13              
  je binario              
  sub al,30h             
  mov ah, 0               
  xchg ax, bx             
  mul cx                  
  mov cx, 10              
  add bx, ax              
  jmp inicio             

;;;;;;;;;;;;;;;;;;;;;;;;;;;;; CALCULAR BINARIO ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
binario:  
  mov dx, offset binarioo  
  mov ah, 9                
  int 21h                 
  mov aux, bx             
  mov bx, 2              
  mov ax, aux             
  division bx             

imprimir:
  mov cx, cont             
  mov ah, 2              
  mov dl, al               
  add dl, 30h              
  int 21h                  

impr:
  pop dx                  
  add dl, 30h              
  int 21h                  
  loop impr                

;;;;;;;;;;;;;;;;;;;;;;;;; CALCULAR HEXADECIMAL ;;;;;;;;;;;;;
hexadecimal:
  mov dx, offset heexadecimal  
  mov ah, 9                    
  int 21h                      

  mov bx, 16                  
  mov ax, aux                 
  division bx                

immprimir:
  mov cx, cont                 
  cmp al, 10                   
  jb siguiente                
  hex al                      
  jmp immpr                   

siguiente:
  add al, 30h                  
  mov dl, al                  
  mov ah, 2                   
  int 21h                    

immpr:
  pop dx                      
  cmp dl, 10                 
  jb sig                       
  hex dl                      
  jmp ciclo                   

sig:
  add dl, 30h                 
  mov ah, 2                   
  int 21h                     

ciclo:
  loop immpr                  

int 20h                        ;fin del programa


exa db 'ABCDEF$'
binarioo db 10, 13, "Binario:$", 32
decimal db 'Decimal:$', 32
heexadecimal db 10, 13, 'Hexadecimal:$'
aux dw 0                       ; Auxiliar donde se guardar el numero
cont dw 0                      ; Contador
