TITLE *MASM Template	(ejercicioBNExtra.asm)*

INCLUDE \masm32\Irvine\Irvine32.inc

INCLUDELIB \masm32\Irvine\Irvine32.lib
includelib \masm32\Irvine\User32.lib
includelib \masm32\Irvine\Kernel32.lib

.DATA
msg1 BYTE "Dato factor: ",0
msg2 BYTE "Dato n: ",0 
msgT1 BYTE "Teclee el ",0
msgT2 BYTE " dato: ",0
msgMul BYTE "Multiplico factor ",0
msgMul2 BYTE " por dato ",0
msgMul3 BYTE " : ",0
msgMP BYTe "Impresion de datos: ",0
msgErr BYTE "ERROR por n<1 o n>50; ADIOS.",0 
msgErr2 BYTE "ERROR por factor<0 o n>9; ADIOS.",0 
msgM BYTE "Dato ",0
msgP BYTE ": ",0
msgC BYTE ", ",0
msgPAR BYTE " P",0
msgIm BYTE " I",0
msgBye  BYTE "ADIOS.",0
msgInv  BYTe    "Inviertiendo arreglo",0
msgVivo BYTE    "Cambio", 0

factor SDWORD ?
n SDWORD ?
arrLista SDWORD 50 dup(?)
indice DWORD 1
nc DWORD ?
vc SDWORD 0


;variables locales para FacLista
tam DWORD ?
fac SDWORD ?
arr SDWORD ?
retDir DWORD ?

;variables locales para imprime
tam2 DWORD ?
retDir2 DWORD ?




.CODE
; Procedimiento principal
main PROC
    call Clrscr

    mov edx,OFFSET msg1
    call WriteString
    call ReadInt
    call Crlf
    mov factor, eax

    .IF (factor >= 0) && (factor <=9)
        mov edx,OFFSET msg2
        call WriteString
        call ReadInt
        call Crlf
        mov n, eax
        
        mov ecx, 0
        .IF (n>=1) && (n<=50)
            .WHILE ecx < n
                mov edx,OFFSET msgT1
                call WriteString
                mov eax, ecx
                inc eax
                call WriteInt
                mov edx, OFFSET msgT2
                call WriteString
                call ReadInt
                call Crlf 
                push SDWORD PTR eax
                mov arrLista[ecx*TYPE arrLista], eax
                inc ecx
             .ENDW

            ;llamamos procedimiento que multiplica
            push n
            push factor
            push OFFSET arrLista
            call FacLista

            call Crlf
            mov edx, OFFSET msgMP
            call WriteString
            call Crlf

            call Crlf
            
            ;llamamos procedimiento que imprime
            push OFFSET arrLista
            push n
            call imprime

            call Crlf
            mov edx, OFFSET msgBye
            call WriteString
            call Crlf

        .ELSE
            mov edx, OFFSET msgErr
            call WriteString
            call Crlf 
        .ENDIF

    .ELSE
        mov edx, OFFSET msgErr2
        call WriteString
        call Crlf          
    .ENDIF
    
    exit
main ENDP

    FacLista PROC
        pop retDir ;direccion retorno
        
        pop ecx    ;arreglo
        pop fac    ;factor
        pop tam    ;n

        mov edi, 0  ;contador        
        .WHILE SDWORD PTR edi < tam

            mov edx, OFFSET msgMul
            call WriteString
            mov eax, fac
            call WriteInt
            mov edx, OFFSET msgMul2
            call WriteString
            mov eax, SDWORD PTR [ecx +edi*4]
            call WriteInt
            mov edx, OFFSET msgMul3
            call WriteString
            mov edx, 0
            mov eax, fac
            imul SDWORD PTR [ecx +edi*4]
            call WriteInt
            call Crlf

            mov [ecx +edi*4], eax         
            
            
            inc edi
        .ENDW

        push retDir
        RET
    FacLista ENDP


    imprime PROC
        pop retDir2
        pop tam2
        pop ecx

        mov esi, 0
          .WHILE esi < tam2
              mov edx, OFFSET msgM
              call WriteString
              mov eax, esi
              inc eax
              call WriteInt
              mov edx, OFFSET msgP
              call WriteString
              mov eax, [ecx +esi*4]
              call WriteInt
              call Crlf
              inc esi
          .ENDW
          push retDir2
          RET
    imprime ENDP

END main