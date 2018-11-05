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


.CODE
main PROC

    
main ENDP

longitud PROC


longitud ENDP

ejem PROC
    call DumpRegs
    RET
ejem ENDP

END main
