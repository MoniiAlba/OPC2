TITLE ejBN1 (ejC2.asm)

; Uso de instrucciones, Directivas data y operadores.

INCLUDE \masm32\Irvine\Irvine32.inc

INCLUDELIB \masm32\Irvine\Irvine32.lib
includelib \masm32\Irvine\User32.lib
includelib \masm32\Irvine\Kernel32.lib

.DATA
numN   DWORD   ?
numM   DWORD   ?
res    DWORD   ?


msgM    BYTE    "M: ",0
msgN    BYTE    "N: ",0
msgPot  BYTE    "Potencia de 2, peso ",0
msgProd BYTE    "Producto: ",0

msgBye     BYTE    "ADIOS!",0


;Para el procedimiento multBin
n   DWORD   ?
m   DWORD   ?
peso DWORD   0
cont    DWORD ?
dirRet  DWORD ?
acum DWORD  0


.CODE
main PROC
    call Clrscr

    mov edx, OFFSET msgM
    call WriteString
    call ReadInt
    call Crlf

    mov numM, eax

    mov edx, OFFSET msgN
    call WriteString
    call ReadInt
    call Crlf

    mov numN, eax
    
    mov ebx, numM
    .IF numN <= ebx
        push numN ;no se cambian
        push numM
    .ELSE
        push numM ;si se cambian
        push numN

    .ENDIF

    call MultBinaria

    pop res

    mov edx, OFFSET msgProd
    call WriteString
    

    mov eax, res
    call WriteDec
    call Crlf
    
    mov edx, OFFSET msgBye
    call WriteString
    
    exit
  
    
main ENDP

MultBinaria PROC
    pop dirRet
    pop m
    pop n


    mov eax, n
    test eax,1
    JZ asigPeso
    mov edx, OFFSET msgPot
    call WriteString 
    mov eax, 0
    call writeDec
    call Crlf

    mov eax, m
    add acum, eax

    
asigPeso: mov peso, 1
    shr n,1
    shl m, 1
    inc cont
    
    .WHILE cont < 32
        mov eax, n
        test eax,1
        JZ sigue
        mov edx, OFFSET msgPot
        call WriteString 
        mov eax, peso
        call WriteDec
        call Crlf
        mov ebx, m
        add acum, ebx

         
        
  sigue: shr n,1
        shl m, 1
        shl peso,1
        inc cont
    .ENDW
    
    push acum
    push dirRet

    RET

MultBinaria ENDP



END main
