TITLE SgExm18.asm

; Esqueleto para el segundo examen.

; Irvine Library procedures and functions
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib
; End Irvine

.DATA
; DATA del procedimiento "main"
arrInd DWORD 7, 2, 8, 11
       DWORD 14, 3, 10, 6, 0
       DWORD 16, 9, 1, 4, 5
totInd SDWORD ?
arrPot DWORD 1000, 2000, 3000, 4000
       DWORD 5000, 0, 12000, 11000
       DWORD 10000, 9000, 8000, 7000
totPot SDWORD ?
msgInd BYTE "Total de indices: ",0
msgPot BYTE "Total de potencias: ",0
msgBye BYTE "HASTA LUEGO :). ",0

; DATA del procedimiento "ID"
textoID BYTE "Soy 160502MonicaA", 0

; DATA del procedimiento CtaElemArrD
dirRet DWORD ?
arr DWORD ?


; DATA del procedimiento ImprimirArrD
dirRet2 DWORD ?
arrI DWORD ?
arrP DWORD ?
tamI DWORD ?
tamP DWORD ?
msgVivo BYTE "SIGO VIVO",0
msgPos BYTE "Posicion ",0
msgVal BYTE " con valor: ",0


.CODE
main PROC

    call ID

    call Crlf
    
    ;para saber cuando detenerse
    mov totInd, -1
    ;para llamar CtaElemArrD con arreglo de indices
    push OFFSET arrInd
    call CtaElemArrD
    pop totInd
    mov edx, OFFSET msgInd
    call WriteString
    mov eax, totInd
    call WriteInt
    call Crlf

    ;para saber cuando detenerse
    mov totPot, -1
    ;para llamar CtaElemArrD con arreglo de potencias
    push OFFSET arrPot
    call CtaElemArrD
    pop totPot
    mov edx, OFFSET msgPot
    call WriteString
    mov eax, totPot
    call WriteInt
    call Crlf

    call Crlf
    ;para llamar a imprimir
    push totPot
    push totInd
    push OFFSET arrPot
    push OFFSET arrInd
    call ImprimirArrD

    call Crlf
    mov edx, OFFSET msgBye
    call WriteString
    call crlf
    
    EXIT
main ENDP

; Procedimiento para imprimir mi ID
; No hay argumentos. El string es local.
; No hay resultado a regresar.
ID PROC
    call CrLF
    mov EDX, oFFSET textoID
    call WriteString
    call CrLF
    RET
ID ENDP

;Procedimiento que cuenta elementos de un arreglo DWORD
;Argumentos: direccion del arreglo
;Regresa cantidad de elementos del arreglo
CtaElemArrD PROC
    pop dirRet
    pop arr
    mov edi, arr
    mov ecx, 0 ;contador de elementos
    mov esi, 0; para el while

    .WHILE SDWORD PTR [edi +esi*4] >= 0
        inc ecx
        inc esi
    .ENDW
    
    push ecx
    push dirRet
    RET
CtaElemArrD ENDP

;Procedimiento que imprime un arreglo DWORD
;Argumentos: direccion del arreglo de indices, dir arreglo potencias, tamaño del arreglo de indices, tam arreglo pot
;No hay resultados a regresar
ImprimirArrD PROC
    pop dirRet2
    pop arrI
    pop arrP
    pop tamI
    pop tamP
    mov edi, arrI
    mov esi, arrP
    mov ecx, 0 ;contador de while
    
    .WHILE ecx < tamI
        mov eax, DWORD PTR [edi + ecx*4]
        

        .IF DWORD PTR eax < tamP  ;existe el indice, vamos a imprimir
            mov edx, OFFSET msgPos
            call WriteString
            call WriteInt
            
            mov edx, OFFSET msgVal
            call WriteString
            mov eax, DWORD PTR [esi +eax*4]
            call WriteInt
            call Crlf
            
        .ENDIF
        inc ecx

    .ENDW
    
    
    push dirRet2
    RET
ImprimirArrD ENDP

END main