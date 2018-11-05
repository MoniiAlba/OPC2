TITLE ejBN22 (ejBN22.asm)

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
mssgLongitud BYTE "Longitud del string: ",0
longitudRes SDWORD ?

;VAriables locales de proceso longitud
dirRet DWORD ?

;Varibales locales del proceso imprimeT

msgTxt BYTE "Texto: ",0
msgLng BYTE "    Longitud: ",0
msgCar BYTE " caracteres",0


.CODE
main PROC
    push OFFSET texto
    call longitud
    pop longitudRes
    push longitudRes
    push OFFSET texto
    call imprimeT
    

    exit
    
main ENDP

longitud PROC
 pop dirRet
 pop esi ;direccion de string 
 mov edi , 0 ; indice
 
.WHILE BYTE PTR [esi+edi]!= 0
 inc edi
.ENDW

 push edi ; regresa la longitud del string
 push dirRet
 RET

longitud ENDP

imprimeT PROC
 pop dirRet
 pop esi ; Direccion del string a imprimir
 pop edi ; Tam del string

 mov edx , OFFSET msgTxt
 call WriteString
 mov edx , esi
 call WriteString
 mov edx, OFFSET msgLng
 call WriteString
 mov eax, edi
 call WriteInt
 mov edx, OFFSET msgCar
 call WriteString
 push dirRet
 RET
imprimeT ENDP

ctaenur PROC
 pop dirRet
 pop esi ;Direccion del string
 pop edi ;Direccion del arreglo de letras a buscar
 pop eax ;Longitud del string
 pop edx ;Arreglo acont
 mov ebx, 0

 .WHILE ebx < eax
   mov cl, [esi+ebx] ; elemento actual
   .IF cl == [edi]
     inc [edx]
   .ELSEIF cl == [edi+1]
     inc [edx+1]
   
   .ENDIF
     
 
 .ENDW

 push dirRet
 RET

ctaenur ENDP

ejem PROC
    call DumpRegs
    RET
ejem ENDP

END main
