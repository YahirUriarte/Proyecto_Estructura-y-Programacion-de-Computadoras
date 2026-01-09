;	Nombre: Uriarte Ortiz Enrique Yahir.
;	Fecha de termino de la programacion: 09/01/2023
;	Funcionalidades implementadas: 
;		- Reloj ejecutado en tiempo real en el menu con la hora del equipo
;		- Menu de seleccion a realizar operaciones con matrices
;		- Suma de 2 Matrices de 4x4
;		- Obtener Transpuesta de una matriz
;		- Multiplicar 2 matrices de 4X4 Matrices
;		- Suma de la diagonal principal
;		- Suma de columnas de una matriz
;		- Suma de renglones de una matriz
;		- Casteo de datos de hexadecimal a decimal
;
;	Comandos necesarios:

page 60,132
title proyecto
.model small
diez equ 10
mueve equ mov
.stack 64
.data ; declaramos variables ----------------------------------------------------------

	ubica db 'AQUI TOY';cadena para ubicar memoria
	
	M1mnsj db 'M1:','$'
	M2mnsj db 'M2:','$'
	M3mnsj db 'M-Resultado:','$'
	
	M1 db '00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00','$';Primera matriz de datos
	M2 db '00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00','$';Segunda matriz de datos
	M3 db '00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00   ','$';Matriz resultante
	Columnas db '00,00,00,00  ','$';definimos columna
	Renglones db '00,00,00,00  ','$';definimos renglon
	MTRx db '00,00,00,00','$';definimos matriz para posicion
	
	ubicando db 'AQUI TOY' ;cadena para ubicar memoria, division entre datos acomodada
	
	M1r db '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0','$' ;Primera matriz de datos en hexadecimal
	M2r db '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0','$' ;Segunda matriz de datos en hexadecimal
	
	SumDiag db 00 ;definimos resultado de suma de diagonal principal
	SumDiagcad db '00','$' ;cadena para resultado de suma de diagonal principal
	ctaEXT dw 00 ;Cx es de 16 bits
	recuerda dw 00 ;guardar posicion en matriz acomodada
	recuerdb dw 00 ;guardar posicion de M2 matriz para multiplicacion
	recuerdaimp db 00 ;posicion de columna para matriz acomodada
	
	tiempo db 'HH:MM:SS:CS','$'
	titulo db 'PROGRAMA: OPERACIONES CON MATRICES.','$'
	Opdis db 'Teclee la opcion de dese realizar.','$'
	Opa db 'A) Suma de 2 Matrices.','$'
	Opb db 'B) Obtener Transpuesta.', '$'
	Opc db 'C) Multiplicar Matrices.', '$'
	Opd db 'D) Diagonal principal y suma.','$'
	Ope db 'E) Suma de columnas de una matriz.','$'
	Opf db 'F) Suma de renglones de una matriz.','$'
	Opg db 'Terminar programa - ESC.','$'
	Opax db 'Suma de 2 Matrices de 4X4.','$'
	Opbx db 'Obtener Transpuesta de 4X4.', '$'
	Opcx db 'Multiplicar Matrices.', '$'
	Opdx db 'Diagonal principal y suma.','$'
	Opex db 'Suma de columnas de una matriz.','$'
	Opfx db 'Suma de renglones de una matriz.','$'
	mimpes db 'Imprimir todas las matrices de la operacion? I(si)/N(no)','$'
	Opamp db '-> Introdusca los valores de la primera matriz:','$'
	Opams db '-> Introdusca los valores de la segunda matriz:','$'
	Opminsrt db '- Matrices insertadas -','$'
	Opfin db 'Programa terminado gracias por su preferencia :).','$'
	strOtraOp db 'Quiere realizar otra operacion? SI(S)/No(ESC)','$'
	
	opARealizar db 2,0,' ','$'
	otraOp db 2,0,' ','$';cadena para realizar otra operacion - S o N

.code ; iniciamos codigo --------------------------------------------------------------
inicio proc far
	assume
	mov ax,@data
	mov ds,ax
	mov es,ax
	
	call limpia
	
