.386P
.model flat
extern _ExitProcess@4: near
extern _GetStdHandle@4: near
extern _WriteConsoleA@20: near
extern _ReadConsoleA@20: near

.data

.code
main PROC near
_main:

;ITOA
_itoa:
								; accept string and convert to integer
								; takes first digit
; stores in al to be able to perform subtraction
; subtracts 48
; check if value is 0-9 ?
; multiply  
	push	rbx
	mov		al,		rbx
	sub		al,		48
	mov		result 

	mov rbx, 10			 ;puts a zero before everything so that in the next loop it will know when to stop
	dec rdi
	mov byte [rdi], 0
	inc rdi
	
itoa ENDP

	push		0
	call		_ExitProcess@4




main ENDP
END
