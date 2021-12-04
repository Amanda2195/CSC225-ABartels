.386P
.model flat

extern _ExitProcess@4: near
extern _GetStdHandle@4: near
extern _WriteConsoleA@20: near
extern _ReadConsoleA@20: near

.DATA
.CODE

writeLine PROC near

	push	ebp
	mov		ebp,	esp
	mov		edx,	[ebp+8]
	mov		ebx,	edx

_Loop:
	mov		al,	[edx]
	add		edx,	1
	cmp		al,		10
	jne		_loop
	sub		edx,	ebx			;edx has count
	sub		edx,	1
	; push	eax
	; cmp		writeBuffer,	0
	; jmp		_Loop
	; handle = GetStdHandle(-11)

	push -11
	call _GetStdHandle@4
	mov		handle, eax

	; WriteConsole(handle, &msg[0], 13, &written, 0)
	push	0							; reserved argument, always needed
	push	offset written				; stores number of bytes it wrote, pass a memory address to this
	push	edx							; the number of bytes youre asking it to write
	push	ebx							; address of where the message is
	push	handle						; handle of the output from GetStdHandle
	call	_WriteConsoleA@20			; call function
	pop		ebp
	ret		4

writeLine ENDP
END