; imprime cadena ----------------------------------------------------------------------
	mov ah,02
	mov bh,0 			;número de página
	mov dh,3 			;renglón
	mov dl,21			;columna
	int 10h 			;posiciona el cursor
	lea dx,titulo
	mov ah,09
	int 21h 			;imprime la esquina
		
	; imprime menu de operaciones ----------------------------------------------------

	; Imprime enuncionado de inicio --------------------------------------------------
		mov ah,02
		mov bh,0 		;número de página
		mov dh,8 		;renglón
		mov dl,26		;columna
		int 10H			;ubicamos
		lea dx,Opdis
		mov ah,09
		int 21h 		;imprime la esquina
		
	; Imprime opcion A ---------------------------------------------------------------
		mov ah,02
		mov bh,0 		;número de página
		mov dh,10 		;renglón
		mov dl,26		;columna
		int 10H			;ubicamos
		lea dx,Opa
		mov ah,09
		int 21h 		;imprime la esquina
	
	; Imprime opcion B ---------------------------------------------------------------
		mov ah,02
		mov bh,0 		;número de página
		mov dh,12 		;renglón
		mov dl,26		;columna
		int 10H			;ubicamos
		lea dx,Opb
		mov ah,09
		int 21h 		;imprime la esquina
		
	; Imprime opcion C ---------------------------------------------------------------
		mov ah,02
		mov bh,0 		;número de página
		mov dh,14 		;renglón
		mov dl,26		;columna
		int 10H			;ubicamos
		lea dx,Opc
		mov ah,09
		int 21h 		;imprime la esquina
		
	; Imprime opcion D ---------------------------------------------------------------
		mov ah,02
		mov bh,0 		;número de página
		mov dh,16 		;renglón
		mov dl,26		;columna
		int 10H			;ubicamos
		lea dx,Opd
		mov ah,09
		int 21h 		;imprime la esquina
		
	; Imprime opcion E ---------------------------------------------------------------
		mov ah,02
		mov bh,0 		;número de página
		mov dh,18 		;renglón
		mov dl,26		;columna
		int 10H			;ubicamos
		lea dx,Ope
		mov ah,09
		int 21h 		;imprime la esquina
		
	; Imprime opcion F ---------------------------------------------------------------
		mov ah,02
		mov bh,0 		;número de página
		mov dh,20 		;renglón
		mov dl,26		;columna
		int 10H			;ubicamos
		lea dx,Opf
		mov ah,09
		int 21h 		;imprime la esquina
		
	; Imprime terminar ---------------------------------------------------------------
		mov ah,02
		mov bh,0 		;número de página
		mov dh,23 		;renglón
		mov dl,40		;columna
		int 10H			;ubicamos
		lea dx,Opg
		mov ah,09
		int 21h 		;imprime la esquina
	
	anima:
	; obteniendo tiempo --------------------------------------------------------------
		mov ah,02ch
		int 21h
		
	; cast de número a ascii ---------------------------------------------------------
		xor ax,ax
		mov al,ch
		mov bl,diez
		div bl			;separando dígitos
		add al,30h		;obteniendo su ascii
		add ah,30h;
		mueve si,offset tiempo
		mov [si],al		;creando cadena de tiempo
		mov [si+1],ah	;hora

	; minutos ------------------------------------------------------------------------
		xor ax,ax
		mov al,cl
		mov bl,diez
		div bl			;separando dígitos
		add al,30h		;obteniendo su ascii
		add ah,30h
		mov [si+3],al	;creando cadena de tiempo
		mov [si+4],ah	;minutos

	; segundos -----------------------------------------------------------------------
		xor ax,ax
		mov al,dh
		mov bl,diez
		div bl			;separando dígitos
		add al,30h		;obteniendo su ascii
		add ah,30h
		mov [si+6],al	;creando cadena de tiempo
		mov [si+7],ah	;segundos

	; centésimas de segundo ----------------------------------------------------------
		xor ax,ax
		mov al,dl
		mov bl,diez
		div bl			;separando dígitos
		add al,30h		;obteniendo su ascii
		add ah,30h
		mov [si+9],al	;creando cadena de tiempo
		mov [si+10],ah	;segundos

	; ubicando cursor en centro de pantalla modo texto -------------------------------
		mov ah,02h
		mov dh,5		;renglón
		mov dl,32		;columna
		mov bh,00		;núm página
		int 10H			;ubicamos

	; imprimir tiempo ----------------------------------------------------------------
		mov ah,09h
		mov dx,si
		int 21h

	; ciclo con salida esc -----------------------------------------------------------
		in al,60h
		dec al
		cmp al,00
	
	; interrupcion  ------------------------------------------------------------------
		
		mov ah,02
		mov bh,0 		;número de página
		mov dh,21 		;renglón
		mov dl,26		;columna
		int 10H			;ubicamos
		
		mov ah,0Bh
		int 21h
		cmp al,0FFh
		je allright 

	jnz anima
	
	allright:
	call limpia
	
	; imprime cadena ------------------------------------------------------------------
	mov ah,08h
    int 21h
	mov bl,al
	xor ax,ax
	
	cmp bl,41h; Comparar con A
	je suma
	cmp bl,42h; Comparar con B
	je transp
	cmp bl,43h; Comparar con C
	je multi
	cmp bl,44h; Comparar con D
	je dprin
	cmp bl,45h; Comparar con E
	je sumcol
	cmp bl,46h; Comparar con F
	je sumren
	cmp bl,1Bh; Comparar con ESC
	je exit

	jmp inicio

	suma:
	call sumarm	; llama a operacion suma de matrices
	jmp inicio	; llama a ejecutar el menu de nuevo
	transp:
	call tranptr; llama a operacion traspuesta de matriz
	jmp inicio
	multi:
	call multirm; llama a operacion multiplicacion de matrices
	jmp inicio
	dprin:
	call dprinrm; llama a operacion suma de la diagonal principal de la matriz
	jmp inicio
	sumcol:
	call sumcolrm; llama a operacion suma de columnas de la matriz
	jmp inicio
	sumren:
	call sumrenrm; llama a operacion suma de columnas de la matriz
	jmp inicio
		
	; finaliza programa ----------------------------------------------------------
	exit:
	call limpia
		mov ah,02
		mov bh,0 		;número de página
		mov dh,12 		;renglón
		mov dl,15		;columna
		int 10H			;ubicamos
		lea dx,Opfin	;mensaje de agradecimiento
		mov ah,09
		int 21h 		;imprime la esquina
		
	mov ah,08h
	int 21h				;espera cualquier tecla
	
	call limpia
	
	mov ah,04ch			;termina ejecucion
	mov al,0
	int 21h
	
