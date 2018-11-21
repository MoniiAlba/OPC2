TITLE ejBN1 (ejCD.asm)

; Uso de instrucciones, Directivas data y operadores.

INCLUDE \masm32\Irvine\Irvine32.inc

INCLUDELIB \masm32\Irvine\Irvine32.lib
includelib \masm32\Irvine\User32.lib
includelib \masm32\Irvine\Kernel32.lib

.DATA
MAX = 20                     ;max chars to read
string1 BYTE MAX+1 DUP (?)  ;room for null
string2 BYTE MAX+1 DUP (?)  ;room for null
res    DWORD   ?


msgM    BYTE    "Ingrese primer string: ",0
msgN    BYTE    "Ingrese segundo string: ",0
msgPot  BYTE    "Potencia de 2, peso ",0
msgProd BYTE    "Producto: ",0

msgBye     BYTE    "ADIOS!",0


;SOLAMENTE Para el procedimiento compareTo
s1   DWORD   ?
s2   DWORD   ?
peso DWORD   0
cont    DWORD ?
dirRet  DWORD ?
acum DWORD  0


.CODE
main PROC
    call Clrscr
    
    mov edx, OFFSET msgM
    call WriteString
    mov  edx,OFFSET string1
    mov  ecx,MAX            ;buffer size - 1
    call ReadString
    call Crlf

    mov edx, OFFSET msgN
    call WriteString
    mov  edx,OFFSET string2
    mov  ecx,MAX            ;buffer size - 1
    call ReadString
    call Crlf

    push OFFSET string2
    push OFFSET string1
    call compareTo
    pop eax
    call WriteInt
    
    mov edx, OFFSET string1
    call WriteString
    call Crlf

    mov edx, OFFSET string2
    call WriteString
    call Crlf

    mov  esi,OFFSET string1
    mov ecx, LENGTHOF string1
    mov ebx, TYPE string1
    call dumpMem
    
    mov edx, OFFSET msgBye
    call WriteString
    
    exit
  
    
main ENDP

compareTo PROC
    pop dirRet
    pop esi  ;s1
    pop edi  ;s2

    mov ecx, 0 ;cont
    mov al, [edi] ; s2
    test [esi],al
    
    .WHILE !ZERO? && al == [esi+ecx]
        inc ecx
        mov al, [edi+ecx]
        test [esi+ecx], al
        call DumpRegs
    .ENDW

    .IF [esi+ecx] == al
        mov ebx, 0
    .ELSEIF ([esi+ecx] < al) || BYTE PTR [esi+ecx] == 0
        inc ecx
        mov eax, -1
        imul ecx
        mov ebx, eax
    .ELSE
        inc ecx
        mov ebx,ecx
    .ENDIF   

    
    push ebx
    push dirRet

    RET

compareTo ENDP



END main
