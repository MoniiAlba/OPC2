TITLE *MASM Template	(tarea2Clase2.asm)*

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

n SDWORD ?
temp SDWORD 10 dup(?)
indice DWORD 1
nc DWORD ?
vc SDWORD 0




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
        mov edi, 0 ;primer indice (ind1)
        mov ebx, 0 ;segundo indice (ind2)

        .WHILE edi < n-1
            mov ebx, edi
            inc ebx
            .WHILE ebx < n
                mov esi, temp[ebx*4]
                .IF SDWORD PTR temp[edi*4] > SDWORD PTR esi
                    mov eax, temp[ebx*4]
                    xchg eax, temp[edi*4]
                    mov temp[ebx*4], eax
                .ENDIF
                inc ebx
            .ENDW
            inc edi
        .ENDW
        call Crlf
        mov edx, OFFSET msgInv
        call WriteString
        call Crlf
        
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
        
        

        ;para imprimir al reves
         ; mov eax, n
 ;         dec eax
 ;         mov ecx, 4
 ;         mul ecx
 ;         mov ecx, eax  ;indice
 ; 
 ;         .WHILE SDWORD PTR ecx >= 0
 ;             
 ;             mov edx, OFFSET msgT
 ;             call WriteString
 ;             mov eax, ecx
 ;             sub edx, edx
 ;             mov ebx, 4
 ;             div ebx
 ;             inc eax
 ;             call WriteInt
 ;             and eax, 1
 ;             .IF ZERO? 
 ;                 mov  esi, OFFSET msgPAR
 ;             .ELSE
 ;                 mov  esi, OFFSET msgIm
 ;             .ENDIF
 ; 
 ;             mov edx, OFFSET msgP
 ;             call WriteString
 ;             ;mov eax, [temp+ecx]
 ;             pop eax
 ;             call WriteInt
 ;             mov edx, OFFSET msgC
 ;             call WriteString
 ;             inc eax
 ; 
 ;             mov  edx, esi
 ;             call WriteString
 ; 
 ;             call Crlf
 ;             sub ecx, 4
 ; 
 ;         .ENDW
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
; Termina el procedimiento principal

; Termina el area de Ensamble
END main