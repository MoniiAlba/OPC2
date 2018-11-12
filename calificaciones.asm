TITLE *MASM Template	(calificaciones.asm)*


INCLUDE \masm32\Irvine\Irvine32.inc

INCLUDELIB \masm32\Irvine\Irvine32.lib
includelib \masm32\Irvine\User32.lib
includelib \masm32\Irvine\Kernel32.lib

.DATA
n    SDWORD ?
cal    SDWORD ?
sec    DWORD 1
acum    DWORD 1
lA    BYTE "A",0
lB    BYTE "B",0
lC    BYTE "S",0
lD    BYTE "D",0
tabu   BYTE 09h,0
texto   BYTE "Calificacion no valida. Intente de nuevo",0
textoNel   BYTE "N debe ser positiva",0
textoN   BYTE "Ingresa n: ",0
txtCal  BYTE "Ingresa calificacion: ",0

txtBye  BYTE "ADIOS!",0

.CODE
; Procedimiento principal
main PROC

    mov EDX, OFFSET textoN
    call WriteString
    

    call ReadInt
    mov n, EAX 

    .IF n>=1
        .WHILE n >=1
            call Crlf
            mov edx, OFFSET txtCal
            call WriteString

            call ReadInt
            mov cal, eax
            call Crlf
            .IF (cal >= 90) && cal <=100
                mov eax, cal
                call WriteInt
                mov edx, OFFSET tabu
                call WriteString
                mov edx, OFFSET lA
                call WriteString
                call Crlf
                

            .ELSEIF cal >= 75
                mov eax, cal
                call WriteInt
                mov edx, OFFSET tabu
                call WriteString
                mov edx, OFFSET lB
                call WriteString
                call Crlf
            .ELSEIF cal >= 60
                mov eax, cal
                call WriteInt
                mov edx, OFFSET tabu
                call WriteString
                mov edx, OFFSET lC
                call WriteString
                call Crlf
             .ELSEIF cal >=0
                mov eax, cal
                call WriteInt
                mov edx, OFFSET tabu
                call WriteString
                mov edx, OFFSET lD
                call WriteString
                call Crlf
            .ELSE
                mov edx, OFFSET texto
                call WriteString
                call Crlf
                inc n
            .ENDIF
            dec n
        .ENDW
        
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