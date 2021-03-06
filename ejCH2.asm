TITLE *MASM Template	(ejCH2.asm)*

; Descripcion:
; Tercer ejercicio del ensamblador
; 

INCLUDE \masm32\Irvine\Irvine32.inc

INCLUDELIB \masm32\Irvine\Irvine32.lib
includelib \masm32\Irvine\User32.lib
includelib \masm32\Irvine\Kernel32.lib

.DATA
factor   SDWORD ?
arreglo  REAL8 10 DUP (?)

;Para LeerLista
dirRetL  DWORD ?
n        DWORD ?
aux     REAL8 ?

;Para FacLista
dirRetF  DWORD ?
num     DWORD ?
fac     DWORD ?
alpha   REAL8 ?

;Para MenorLista
dirRetM  DWORD ?
tam     DWORD ?
min     REAL8 ?
minInd  DWORD ?


;Para Imprime
dirRetI DWORD ?
m       DWORD ?
saca    Real8 ?

msgFactor   BYTE    "Ingrese factor: ",0
msgErrorF   BYTE    "Factor Debe de ser un entero entre 0 y 9",0
msgN        BYTE    "Ingrese n numero de elementos de la lista: ",0 
msgErrorN   BYTE    "N Debe de ser un entero entre 1 y 10",0
msgLeeList  BYTE    "Ingrese el ",0
msgLista    BYTE    " elemento de la lista: ",0
msgElem     BYTE    "Elemento ",0
msgDP       BYTE	  ": ",0
msgMinVal   BYTE    "Valor minimo: ",0
msgMinInd   BYTE    "Indice del minimo: ",0

.CODE
main PROC

    mov EDX, OFFSET msgFactor
    call WriteString
    call ReadInt
    mov factor, EAX
    .IF factor>9 || factor<0
        mov EDX, OFFSET msgErrorF
        call WriteString
        call Crlf
    .ELSE
        mov EDX, OFFSET msgN
        call WriteString
        call ReadInt
        call Crlf
        mov N, EAX
        .IF N<1 || N>10
            mov EDX, OFFSET msgErrorN
            call WriteString
            call Crlf
        .ELSE

            push N
            push OFFSET arreglo
            call LeerLista

            call Crlf


            push OFFSET arreglo
            push factor
            push N
            call FacLista

            push OFFSET arreglo
            push N
            call MenorLista
            ;fstp min
            pop minInd
            call Crlf
            mov edx, OFFSET msgMinVal
            call WriteString
            call WriteFloat
            fstp min
            call Crlf
            mov edx, OFFSET msgMinInd
            call WriteString
            mov eax, minInd
            call WriteInt
            call Crlf

            
            push OFFSET arreglo
            push N
            call Imprime

            call ShowFPUStack
        .ENDIF



    .ENDIF

    exit
main ENDP

    LeerLista PROC
        pop dirRetL
        pop esi
        pop n

        mov ECX, 1
        .WHILE ECX <= n
            mov EDX, OFFSET msgLeeList
            call WriteString
            mov EAX,ECX
            call WriteInt
            mov EDX, OFFSET msgLista
            call WriteString
            call ReadFloat
            dec ecx

            fstp REAL8 PTR [esi + (ecx*8)]
            inc ecx

            inc ecx
        .ENDW
        push dirRetL
        RET
    LeerLista ENDP

    FacLista PROC
        pop dirRetF
        pop num
        pop fac  ;fac
        pop esi  ;offset arr

        mov eax, fac
        call WriteInt
        call Crlf
        mov ecx,0
        .WHILE ecx < num
            fld REAL8 PTR [esi + (ecx*8)]
            fimul fac
            ;call  ShowFPUStack
            fstp REAL8 PTR [esi + (ecx*8)] 
            inc ecx
        .ENDW

        push dirRetF
        RET
    FacLista ENDP

    MenorLista PROC
        pop dirRetM
        pop num
        pop esi  ;offset arr
        mov ecx,0
        mov edi, 0 ;min index
        .WHILE ecx < num
            pushfd
            fld REAL8 PTR [esi + (ecx*8)]
            fcomp REAL8 PTR [esi + (edi*8)]
            fnstsw ax ; move status word into AX
            sahf ; copy AH into EFLAGS
            jnb L1
            mov edi, ecx 
        L1:
            popfd
            inc ecx
        .ENDW
        ; mov eax, edi
        ; call WriteInt
        push edi; indice del val min
        fld REAL8 PTR [esi + (edi*8)] ; val min

        push dirRetM
        RET
    MenorLista ENDP

    Imprime PROC
        pop dirRetI
        pop m
        pop esi

        mov ecx, 0
        .WHILE ecx < m
            mov EDX, OFFSET msgElem
            call WriteString
            mov eax, ecx
            inc eax
            call WriteInt
            mov edx, OFFSET msgDP
            call WriteString
            FLD REAL8 PTR [esi + ecx*8]
            call WriteFloat
            fstp saca
            call Crlf
            inc ecx
        .ENDW
        push dirRetI
        RET
    Imprime ENDP

END main