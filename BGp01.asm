TITLE Ejercicio suma de arreglo

; Descripcion:
; Ejemplo de uso de direccionamiento indirecto con operandos indirectos,
; en la suma de elementos de un arreglo.
; Todas las impresiones enteras se haran en Hexadecimal.

; Irvine Library procedures and functions
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib
; End Irvine

.DATA
; Variables
arraySD SDWORD 1001h, 2002h, 3003h, 4004h, 5005h        ; en Hexadecimal

; Textos para la Consola
mcr = 0dh
mlf = 0ah
mnul = 0h
prtit 	BYTE mcr, mlf, "Ejercicio suma op. indirecto", mcr, mlf, mnul
pradi 	BYTE mcr, mlf, "ADIOS.", mcr, mlf, mnul
prtot 	BYTE mcr, mlf, "Total: ", mnul

.CODE
; Procedimiento principal
main PROC
	mov edx,OFFSET prtit
	call WriteString

	mov esi, offset arraySD
	mov ecx, 0    ; acumulador
	mov ebx, 1    ; contador

      suma:
      CMP ebx, lengthof arraySD
      JA  salida

      add ecx, [esi]
      mov eax, [esi] 
      call WriteHex
      call Crlf
      add esi, type arraySD
      inc ebx
      jmp suma
      
      
        
	
      ; ***** COMPLETAR
      
	; Total
	salida: 
        mov edx, OFFSET prtot
	call WriteString
	mov eax, ecx
	call WriteHex
	call Crlf
	
	; ADIOS
	mov edx,OFFSET pradi
	call WriteString
	call Crlf

	exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main