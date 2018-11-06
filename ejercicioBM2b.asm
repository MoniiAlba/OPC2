TITLE *MASM Template	(tarea2Clase2b.asm)*

; Descripcion:
; Mi primer programa.
; 
; Fecha de ultima modificacion:
; 05-oct-2018

INCLUDE \masm32\Irvine\Irvine32.inc

INCLUDELIB \masm32\Irvine\Irvine32.lib
includelib \masm32\Irvine\User32.lib
includelib \masm32\Irvine\Kernel32.lib

.DATA
msg1 BYTE "Dato n: ",0
msgT1 BYTE "Teclee la ",0
msgT2 BYTE " temperatura: ",0
msgM BYTE "Minimo de las temperaturas: ",0
msgMP BYTe "Posicion del minimo: ",0
msgErr BYTE "ERROR por n<1 o n>10; ADIOS.",0 
msgT BYTE "Temperatura ",0
msgP BYTE ": ",0
msgC BYTE ", ",0
msgPAR BYTE " P",0
msgIm BYTE " I",0
msgBye  BYTE "ADIOS.",0
msgInv  BYTe    "Inviertiendo arreglo",0
msgVivo BYTE    "Cambio", 0

n SDWORD ?
temp SDWORD 10 dup(?)
indice DWORD 1
nc DWORD ?
vc SDWORD 0


;variables locales para VecSelDir
tam DWORD ?
tam2 DWORD ?
indice1 DWORD ?
indice2 DWORD ?
arr SDWORD ?
retDir DWORD ?




.CODE
; Procedimiento principal
main PROC
    call Clrscr

    mov edx,OFFSET msg1
    call WriteString
    call ReadInt
    call Crlf
    mov n, eax
    mov ecx, 1
    mov ebx, 0
    .IF (n >= 1) && (n <=10)
        .WHILE ecx <= n
            mov edx,OFFSET msgT1
            call WriteString
            mov eax, ecx
            call WriteInt
            mov edx, OFFSET msgT2
            call WriteString
            call ReadInt
            call Crlf 
            push SDWORD PTR eax
            mov temp[ebx*TYPE temp], eax
            inc ebx            
            inc ecx
         .ENDW
         
        ;para calcular el minimo
        mov ebx, OFFSET temp
        mov eax, [ebx] ;primer elemento
        mov ecx, 1
        .WHILE ecx <= n
            .IF SDWORD PTR eax > [ebx]
                mov eax, [ebx]
                mov indice, ecx
            .ENDIF
            inc ecx
            add ebx, 4

        .ENDW

        dec indice
        mov edx, OFFSET msgM
        call WriteString

        call WriteInt
        call Crlf  
        mov edx, OFFSET msgMP
        call WriteString
        mov eax, indice
        call WriteInt
        call Crlf
        call Crlf

        mov ESI, OFFSET temp
        mov ECX, n
        mov EBX, 4
        call DumpMem
        call Crlf

        ;para ordenar el arreglo de menor a mayor con algoritmo dado
        ;usando procedimiento VecSelDir
        push n
        push 0
        push 0
        push OFFSET temp
            
        
        call Crlf
        mov edx, OFFSET msgInv
        call WriteString
        call Crlf
        
        call VecSelDir
       
        mov ESI, OFFSET temp
        mov ECX, n
        mov EBX, 4
        call DumpMem
        call Crlf

        ;para imprimir en nuevo orden
        mov esi, 0
        .WHILE esi < n
            mov edx, OFFSET msgT
            call WriteString
            inc esi
            mov eax, esi
            call WriteInt
            dec esi
            mov edx, OFFSET msgP
            call WriteString
            mov eax, temp[esi*4]
            call WriteInt
            call Crlf
            inc esi


        .ENDW
        
        

          call Crlf
          mov edx, OFFSET msgBye
          call WriteString
          call Crlf 

    
        
        
    .ELSE
        mov edx, OFFSET msgErr
        call WriteString
        call Crlf   
    .ENDIF
    


    
    exit
main ENDP

    VecSelDir PROC
        pop retDir
        
        pop ecx    ;arreglo
        pop ebx    ;indice2
        pop edi    ;indice1
        pop tam

        mov eax, tam
        mov tam2, eax
        dec tam2
        
        .WHILE SDWORD PTR edi < tam2

            mov ebx, edi
            inc ebx
            
            
            .WHILE SDWORD PTR ebx < tam
                mov esi, [ecx + ebx*4]
                
                .IF SDWORD PTR [ecx +edi*4] > SDWORD PTR esi
                    mov eax, [ecx + ebx*4]
                    xchg eax, [ecx + edi*4]
                    mov [ecx +ebx*4], eax
                .ENDIF
                inc ebx
            .ENDW
            inc edi
        .ENDW

        push retDir
        RET
    VecSelDir ENDP

END main