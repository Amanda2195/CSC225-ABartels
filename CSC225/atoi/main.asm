.386P
.model flat
extern _ExitProcess@4: near
extern _GetStdHandle@4: near
extern _WriteConsoleA@20: near
extern _ReadConsoleA@20: near


.data

; convert string to integer
	mov						; pass memory location 



.code
main PROC near
_main:

	push		0
	call		_ExitProcess@4




main ENDP
END
