TITLE *MASM Template	(ejercicioBE.asm)*

; Descripcion:
; Tercer ejercicio del ensamblador
; 

INCLUDE \masm32\Irvine\Irvine32.inc

INCLUDELIB \masm32\Irvine\Irvine32.lib
includelib \masm32\Irvine\User32.lib
includelib \masm32\Irvine\Kernel32.lib

.DATA
A    SDWORD 7
B    SDWORD ?
D    SDWORD -15
R    SDWORD ?
texto    BYTE "Ingresa el dato de B: ",0
textoR   BYTE "El resultado R = ",0
textoRH   BYTE "El resultado Rh = ",0

.CODE
; Procedimiento principal
main PROC

    mov EDX, OFFSET texto
    call WriteString
    

    call ReadInt
    mov B, EAX    
    
    mov EBX, A
    neg EBX
    add EBX, 9
    sub EBX, B
    add EBX, D
    inc EBX
    mov R, EBX

    mov EDX, OFFSET textoR
    call WriteString
    

    mov EAX, R
    call WriteInt
    call CrLf

    mov EDX, OFFSET textoRH
    call WriteString
    

    mov EAX, R
    call WriteHex
    call CrLf

    mov ESI, OFFSET A
    mov ECX, 4
    mov EBX, 4
    call DumpMem

    
    exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main