inicio endp

limpia proc
	MOV AH,0FH			;limpia pantalla
	INT 10H
	MOV AH,0
	INT 10H
	ret
limpia endp

otraOption proc
	call limpia
	mov ah,02
	mov bh,0 			;número de página
	mov dh,3 			;renglón
	mov dl,20			;columna
	int 10h 			;posiciona el cursor
	lea dx,strOtraOp	;Pregunta para continuar
	mov ah,09
	int 21h 			;imprime la esquina
	ret
otraOption endp

confirmacion proc
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,12 			;renglón
	mov dl,18			;columna
	int 10h 			;posiciona el cursor
	lea dx,mimpes		;Pregunta para imprimir
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,13 			;renglón
	mov dl,18			;columna
	int 10h 			;posiciona el cursor
	mov ah,08h			;Respuesta para imprimir
    int 21h
	mov bl,al
	xor ax,ax
	
	cmp bl,49h; Comparar con I
	je impma
	cmp bl,1Bh; Comparar con ESC
	je net
	
	net:
	call otraOption
	mov ah,08h
    int 21h
	mov bl,al
	xor ax,ax
	
	impma:
	
	ret
confirmacion endp

retra proc
	retrasadora:		;Convertir a hexadecimal - decimal de M3,columnas y renglones
		inc si
		xor ax,ax
		mov al,[si]		;[Contenido]=al
		mov bl,diez		;bl = 0A
		div bl			;separando dígitos al/bl
		add al,30h		;obteniendo su ASCII al = +30
		add ah,30h		;obteniendo su ASCII ah = +30
		mov [si-1],al
		mov [si],ah		;posicion de datos [al ah]
		inc si			;mueve una posicion
		mov [si],dx		;se coloca una coma
		inc si
	loop retrasadora
	ret
retra endp

