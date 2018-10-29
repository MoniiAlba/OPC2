TITLE Program Template          (RevStr.asm)

; Este programa revierte (invierte) un String.

; Ejercicio BK

; Irvine Library procedures and functions
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib
; End Irvine

.DATA
usuario BYTE "Ingresar cadena de 1 a 30 caracteres ", 0
;texto BYTE "Las quince letras", 0
mnsg BYTE 0Ah, 0Dh, "Texto invertido: ", 0
lonTxt WORD LENGTHOF texto - 1
i SWORD 0
mitad WORD ?
MAX = 30
texto BYTE MAX+1 DUP(?)

.CODE
main PROC

    ; Mensaje para el usuario
      mov edx, OFFSET usuario
	call WriteString

    ; Leer string
      mov edx, OFFSET texto
      mov ecx, MAX
      call ReadString
      mov edx, OFFSET texto
	call WriteString

    ; Verificar longitud
      ;mov ax, LENGTHOF texto - 1
      ;mov lonTxt, ax
      call WriteInt

      ;.IF (lonTxt >= 1) && (lonTxt <=30)
      mov edi, eax
      dec edi
      
    ; Invertir el texto del String
      mov dx, 0
      mov bx, 2
      idiv bx
      call WriteInt
      mov edx, OFFSET texto
	call WriteString

     



      .WHILE i < SWORD PTR ax
        
        movzx esi, i
        mov bl, BYTE PTR [texto + esi]
        
        mov ecx, edi 
        sub ecx, esi
        ;dec ecx
        mov dl, BYTE PTR [texto + ecx]
        mov [texto + esi], dl
        mov [texto + ecx], bl
        add i, 1
       
      .ENDW
      ; mov texto, " "
      mov edx, OFFSET texto
	call Writestring


    ; Despliega el texto invertido.
	mov edx,OFFSET mnsg
	call Writestring
	mov edx,OFFSET texto
	call Writestring
	call CrLf

	exit
main ENDP

END main