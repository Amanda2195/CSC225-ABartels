.386P
.model flat

extern _GetStdHandle@4: near
extern _WriteConsoleA@20: near
extern _ExitProcess@4: near

.data												; all memory 

; make an array

alphabet		byte	61h							; 61h is hex code for a
outputHandle	dword	?							; initializes to nothing
written			dword	?

.code												; code to increment pointer

main PROC near
_main:

	; handle = GetStdHandle(-11)
	push	-11										; pass an argument onto the stack. push -11 bc -11 stands for standard output
	call	_GetStdHandle@4							; call to standard handle
	mov		outputHandle, eax						; write eax to output handle in memory
													

	mov		edx, offset written						; save offset written's address in edx
	mov		ebx, offset alphabet					; need offset alphabet below so we save it in ebx					

	mov		esi, 26									; sets up index, alphabet has 26 letters, count down from esi 26 in loop
	
_loop: 
	; how to make a simple function call
	push esi
	push eax
	push edi
	push 1
	push ebx
	call writeLine
	pop edi
	pop eax
	pop esi

	
;	; WriteConsole(handle, &msg[0], numCharsToWrite, &written, 0)
;	push	0
;	push	edx										; push address of written (written is a buffer in edx)
;	push	1										; how many characters to write at a time
;	push	ebx										; this is the message buffer, the offset of alphabet which is saved in ebx)
;	push	outputHandle							; handle stored in outputHandle
;	call	_WriteConsoleA@20						; all needed arguments have been pushed to stack so call this
	
	add		alphabet, 1
	add		esi, -1									; decrement iterator. this add will set the 0 flag
	jnz		_loop									; has no condition associated with it, checking 0 flag in e flag's register

_exit:

	push	0
	call	_ExitProcess@4

main ENDP

writeLine PROC near
_writeLine:			

	pop		esi
	pop		edi				;where alphabet resides
	pop		eax

	; WriteConsole(handle, &msg[0], numCharsToWrite, &written, 0)
	push	0
	push	offset written										
	push	eax									; get value by popping off of stack								
	push	edi									
	push	outputHandle							
	call	_WriteConsoleA@20

	push	esi
	ret		;8									;return instruction, 8 bytes
	
writeLine ENDP

END