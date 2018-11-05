TITLE ejBN2 (ejBN2.asm)

; Uso de instrucciones, Directivas data y operadores.

INCLUDE \masm32\Irvine\Irvine32.inc

INCLUDELIB \masm32\Irvine\Irvine32.lib
includelib \masm32\Irvine\User32.lib
includelib \masm32\Irvine\Kernel32.lib

.DATA
texto      BYTE "El coronel no tiene " 
           BYTE "quien le escriba." 
           BYTE  0
conul      BYTE "enur"        ; caracteres a contabilizar
acont      DWORD 4 DUP (?)       ; total de cada carácter

;VAriables locales de proceso longitud
dirRet DWORD ?


.CODE
main PROC

    
main ENDP

longitud PROC
 pop dirRet
 pop esi ;direccion de string 
 mov edi , 0 ; indice
 cmp BYTE PTR [esi],0
.WHILE ZERO?
 call DumpRegs
 add edi , 4
 cmp BYTE PTR [esi+edi],0
.ENDW
 


 push dirRet
 RET

longitud ENDP

ejem PROC
    call DumpRegs
    RET
ejem ENDP

END main
