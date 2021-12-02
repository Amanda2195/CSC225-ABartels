.386P
.model flat

extern _GetStdHandle@4:near
extern _ExitProcess@4: near
extern _WriteConsoleA@20: near
extern _ReadConsoleA@20: near

.data

msg			byte	'Hello World!', 10
handle		dword	?
written		dword	?

.code

main PROC near
_main:

	; handle = GetStdHandle(-11)
	push -11
	call _GetStdHandle@4
	mov		handle, eax

	; WriteConsole(handle, &msg[0], 13, &written, 0)
	push	0							; reserved argument, always needed
	push	offset written				; stores number of bytes it wrote, pass a memory address to this
	push	13							; the number of bytes youre asking it to write
	push	offset msg					; address of where the message is
	push	handle						; handle of the output from GetStdHandle
	call	_WriteConsoleA@20			; call function

	push	0
	call	_ExitProcess@4

main ENDP
END