matrix1 proc
	
	lea si,M1			;lee la matriz 1
	mov cx,30h			;48 veces
	inc si
	inc si				;se coloca en la posicion correcta
	
	repetir: 			;Convertir a hexadecimal
		mov ah,[si]
		sub ah,30h		;cambiamos a valor hexa
		mov [si],ah
		inc si
	loop repetir
		
	lea si,M1			;Obtener valores hexadecimales reales M1
	lea di,M1r
	mov bl,diez
	mov cx,10h			;16 veces
	mov dx,0
	
	realvalm1:			;guarda en M1r matrix para operar
		inc si
		inc si			;se coloca en la posicion correcta
		mov al,[si]
		mul bl
		mov ah,[si+1]
		add al,ah		;AX = valor hexadecimal real
		inc si
		mov [di],al
		inc di
		inc di			;se coloca en la posicion correcta
	loop realvalm1
	ret	
matrix1 endp

matrix2 proc			;misma ejecucion que matrix1 pero para M2
	
	lea si,M2
	mov cx,30h
	inc si
	inc si
	
	repetirb: 			
		mov ah,[si]
		sub ah,30h
		mov [si],ah
		inc si
	loop repetirb
	
	lea si,M2		
	lea di,M2r
	mov bl,diez
	mov cx,10h
	mov dx,0
	
	realvalm2:
		inc si
		inc si
		mov al,[si]
		mul bl
		mov ah,[si+1]
		add al,ah		
		inc si
		mov [di],al
		inc di
		inc di
		loop realvalm2
	ret	
matrix2 endp

matrix3 proc
	lea si,M3			;Obtener valores hexadecimales reales M3
	mov cx,10h
	mov dx,2Ch
	
	call retra			; llama a operacion para Convertir a decimal - hexadecimal
	ret	
matrix3 endp

matrix1imp proc
	lea si,M1			;si = M1
	mov cx,30h
	inc si
	inc si				;colocamos en posicion adecuada
	
	repetirc: 			;Convertir a hexadecimal Convertir a decimal - hexadecimal
		mov ah,[si]
		add ah,30h		;cambiamos a valor hexa
		mov [si],ah
		inc si
	loop repetirc
	
	call matrix1impcc	; llama a operacion para imprimir m1
	ret
matrix1imp endp

matrix1impcc proc
	mov si, offset M1;		;si = M1
	mov recuerdaimp,10		;posicion columna
	call matrixposicionar	;llama a operacion para ordenar impresion
	ret
matrix1impcc endp

matrix2imp proc			;mismo procedimiento que matrix1imp pero para M2
	lea si,M2
	mov cx,30h
	inc si
	inc si
	
	repetird: 			
		mov ah,[si]
		add ah,30h
		mov [si],ah
		inc si
	loop repetird
	
	mov si, offset M2;		;si = M2
	mov recuerdaimp,30		;posicion columna
	call matrixposicionar	;llama a operacion para ordenar impresion
	ret
matrix2imp endp

matrix3imp proc
	mov si, offset M3;		;si = M3
	dec si
	dec si					;colocamos en posicion adecuada
	mov recuerdaimp,57		;posicion columna
	call matrixposicionar	;llama a operacion para ordenar impresion
	ret	
matrix3imp endp

