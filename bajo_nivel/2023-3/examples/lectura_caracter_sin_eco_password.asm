
;LECTURA DE UN CARACTER SIN ECO
;APLICACION A LA LECTURA DE PASSWORD
 
org 100h

;escribe txt1	     
mov AH, 09h	   
mov DX, offset txt1
int 21h

;lee un caracter sin eco
;y lo guarda en AL, luego se
;respalda el valor en CL 
mov AH, 08h
int 21h
mov BL, AL

;escribe caracter '*'	    
mov AH, 02h	   
mov DL, '*'
int 21h 

;escribe txt2	     
mov AH, 09h	   
mov DX, offset txt2
int 21h

;escribe caracter ingresado	  
mov AH, 02h	   
mov DL, BL
int 21h 

;fin del programa
int 20h 

txt1	    DB 'Password: $'
txt2	    DB 13,10,'Usted escribio: ','$'