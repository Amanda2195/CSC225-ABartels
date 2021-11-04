.386P
.model flat

.data

.code

main PROC near
_main :

mov		ecx, 10
mov		eax, 0

_loop :

	cmp		ecx, 0						; initializing loop counter
	jz		_exit
	add eax, ecx
	add ecx, -1							; decrement counter
	;	jz       _loop					; unconditional jump							
	jmp      _loop

	; eax should have sum at end

	_exit;
		push	0
		call	_ExitProcess@4

extern _GetStdHandler@4: near
extern _WriteConsole@4: near
Extern _ExitProcess@4: near

;make an array

alphabet		byte	'a', 'b', 'c', 'd'
outputHandle	dword	?						; initializes to nothing
written			dword	?

.code

	
main ENDP
END
