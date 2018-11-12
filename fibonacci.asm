TITLE *MASM Template	(fibonacci.asm)*


INCLUDE \masm32\Irvine\Irvine32.inc

INCLUDELIB \masm32\Irvine\Irvine32.lib
includelib \masm32\Irvine\User32.lib
includelib \masm32\Irvine\Kernel32.lib

.DATA
n    SDWORD ?
prim    DWORD 0
sec    DWORD 1
acum    DWORD 1
texto    BYTE "Acumulado: ",0
textoNel   BYTE "N debe ser positiva",0
textoN   BYTE "Ingresa n: ",0
txtBye  BYTE "ADIOS!",0

.CODE
; Procedimiento principal
main PROC

    mov EDX, OFFSET textoN
    call WriteString
    

    call ReadInt
    mov n, EAX 

    .IF n>=1
        mov eax, prim
        call WriteInt
        call Crlf
        mov eax, sec
        call WriteInt
        call Crlf
        .WHILE n >=1
            mov ebx, prim
            mov ecx, sec
            add sec, ebx
            mov prim, ecx
            mov ebx, sec
            add acum, ebx
            
            mov eax, sec
            call WriteInt
            call Crlf
            dec n

        .ENDW
        mov edx, OFFSET texto
        call WriteString
        mov eax, acum
        call WriteInt
        call Crlf

        mov edx, OFFSET txtBye
        call WriteString
        call Crlf

    .ELSE
        mov EDX, OFFSET textoNel
        call WriteString

    .ENDIF   
    
    
    exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main