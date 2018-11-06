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
acont      DWORD 4 DUP (0)       ; total de cada car�cter
mssgLongitud BYTE "Longitud del string: ",0
longitudRes SDWORD ?

;VAriables locales de proceso longitud
dirRet DWORD ?

;Varibales locales del proceso imprimeT

msgTxt BYTE "Texto: ",0
msgLng BYTE "    Longitud: ",0
msgCar BYTE " caracteres",0

;Variables imprimeCta
msgC BYTE "Caracter",0
msgCtd BYTE "cantidad",0


.CODE
main PROC
    push OFFSET texto
    call longitud
    pop longitudRes
    push longitudRes
    push OFFSET texto
    call imprimeT
    call Crlf

    ;FUNCION cuenta letras
    push OFFSET acont
    push longitudRes
    push OFFSET conul
    push OFFSET texto
    ;mov eax , acont[0]
    ;call WriteInt
    call ctaenur
    call Crlf

    ;mov eax , acont
    ;call WriteInt
    ;call Crlf
    ;mov eax, acont[4]
    ;call WriteInt
    ;Imprime tabla de caracteres
    push OFFSET acont
    push OFFSET conul
    call imprimeCta
    call Crlf
    
    

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
 mov ebx, 0 ;indice



 .WHILE ebx < eax
   mov cl, [esi+ebx] ; elemento actual
   .IF cl == [edi]
     inc DWORD PTR [edx]
   .ELSEIF cl == [edi+1]
     inc DWORD PTR [edx+4]
    .ELSEIF cl == [edi+2]
     inc DWORD PTR [edx+8]
    .ELSEIF cl == [edi+1]
     inc DWORD PTR [edx+12]
   .ENDIF
     
  inc ebx
 .ENDW

 push dirRet
 RET

ctaenur ENDP

imprimeCta PROC
  pop dirRet
  pop esi ; direccion conul
  pop edi ; direccion acont
  
  mov dl , 20
  mov dh, 5
  call Gotoxy
  mov edx, OFFSET msgC
  call WriteString

  mov dl , 40
  mov dh, 5
  call Gotoxy
  mov edx, OFFSET msgCtd
  call WriteString

  ;imprime letras
  mov ecx, 0
  mov ebx, 5
  .WHILE ecx < 4
    add ebx,3
    mov dl , 15
    mov dh, bl
    call Gotoxy
    mov al, [esi+ecx]
    call WriteChar

    mov dl , 45
    mov dh, bl
    call Gotoxy
    mov eax, [edi+ecx*4]
    call WriteInt
    inc ecx
  .ENDW

  push dirRet
imprimeCta ENDP

END main