sumarm proc
	; imprime cadenas --------------------------------------------------------------------- FUNCIONA
	call limpia
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,3 			;renglón
	mov dl,13			;columna
	int 10H 			;posiciona el cursor
	lea dx,Opax
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,5 			;renglón
	mov dl,18			;columna
	int 10H				;posiciona el cursor
	lea dx,Opamp
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,6 			;renglón
	mov dl,18			;columna
	int 10h 			;posiciona el cursor
	
	mov dx, offset M1
	mov ah,0ah
	int 21h				;ingresamos datos a M1 
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,8 			;renglón
	mov dl,18			;columna
	int 10h 			;posiciona el cursor
	lea dx,Opams
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,9 			;renglón
	mov dl,18			;columna
	int 10h 			;posiciona el cursor
	
	mov dx, offset M2
	mov ah,0ah
	int 21h				;ingresamos datos a M2 
	
	call matrix1		;llamamos matrix1
	call matrix2		;llamamos matrix2
	
	mov bx, offset M1r; bx apunta a M1
	mov si, offset M2r; bx apunta a M2
	mov di, offset M3; di apunta a Maxwell
	mov cx,31
	sumaM:
	inc di
	mov al,[bx];elemento de al = M1
	add al,[si];al = M1 + M2
	mov [di],al;M3 = M1 + M2
	inc bx
	inc si
	inc bx		;posicion M1r
	inc si		;posicion M2r
	inc di
	inc di		;posicion M3
	loop sumaM
	
	call confirmacion
	
	cmp bl,53h; Comparar con S
	je sumarmrp
	cmp bl,1Bh; Comparar con ESC
	je rina
	jmp sucesa
	
	sumarmrp:
	call sumarm			;volvemos a esta funcion desde el inicio
	rina:
	call inicio			;volvemos al menu
	sucesa:
	
	call limpia
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,3 			;renglón
	mov dl,13			;columna
	int 10H 			;posiciona el cursor
	lea dx,Opminsrt
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,5 			;renglón
	mov dl,6			;columna
	int 10h 			;posiciona el cursor
	lea dx,M1mnsj
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,5 			;renglón
	mov dl,10			;columna
	int 10h 			;posiciona el cursor
	call matrix1imp
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,5 			;renglón
	mov dl,26			;columna
	int 10h 			;posiciona el cursor
	lea dx,M2mnsj
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,5 			;renglón
	mov dl,30			;columna
	int 10h 			;posiciona el cursor
	call matrix2imp
	
	call matrix3
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,5 			;renglón
	mov dl,44			;columna
	int 10h 			;posiciona el cursor
	lea dx,M3mnsj
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,5			;renglón
	mov dl,57			;columna
	int 10h 			;posiciona el cursor
	call matrix3imp
	
	mov ah,08h
    int 21h
	xor ax,ax
	call limpia
	ret
	
sumarm endp

tranptr proc
	; imprime cadena ---------------------------------------------------------------------- FUNCIONA
	call limpia
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,3 			;renglón
	mov dl,13			;columna
	int 10H 			;posiciona el cursor
	lea dx,Opbx
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,5 			;renglón
	mov dl,18			;columna
	int 10H				;posiciona el cursor
	lea dx,Opamp
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,6 			;renglón
	mov dl,18			;columna
	int 10h 			;posiciona el cursor
	
	mov dx, offset M1	;dx = M1
	mov ah,0ah
	int 21h
	
	mov bx, offset M1	;bx = M1
	mov si, offset M3	;si = M3
	mov cx,04			;4 veces
	inc bx
	inc bx				;posicion correcta de M1
	proceExt:
		mov ctaEXT,cx   ;ctaEXT = cx, guardamos cx
		mov cx,04
		renACol:
			mov al,[bx]
			mov [si],al	;pasamos [M1] -> [M3]
			inc bx		;cambiamos posicion
			inc si		;cambiamos posicion
			mov al,[bx]
			mov [si],al	;pasamos [M1] -> [M3]
			add si,11	;Cambio de renglon
			inc bx
			inc bx		;cambiamos de numero
		loop renACol
		sub si,45		;se mueve a la siguente columna
		mov cx,ctaEXT	;recuperamos cx
	loop proceExt
	
	call confirmacion
	
	cmp bl,53h; Comparar con S
	je tranptrrp
	cmp bl,1Bh; Comparar con ESC
	je rinb
	jmp sucesb
	
	tranptrrp:
	call tranptr
	rinb:
	call inicio
	sucesb:
	
	call limpia
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,3 			;renglón
	mov dl,13			;columna
	int 10H 			;posiciona el cursor
	lea dx,Opminsrt
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,5 			;renglón
	mov dl,6			;columna
	int 10h 			;posiciona el cursor
	lea dx,M1mnsj
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,5 			;renglón
	mov dl,10			;columna
	int 10h 			;posiciona el cursor
	call matrix1impcc
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,5 			;renglón
	mov dl,44			;columna
	int 10h 			;posiciona el cursor
	lea dx,M3mnsj
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,5			;renglón
	mov dl,57			;columna
	int 10h 			;posiciona el cursor
	call matrix3imp
	
	mov ah,08h
    int 21h
	xor ax,ax
	call limpia
	ret
	
tranptr endp

