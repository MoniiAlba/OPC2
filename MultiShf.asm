TITLE Multiple Doubleword Shift            (MultiShift.asm)

; Demonstration of multi-doubleword shift, using
; SHR and RCR instructions.

INCLUDE myIrvine.inc

ArraySize = 3

.DATA
array DWORD 12345678h, 9ABCDEF1h, 23456789h
before BYTE "23456789-9ABCDEF1-12345678h",0 
after BYTE "After",0 

.CODE
main PROC
    ; Display the array
    mov EDX, OFFSET before
    call WriteString
    call CrLf
    mov EAX, array+2*TYPE DWORD
    call WriteBin
    mov AL, '-'
    call WriteChar
    mov EAX, array+TYPE DWORD
    call WriteBin
    mov AL, '-'
    call WriteChar
    mov EAX, array
    call WriteBin
    call CrLf

    ; Shift the doublewords 1 bit to the right:
    mov ESI, 0
    shr array[ESI+2*TYPE DWORD], 1              ; highest dword
    rcr array[ESI+TYPE DWORD], 1              ; middle dword, include Carry flag
    rcr array[ESI],1     	                                  ; low dword, include Carry flag

    ; Display the array
    mov EDX, OFFSET after
    call WriteString
    call CrLf
    mov EAX, array+2*TYPE DWORD
    call WriteBin
    mov AL, '-'
    call WriteChar
    mov EAX, array+TYPE DWORD
    call WriteBin
    mov AL, '-'
    call WriteChar
    mov EAX, array
    call WriteBin
    call CrLf

    EXIT
main ENDP

END main