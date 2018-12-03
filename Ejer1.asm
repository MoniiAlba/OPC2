TITLE *MASM Template	(ejercicioBE.asm)*

; Descripcion:
; Tercer ejercicio del ensamblador
; 

INCLUDE \masm32\Irvine\Irvine32.inc

INCLUDELIB \masm32\Irvine\Irvine32.lib
includelib \masm32\Irvine\User32.lib
includelib \masm32\Irvine\Kernel32.lib

.DATA
arr  DWORD 8 dup(?)
n    SDWORD ?
desp SDWORD ?
texto    BYTE "N: ",0
txt1   BYTE "Bits a desplazar: ",0
txt2  BYTE "Inicial: ",0
txt3  BYTE "Una vez desplazados: ",0
txtRes BYTE "Resultados ",0
txtAdios BYTE "ADIOS",0

;Variables locales procedimiento
dirRet DWORD ?
msg1 BYTE "Dword ",0
msg2 BYTE "o: ",0

.CODE
; Procedimiento principal
main PROC

    mov EDX, OFFSET texto
    call WriteString
    

    call ReadInt
    mov n, EAX   

    ;Procedimiento para leer datos
    push OFFSET arr
    push n 
    call leeDatos
    mov EDX, OFFSET txt1
    call WriteString
    call ReadInt
    mov desp , eax
    call Crlf
    mov EDX, OFFSET txtRes
    call WriteString
    call Crlf
    mov edx, OFFSET txt2
    call WriteString
    call Crlf
    push OFFSET arr
    push n
    call escribeBin

    ;desplazamiento
    push desp
    push n
    push OFFSET arr
    call srnArr

    mov edx, OFFSET txt3
    call WriteString
    call Crlf
    push OFFSET arr
    push n
    call escribeBin
    mov EDX, OFFSET txtAdios
    call WriteString
    call Crlf
    
    exit
main ENDP

leeDatos PROC
    pop dirRet
    pop esi ; N 
    pop ecx ; apuntador arreglo
    mov edi,0 ; contador
    .WHILE  edi < DWORD PTR esi
        mov EDX, OFFSET msg1
        call WriteString
        mov eax, edi
        call Writeint
        mov EDX, OFFSET msg2
        call WriteString
        call ReadHex
        mov [ecx + edi*4], eax
        inc edi
        call Crlf
    .ENDW
    
    ;mov esi,ecx
    ;mov ecx, 8
    ;mov ebx, 4
    ;call DumpMem
    push dirRet
    RET
leeDatos ENDP

escribeBin PROC
    pop dirRet
    pop esi ;numero de elementos
    pop edi  ; direccion arr
    mov ecx, 0
    .WHILE ecx < esi
        mov eax, [edi+ecx*4]
        call WriteBin
        call Crlf
        inc ecx
    .ENDW
    push dirRet
    RET
escribeBin ENDP
srnArr PROC
    pop edx ;dir retorno
    pop esi ;direccion arr
    pop edi ; num elem
    pop ebx ; num de veces del shift
    mov ecx, 0 ; cont
    ; call DumpRegs
    .WHILE ecx < desp
        pushad
        push edi
        push esi
        call srArr
        popad
        inc ecx
       ; call DumpRegs
    .ENDW
    ;mov eax, 6661
    ;call WriteInt
    push edx
    RET
srnArr ENDP
srArr PROC
    pop dirRet
    pop esi ; direccion arr
    pop edi ; num elementos arr
    mov ebx , 1 ; contador
    clc
    rcr DWORD PTR [esi],1
    pushfd
    .WHILE ebx < edi
        popfd
        rcr DWORD PTR [esi+ebx*4] , 1
        pushfd
        inc ebx
         ;call DumpRegs
    .ENDW
    popfd
    ;mov eax, 666
    ;call WriteInt
    push dirRet
    RET
srArr ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main