multirm proc
	; imprime cadena ---------------------------------------------------------------------- FUNACIONA
	call limpia
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,3 			;renglón
	mov dl,13			;columna
	int 10H 			;posiciona el cursor
	lea dx,Opcx
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,5 			;renglón
	mov dl,18			;columna
	int 10H				;posiciona el cursor
	lea dx,Opamp
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,6 			;renglón
	mov dl,18			;columna
	int 10h 			;posiciona el cursor
	
	mov dx, offset M1
	mov ah,0ah
	int 21h
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,8 			;renglón
	mov dl,18			;columna
	int 10h 			;posiciona el cursor
	lea dx,Opams
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,9 			;renglón
	mov dl,18			;columna
	int 10h 			;posiciona el cursor
	
	mov dx, offset M2
	mov ah,0ah
	int 21h
	
	call matrix1	
	call matrix2
	
	mov bx, offset M1r; bx apunta a M1r
	mov si, offset M2r; si apunta a M2r
	mov di, offset M3; di apunta a M3
	mov recuerdb,si		;recordamos ubicacion de M2r
	xor ax,ax
	
	call multmmm
	call multmmm
	call multmmm
	call multmmm		;llamamos a la multiplicacion 4 veces por convencion de la operacion
	
	call confirmacion
	
	cmp bl,53h; Comparar con S
	je multirmrp
	cmp bl,1Bh; Comparar con ESC
	je rinc
	jmp sucesc
	
	multirmrp:
	call multirm
	rinc:
	call inicio
	
	sucesc:
	
	call limpia
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,3 			;renglón
	mov dl,13			;columna
	int 10H 			;posiciona el cursor
	lea dx,Opminsrt
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,5 			;renglón
	mov dl,6			;columna
	int 10h 			;posiciona el cursor
	lea dx,M1mnsj
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,5 			;renglón
	mov dl,10			;columna
	int 10h 			;posiciona el cursor
	call matrix1imp
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,5 			;renglón
	mov dl,26			;columna
	int 10h 			;posiciona el cursor
	lea dx,M2mnsj
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,5 			;renglón
	mov dl,30			;columna
	int 10h 			;posiciona el cursor
	call matrix2imp
	
	call matrix3
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,5 			;renglón
	mov dl,44			;columna
	int 10h 			;posiciona el cursor
	lea dx,M3mnsj
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,5			;renglón
	mov dl,57			;columna
	int 10h 			;posiciona el cursor
	call matrix3imp
	
	mov ah,08h
    int 21h
	xor ax,ax
	call limpia
	ret
multirm endp

dprinrm proc
	; imprime cadena ---------------------------------------------------------------------- FUNCIONA
	call limpia
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,3 			;renglón
	mov dl,13			;columna
	int 10H 			;posiciona el cursor
	lea dx,Opdx
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,5 			;renglón
	mov dl,18			;columna
	int 10H				;posiciona el cursor
	lea dx,Opamp
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,6 			;renglón
	mov dl,18			;columna
	int 10h 			;posiciona el cursor
	
	mov dx, offset M1
	mov ah,0ah
	int 21h
	
	call matrix1
	
	xor ax,ax			;ax = 0000
	mov bx,offset M1r	;bx = M1r
	mov cx,04			;4 veces
	sumaDiag:
		add al,[bx]		;al = al + [bx]
		add bx,10		;bx = bx + 10
	loop sumaDiag
	mov SumDiag,al		;SumDiag = resultado de suma
	
	call confirmacion
	
	cmp bl,53h; Comparar con S
	je dprinrmrp
	cmp bl,1Bh; Comparar con ESC
	je rind
	jmp sucesd
	
	dprinrmrp:
	call dprinrm
	rind:
	call inicio
	
	sucesd:	
	
	call limpia
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,3 			;renglón
	mov dl,13			;columna
	int 10H 			;posiciona el cursor
	lea dx,Opminsrt
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,5 			;renglón
	mov dl,6			;columna
	int 10h 			;posiciona el cursor
	lea dx,M1mnsj
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,5 			;renglón
	mov dl,10			;columna
	int 10h 			;posiciona el cursor
	call matrix1imp
	
	lea si,SumDiagcad	;si = SumDiagcad
	xor ax,ax			;Convertir a decimal - hexadecimal
	mov al,[SumDiag]	
	mov bl,diez
	div bl				;ax = SumDiag/10
	add al,30h			;obteniendo su ASCII
	add ah,30h
	mov [si],al
	mov [si+1],ah		;posicion de datos [al ah]
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,5 			;renglón
	mov dl,44			;columna
	int 10h 			;posiciona el cursor
	lea dx,M3mnsj
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,5			;renglón
	mov dl,57			;columna
	int 10h 			;posiciona el cursor
	mueve si,offset SumDiagcad
	mov ah,09h
	mov dx,si
	int 21h	
	
	mov ah,08h
    int 21h
	xor ax,ax
	call limpia
	ret
