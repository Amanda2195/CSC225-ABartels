.386P
.model flat

extern _ExitProcess@4: near
extern _GetStdHandle@4: near
extern _WriteConsoleA@20: near
extern _ReadConsoleA@20: near

.DATA
.CODE

readLine PROC near

	push	ebp
	mov		ebp,	esp
	mov		edx,	[ebp+8]

	push   -10							; passes argument to function, -11 is argument. functions sees -11 and knows you want stdout
	call   _GetStdHandle@4				; make call to get handle on stdout
	mov	   readHandle, eax				; write handle to a location in memory where it is saved. return value always comes to eax bc youll need it *changed from read
	
	
	;mov    eax, offset readBuffer1		;???

	; ReadConsole(handle, &msg[0], 13, &written, 0)
	push	0							; reserved argument, always needed
	push	offset read					; reads the number of bytes it wrote, pass a memory address to this
	push	1024							; the number of bytes youre asking it to read
	push	edx			; address of where the message is
	push	readHandle					; handle of the output from GetStdHandle *changed from read. readHandle is the memory location written to
	call	_ReadConsoleA@20			; call function
	pop		ebp
	ret		4

readLine ENDP
END