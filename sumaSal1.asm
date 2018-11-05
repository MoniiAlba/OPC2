TITLE SumaN (sumaSal1.asm)

; Uso de instrucciones, Directivas data y operadores.

INCLUDE \masm32\Irvine\Irvine32.inc

INCLUDELIB \masm32\Irvine\Irvine32.lib
includelib \masm32\Irvine\User32.lib
includelib \masm32\Irvine\Kernel32.lib

.DATA
auxRow      BYTE 8
n           SDWORD ?
sumaAcum    SDWORD   0


mensajeN    BYTE    "Teclee el dato N: ",0
mensajeTec  BYTE    "Teclee el ",0
mensajeSal  BYTE    " salario: ",0
mensajeTot  BYTE    "Resultado: ",0
mensajeBye  BYTE    "ADIOS",0


.CODE
main PROC
    call Clrscr

    mov  DL,14  ;column
    mov  DH,auxRow  ;row
    call Gotoxy

    mov edx,OFFSET mensajeN
    call WriteString
    call ReadInt
    call Crlf
    mov n, eax

    mov esi, n
    mov edi, 1
    mov ecx, sumaAcum
    ;PROC SALARIO
    call Salarios
    mov sumaAcum, ecx

    mov  DL,14
    inc auxRow
    mov DH, auxRow
    call Gotoxy
    
    mov edx, OFFSET mensajeTot
    call WriteString
    mov eax, sumaAcum
    call WriteInt
    call Crlf

    mov  DL,14
    inc auxRow
    mov DH, auxRow
    call Gotoxy
    
    mov edx, OFFSET mensajeBye
    call WriteString

    exit
  
    
main ENDP

Salarios PROC
    .WHILE edi <= esi
        call Possal
        call ReadInt
        call Crlf

        add ecx, eax
        inc edi
    .ENDW
    RET
Salarios ENDP

Possal PROC
    mov  DL,14
    inc auxRow
    mov DH, auxRow
    call Gotoxy
        
    mov edx,OFFSET mensajeTec
    call WriteString
    mov eax, edi
    call WriteInt
    mov edx, OFFSET mensajeSal
    call WriteString
        
    RET
Possal ENDP


ejem PROC
    call DumpRegs
    RET
ejem ENDP

END main