dprinrm endp

sumcolrm proc
	; imprime cadena ---------------------------------------------------------------------- FUNCIONA
	mov ah,02
	mov bh,0 			;número de página
	mov dh,3 			;renglón
	mov dl,13			;columna
	int 10h 			;posiciona el cursor
	lea dx,Opex
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,5 			;renglón
	mov dl,18			;columna
	int 10H				;posiciona el cursor
	lea dx,Opamp
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,6 			;renglón
	mov dl,18			;columna
	int 10h 			;posiciona el cursor
	
	mov dx, offset M1	;dx
	mov ah,0ah
	int 21h
	
	call matrix1
	
	mov bx, offset M1r
	mov si, offset Columnas
	mov cx,04
	otraCol:
		inc si
		xor ax,ax
		mov ctaEXT,cx
		mov cx,04
		SumaCol:
			add al,[bx]
			add bx,8
		loop SumaCol
		mov [si],al
		inc si
		inc si
		sub bx,30
		mov cx,ctaEXT
	loop otraCol
	
	call confirmacion
	
	cmp bl,53h; Comparar con S
	je sumcolrmrp
	cmp bl,1Bh; Comparar con ESC
	je rine
	jmp sucese
	
	sumcolrmrp:
	call sumcolrm
	rine:
	call inicio
	
	sucese:
	
	call limpia
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,3 			;renglón
	mov dl,13			;columna
	int 10H 			;posiciona el cursor
	lea dx,Opminsrt
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,5 			;renglón
	mov dl,6			;columna
	int 10h 			;posiciona el cursor
	lea dx,M1mnsj
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,5 			;renglón
	mov dl,10			;columna
	int 10h 			;posiciona el cursor
	call matrix1imp
	
	lea si,Columnas
	mov cx,04h
	mov dx,2Ch
	
	call retra
		
	mov ah,02
	mov bh,0 			;número de página
	mov dh,5 			;renglón
	mov dl,44			;columna
	int 10h 			;posiciona el cursor
	lea dx,M3mnsj
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,5			;renglón
	mov dl,57			;columna
	int 10h 			;posiciona el cursor
	mueve si,offset Columnas
	mov ah,09h
	mov dx,si
	int 21h
	
	mov ah,08h
    int 21h
	xor ax,ax
	call limpia
	ret
sumcolrm endp
 
sumrenrm  proc
	; imprime cadena ---------------------------------------------------------------------- FUNCIONA
	mov ah,02
	mov bh,0 			;número de página
	mov dh,3 			;renglón
	mov dl,13			;columna
	int 10h 			;posiciona el cursor
	lea dx,Opfx
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,5 			;renglón
	mov dl,18			;columna
	int 10H				;posiciona el cursor
	lea dx,Opamp
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,6 			;renglón
	mov dl,18			;columna
	int 10h 			;posiciona el cursor
	
	mov dx, offset M1
	mov ah,0ah
	int 21h
	
	call matrix1
	
	mov bx, offset M1r
	mov si, offset Renglones
	mov cx,04
	otroRen:
		inc si
		xor ax,ax
		mov ctaEXT,cx
		mov cx,04
		SumaRen:
			add al,[bx]
			add bx,2
		loop SumaRen
		mov [si],al
		inc si
		inc si
		mov cx,ctaEXT
	loop otroRen
	
	call confirmacion
	
	cmp bl,53h; Comparar con S
	je sumrenrmrp
	cmp bl,1Bh; Comparar con ESC
	je rinf
	jmp sucesf
	
	sumrenrmrp:
	call sumrenrm
	rinf:
	call inicio
	
	sucesf:
	
	call limpia
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,3 			;renglón
	mov dl,13			;columna
	int 10H 			;posiciona el cursor
	lea dx,Opminsrt
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,5 			;renglón
	mov dl,6			;columna
	int 10h 			;posiciona el cursor
	lea dx,M1mnsj
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,5 			;renglón
	mov dl,10			;columna
	int 10h 			;posiciona el cursor
	call matrix1imp
	
	lea si,Renglones
	mov cx,04h
	mov dx,2Ch
	
	call retra
		
	mov ah,02
	mov bh,0 			;número de página
	mov dh,5 			;renglón
	mov dl,44			;columna
	int 10h 			;posiciona el cursor
	lea dx,M3mnsj
	mov ah,09
	int 21h 			;imprime la esquina
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,5			;renglón
	mov dl,57			;columna
	int 10h 			;posiciona el cursor
	mueve si,offset Renglones
	mov ah,09h
	mov dx,si
	int 21h
	
	mov ah,08h
    int 21h
	xor ax,ax
	call limpia
	ret
