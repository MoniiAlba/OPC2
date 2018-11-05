TITLE ejBN1 (ejBN1.asm)

; Uso de instrucciones, Directivas data y operadores.

INCLUDE \masm32\Irvine\Irvine32.inc

INCLUDELIB \masm32\Irvine\Irvine32.lib
includelib \masm32\Irvine\User32.lib
includelib \masm32\Irvine\Kernel32.lib

.DATA
arreglo1    SDWORD  11, 10, 12, 14, 13, 10, 12
arreglo2    SDWORD  209, -131, -96, 160, -221, 85, -49
tamArreglo  SDWORD  LENGTHOF arreglo1
suma        SDWORD  ?

msgTermino  BYTE    " * ",0
msgIg       BYTE    " = ",0
msgTotal    BYTE    "Resultado: ",0
msgBye     BYTE    "ADIOS!",0


;Variables locales para SumaMulti
arr1    DWORD   ?
arr2    DWORD   ?
tamArr  SDWORD   ?
dirRet  DWORD   ?

.CODE
main PROC
    call Clrscr

    push OFFSET arreglo1
    push OFFSET arreglo2
    push tamArreglo
    call SumaMulti
    pop suma

    mov edx, OFFSET msgTotal
    call WriteString

    mov eax, suma
    call WriteInt
    call Crlf
    
    mov edx, OFFSET msgBye
    call WriteString
    
    exit
  
    
main ENDP

SumaMulti PROC
    pop dirRet
    pop tamArr
    pop esi
    pop edi
    mov ebx, 0 ;contador
    mov ecx, 0 ;sumaTot
    
    .WHILE ebx < tamArr 
          mov edx, 0 ;sumaTermino
          mov eax, SDWORD PTR [esi+(ebx*4)]
          call WriteInt
          mov edx, OFFSET msgTermino
          call WriteString
          mov eax, SDWORD PTR [edi + (ebx*4)]
          call WriteInt
          mov edx, OFFSET msgIg
          call WriteString
          mov edx, SDWORD PTR [esi+(ebx*4)]
          imul edx, SDWORD PTR [edi + (ebx*4)]
          mov eax, edx
          call WriteInt
          call Crlf
          add ecx, eax
          inc ebx
     .ENDW
    
    push ecx
    push dirRet

    RET

SumaMulti ENDP



ejem PROC
    call DumpRegs
    RET
ejem ENDP

END main
