TITLE SumaN (sumaSal.asm)

; Uso de instrucciones, Directivas data y operadores.

INCLUDE \masm32\Irvine\Irvine32.inc

INCLUDELIB \masm32\Irvine\Irvine32.lib
includelib \masm32\Irvine\User32.lib
includelib \masm32\Irvine\Kernel32.lib

.DATA
mensajeN    BYTE    "Teclee el dato N: ",0
mensajeTec  BYTE    "Teclee el ",0
mensajeSal  BYTE    " salario: ",0
mensajeTot  BYTE    "Resultado: ",0
mensajeErr  BYTE    "N debe ser mayor que 0. Sale del programa",0
sigTermino  DWORD   -2
n           DWORD   ?
sumaAcum    DWORD   0
signo       SDWORD   -1    
auxSigno    SDWORD  -1

auxRow      BYTE 8



.CODE
main PROC
    call Clrscr

    mov  DL,14  ;column
    mov  DH,auxRow  ;row
    call Gotoxy
    
    mov edx,OFFSET mensajeN
    ;call DumpRegs
    call WriteString
    call ReadInt
    call Crlf


    .IF (n >= 1)

        
        call salario

        
        call DumpRegs
        mov edx, OFFSET mensajeTot
        call WriteString
        mov eax, sumaAcum
        call WriteInt
        
    .ENDIF
    exit
main ENDP

    Salarios PROC
        mov n, eax
        mov ecx, 1
        

 ;         .WHILE ecx <= n
 ;                                   
 ;             call Possal
 ;             call ReadInt
 ;             call Crlf 
 ; 
 ;             ADD   sumaAcum, eax           
 ;             inc ecx
 ; 
 ;          .E
        ;call dumpregs
        RET
        
    Salarios ENDP


    salario PROC
        call DumpRegs
        RET
    salario ENDP
        
    Possal PROC
        mov  DL,14
        inc auxRow
        mov DH, auxRow
        call Gotoxy
        
        mov edx,OFFSET mensajeTec
        call WriteString
        mov eax, ecx
        call WriteInt
        mov edx, OFFSET mensajeSal
        call WriteString
        
        RET
    Possal ENDP
END main