sumrenrm endp

multmmm proc
	xor ax,ax
	call multmmmr
	call multmmmr
	call multmmmr
	call multmmmr
	add bx,8
	mov si,recuerdb
	ret
multmmm endp

multmmmr proc
	xor ax,ax
	inc di
	mov [di],al
	call multmmmrt
	call multmmmrt
	call multmmmrt
	call multmmmrt
	inc di
	inc di
	sub si,30
	sub bx,8
	ret
multmmmr endp

multmmmrt proc
	xor ax,ax
	mov al,[bx];elemento de al = M1
	mul byte ptr[si];al = M1 * M2
	add [di],al;M3 = M1 * M2
	add bx,2
	add si,8
	ret
multmmmrt endp

matrixposicionar proc
	mov di, offset MTRx; di apunta a Maxwell
	inc si
	inc si
	mov cx,04h
	
	repetirdaaaa: 			;Convertir a hexadecimal
		mov ah,[si]
		mov [di],ah
		inc si
		inc di
		mov ah,[si]
		mov [di],ah
		inc si
		inc si
		inc di
		inc di
	loop repetirdaaaa
	mov recuerda,si
	
	mueve si,offset MTRx	;imprimir MTRx
	mov ah,09h
	mov dx,si
	int 21h
	
	mov si,recuerda
	mov di, offset MTRx; di apunta a Maxwell
	mov cx,04h
	
	repetirdaaaab: 			;Convertir a hexadecimal
		mov ah,[si]
		mov [di],ah
		inc si
		inc di
		mov ah,[si]
		mov [di],ah
		inc si
		inc si
		inc di
		inc di
	loop repetirdaaaab
	mov recuerda,si

	mov ah,02
	mov bh,0 			;número de página
	mov dh,6 			;renglón
	mov dl,[recuerdaimp];columna
	int 10h 			;posiciona el cursor
	
	mueve si,offset MTRx	;imprimir MTRx
	mov ah,09h
	mov dx,si
	int 21h
	
	mov si,recuerda
	mov di, offset MTRx; di apunta a Maxwell
	mov cx,04h
	
	repetirdaaaac: 			;Convertir a hexadecimal
		mov ah,[si]
		mov [di],ah
		inc si
		inc di
		mov ah,[si]
		mov [di],ah
		inc si
		inc si
		inc di
		inc di
	loop repetirdaaaac
	mov recuerda,si
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,7 			;renglón
	mov dl,[recuerdaimp];columna
	int 10h 			;posiciona el cursor
	
	mueve si,offset MTRx	;imprimir MTRx
	mov ah,09h
	mov dx,si
	int 21h
	
	mov si,recuerda
	mov di, offset MTRx; di apunta a Maxwell
	mov cx,04h
	
	repetirdaaaad: 			;Convertir a hexadecimal
		mov ah,[si]
		mov [di],ah
		inc si
		inc di
		mov ah,[si]
		mov [di],ah
		inc si
		inc si
		inc di
		inc di
	loop repetirdaaaad
	mov recuerda,si
	
	mov ah,02
	mov bh,0 			;número de página
	mov dh,8 			;renglón
	mov dl,[recuerdaimp];columna
	int 10h 			;posiciona el cursor
	
	mueve si,offset MTRx	;imprimir MTRx
	mov ah,09h
	mov dx,si
	int 21h
	
	ret	
matrixposicionar endp

end inicio