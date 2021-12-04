.386P
.model flat

extern _ExitProcess@4: near
extern _GetStdHandle@4: near
extern _WriteConsoleA@20: near
extern _ReadConsoleA@20: near

.DATA
.CODE

itoa PROC near								; takes value from multiplication
	
	push	ebp
	mov		ebp,	esp
	;takes 2 arguments, 1 where you want result to be put, 1 
	mov		ebx,	[ebp+8]					;result in ascii
	mov		eax,	[ebp+12]				;integer value that you will convert is stored here
	add		ebx,	1024

	mov		edi, 10
	sub		ebx, 1
	mov		[ebx], edi
	mov		edi,	10


_divisionLoop:
	
	sub		ebx,	1
	mov		edx,	0
	div		edi				; remainder goes into edx, quotient goes into eax
	add		dl,		30h		; takes last digit
	mov		[ebx],	dl
	cmp		eax,	0
	jg		_divisionLoop	

	pop		ebp
	ret		8

itoa ENDP
END