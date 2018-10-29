TITLE Program Template          (RevStrBJ.asm)

; Este programa revierte (invierte) un String.

; Irvine Library procedures and functions
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib
; End Irvine

.DATA
texto BYTE "Las quince letras", 0
mnsg BYTE 0Ah, 0Dh, "Texto invertido: ", 0
lonTxt WORD LENGTHOF texto - 1
i SWORD 0
mitad WORD ?
adios BYTE "Adios", 0

.CODE
main PROC

    ; Imprime el texto.
      mov edx, OFFSET texto
	call WriteString
	call CrLf

    ; Invertir el texto del String
      mov dx, 0
      mov ax, lonTxt
      mov bx, 2
      idiv bx
      ;Call WriteHex

      .WHILE i < SWORD PTR ax
        movzx esi, i
        mov bl, BYTE PTR [texto + esi]
        movzx ecx, lonTxt
        sub ecx, esi
        mov dl, BYTE PTR [texto + ecx]
        mov [texto + esi], dl
        mov [texto + ecx], bl
        add i, 1
      .ENDW
      mov texto, " "

    ; Despliega el texto invertido.
	mov edx,OFFSET mnsg
	call Writestring
	mov edx,OFFSET texto
	call Writestring
	call CrLf
      mov edx,OFFSET adios
	call Writestring
	call CrLf
      mov ax, SIZEOF texto - 3
      mov ax, SWORD PTR ax
      movzx eax, ax
      Call WriteInt 

	exit
main ENDP

END main