.386P
.model flat
extern _ExitProcess@4: near
extern _GetStdHandle@4: near
extern _WriteConsoleA@20: near
extern _ReadConsoleA@20: near
;extern _PrintLine
;extern _WriteLine
;extern _atoi
;extern _itoa

.data

input1	dword	?
input2	dword	?

prompt	byte	'Enter number 1: ', 10
prompt2	byte	'Enter number 2: ', 10
result	byte	'The multiplication result is: ', 10
writeBuffer	byte	1024	DUP(00H)

readBuffer1	byte		1024	DUP(00H)
readBuffer2	byte		1024	DUP(00H)

handle		dword       ?
read		dword		?
written		dword		?

readHandle	dword		?	

accumulator  dword      0

.code

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

atoi PROC near
_atoi:

	push	ebp
	mov		ebp,	esp
	mov		ebx,	[ebp+16]

	;mov	ebx,	offset readBuffer1			; moving address of offset readBuffer into ebx

_endOfStringLoop:

	mov		al,	[ebx]					; find contents of ebx
	add		ebx, 1
	cmp		al,	0dh						; compare to see if al contains 0
	jne		_endOfStringLoop			; jump if not equal to 0, end of loop
	sub		ebx,	2					;subtract 1 from ebx/decrement as you go

	mov		edi, ebx
	mov		esi, 1
	mov		eax, 0
	mov		ebx, 0
	mov		edx, 0
	mov     ecx, offset readBuffer1

_convertLoop:
	mov		bl, [edi]
	sub		bl,	30h	
	mov		eax, ebx
	mul		esi
	mov     edx, accumulator
	add		edx, eax
	mov     accumulator, edx
	mov		eax, 10
	mul		esi 				;destination is eax
	mov		esi, eax
	dec     edi
	cmp     edi, ecx
	jge     _convertLoop

	mov		eax, accumulator
	mov		[ebp+8],	eax
	pop		ebp
	ret		8
	
atoi ENDP

itoa PROC near								; takes value from multiplication
	
	push	ebp
	mov		ebp,	esp
	;takes 2 arguments, 1 where you want result to be put, 1 
	mov		ebx,	[ebp+8]					;result in ascii
	mov		eax,	[ebp+12]				;integer value that you will convert is stored here
	add		ebx,	1024

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

main PROC near
_main:

	push	offset prompt
	call	writeLine

	push	offset readBuffer1
	call	readLine
	;push	offset msg

	push	offset prompt2
	call	writeLine

	push	offset	readBuffer2
	call	readLine
	push	offset readBuffer1
	push	offset input1
	call	atoi

	push	offset readBuffer2
	push	offset input2
	call	atoi

	mov		eax,	input1
	mul		input2

	push	eax
	mov		eax, offset writeBuffer
	push	offset writeBuffer
	call	itoa

	push	offset result
	call	writeLine
	
	push	offset writeBuffer
	call	writeLine
	push	0
	call	_ExitProcess@4

main ENDP
END
