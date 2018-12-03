TITLE Program Template          (cc4.asm)

; Irvine Library procedures and functions
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib
; End Irvine

.DATA
usuario1 BYTE "Escribe un DWORD: ", 0
usuario2 BYTE "Escribe un DWORD: ", 0
buffer1 BYTE 8 dup('x'),0
buffer2 BYTE 8 dup('x'),0
MAX = 80

str1    DWORD ?

dirRet DWORD ?


.CODE
main PROC

    ; Mensaje para el DWORD
      mov edx, OFFSET usuario1
	call WriteString

    ; Leer el DWORD
      mov  edx,OFFSET str1
      mov  ecx,MAX            ;buffer size - 1
      call ReadString


    ; DWORD se guarda en ebx
      mov ebx, eax

    ; Mensaje para el SDWORD
      mov edx, OFFSET usuario2
	call WriteString

    ; Leer el SDWORD
      ;call ReadString

    ; DWORD se guarda en ecx
      mov ecx, eax

    ; Convertir dword a string
      call dwToStr

    ; Convertir sdword a string
      ;call sdwToStr 

    ; imprimir dword
      mov edx, OFFSET buffer1
      call WriteString

    ; imprimir sdword
      mov edx, OFFSET buffer2
      call WriteString      
	
    exit

main ENDP

dwToStr PROC

dwToStr ENDP

sdwToStr PROC

sdwToStr ENDP

dwToStr PROC
    pop dirRet
    mov ECX, 0          ; counter
    mov EBP, EAX ; numero
    mov ESI, offset buffer1
    add ESI, 7
    mov edx, 0

    .WHILE (ECX < 8 ) 
        
        mov EBX, 16 ; muevo el divisor a ebx
        div ebx ; divido eax por 16
        ; edx trae el número a convertir a hex
        ; eax trae el resultado de la división

        mov EBP, EDX ; muevo el número para converción a string
        
        ; escribo el digito en el buffer
        .IF EBP == 0
            mov BYTE PTR [ESI], '0'
        .ELSEIF EBP == 1
            mov BYTE PTR [ESI], '1'
        .ELSEIF EBP == 2
            mov BYTE PTR [ESI], '2'
        .ELSEIF EBP == 3
            mov BYTE PTR [ESI], '3'
        .ELSEIF EBP == 4
            mov BYTE PTR [ESI], '4'
        .ELSEIF EBP == 5
            mov BYTE PTR [ESI], '5'
        .ELSEIF EBP == 6
            mov BYTE PTR [ESI], '6'
        .ELSEIF EBP == 7
            mov BYTE PTR [ESI], '7'
        .ELSEIF EBP == 8
            mov BYTE PTR [ESI], '8'
        .ELSEIF EBP == 9
            mov BYTE PTR [ESI], '9'
        .ELSEIF EBP == 10
            mov BYTE PTR [ESI], 'A'
        .ELSEIF EBP == 11
            mov BYTE PTR [ESI], 'B'
        .ELSEIF EBP == 12
            mov BYTE PTR [ESI], 'C'
        .ELSEIF EBP == 13
            mov BYTE PTR [ESI], 'D'
        .ELSEIF EBP == 14
            mov BYTE PTR [ESI], 'E'
        .ELSEIF EBP == 15
            mov BYTE PTR [ESI], 'F'
        .ENDIF
        
        dec ESI ; muevo l posicion
        inc ECX ; aumento el contador
    .ENDW      
    push esi
    push dirRet 
    ret
dwToStr ENDP

END main
