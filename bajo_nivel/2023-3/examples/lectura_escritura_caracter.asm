
;LECTURA Y ESCRITURA DE UN CARACTER
;EN LA SALIDA POR DEFECTO (PANTALLA) 
       
;teclas rapidas en emu8086:
;F5: emulate
;F9: run
;F4: reload
;F8: single step
;CTRL+Q: comment block 
;CTRL+W: uncomment block

org 100h  
	      
;lee un caracter con eco
;y lo guarda en AL 
mov AH, 01h
int 21h

;movemos el caracter leido a DL
;para mostrarlo en pantalla
mov DL, AL			     

;escribe caracter en DL
mov AH, 02h
int 21h  

;fin del programa
int 20h