.386P
.model flat

extern _ExitProcess@4: near
extern _GetStdHandle@4: near
extern _WriteConsoleA@20: near
extern _ReadConsoleA@20: near

extern _PrintLine
extern _WriteLine
extern _atoi
extern _itoa

.data

input1	dword	0
input2	dword	0

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

	mov		eax, offset input1
	push	offset readBuffer1
	push	offset input1
	call	atoi

	mov		eax, offset input2
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
