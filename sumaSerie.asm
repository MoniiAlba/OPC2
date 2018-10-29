TITLE *MASM Template	(sumaSerie.asm)*

; Descripcion:
; Tercer ejercicio del ensamblador
; 

INCLUDE \masm32\Irvine\Irvine32.inc

INCLUDELIB \masm32\Irvine\Irvine32.lib
includelib \masm32\Irvine\User32.lib
includelib \masm32\Irvine\Kernel32.lib

.DATA
N        DWORD ?
nTermino DWORD 1
acum     DWORD 0

.CODE
; Procedimiento principal
main PROC

    call ReadInt
    mov N, EAX
    mov ECX, N

holi: 
    mov EDX, OFFSET texto
    call WriteString
    call CrLf

    loop holi

    
    exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main