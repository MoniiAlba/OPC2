TITLE SumaN (sumaN.asm)

; Uso de instrucciones, Directivas data y operadores.

INCLUDE \masm32\Irvine\Irvine32.inc

INCLUDELIB \masm32\Irvine\Irvine32.lib
includelib \masm32\Irvine\User32.lib
includelib \masm32\Irvine\Kernel32.lib

.DATA
mensajeN    BYTE    "Teclee el dato N: ",0
mensajeSig  BYTE    "Siguiente termino: ",0
mensajeTot  BYTE    "TOTAL: ",0
mensajeErr  BYTE    "N debe ser mayor que 0. Sale del programa",0
sigTermino  DWORD   -2
N           DWORD   ?
sumaAcum    DWORD   0
signo       SDWORD   -1    
auxSigno    SDWORD  -1



.CODE
main PROC
; Escriba comentarios

    MOV     EDX, OFFSET mensajeN
    CALL    WriteString
    CALL    ReadInt
    CALL    Crlf
    MOV     N, EAX

    ;ve que N sea mayor o igual que 1, en caso contrario sale del programa
    CMP     EAX, 1
    JGE     continua

    salida:
        MOV     EDX, OFFSET mensajeErr
        CALL    WriteString
        CALL    Crlf

        exit

    continua:

        mov ECX, N  ;N veces en 
    
        sigTer: 
         MOV   EDX, OFFSET mensajeSig
         CALL  WriteString
         ADD   sigTermino, 3
         MOV   EAX, sigTermino

         MUL   signo
         
         
         CALL  WriteInt
         CALL  Crlf

   
         ;vamos a sumar
         ADD   EAX, sumaAcum
         MOV   sumaAcum, EAX
           
         ;modificamos signo
         MOV   EAX, signo
         MUL   auxSigno
         MOV   signo, EAX
         
         loop sigTer

         MOV  EDX, OFFSET mensajeTot
         CALL WriteString
         MOV EAX, sumaAcum
         CALL WriteInt
         CALL Crlf

	exit
main ENDP
END main