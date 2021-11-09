.386P

.model flat

extern _GetStdHandle@4: near
extern _WriteConsole@20: near
extern _ExitProcess@4: near

.data											; all memory 

;make an array

alphabet		byte	61h						;61h is hex code for a
outputHandle	dword	?						; initializes to nothing
written			dword	?

.code													; code to increment pointer

main PROC near
_main:

	; this code 

	; handle = GetStdHandle(-11)
	push	-11										;pass an argument onto the stack. push -11 bc -11 stands for standard output
	call	_GetStdHandle@4							; call to standard handle
	mov		outputHandle, eax						; write eax to output handle in memory
													

	mov		edx, offset written						; save offset written's address in edx
	mov		ebx, offset alphabet					; need it below so we save it in ebx					

	mov		esi, 0

;_loop:																		;count up loop
;
;	cmp		esi, 4
;	jz		_exit
;	mov		eax, ebx
;	add		eax, esi														; esi is index
;	add		esi, 1
;
;	; WriteConsole(handle, &msg[0], numCharsToWrite, &written, 0)			;executed in reverse order
;	push	0
	push	offset written													; & means pointer * means whatever this pointer points to
																			; offset gets address of where thing is
																			; couldve pushed ebx bc it was already assigned
	push	1
	push	eax																
	push	outputHandle													
	call	_WriteConsole@20
	jmp		_loop

_loop: 
	
	; WriteConsole(handle, &msg[0], numCharsToWrite, &written, 0)
	push	0
	push	edx
	push	1
	push	ebx
	push	outputHandle
	call	_WriteConsole@20

_exit:

	push	0
	call	_ExitProcess@4

main ENDP
END