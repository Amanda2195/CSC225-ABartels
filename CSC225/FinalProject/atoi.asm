.386P
.model flat

extern _ExitProcess@4: near
extern _GetStdHandle@4: near
extern _WriteConsoleA@20: near
extern _ReadConsoleA@20: near

.DATA

.CODE

atoi PROC near
_atoi:

	push	ebp
	mov		ebp,	esp
	mov		ebx,	[ebp+12]
	mov		ecx,	ebx


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
	mov		accumulator, 0

_convertLoop:
	mov		bl, [edi]															;exception thrown at 0x007710D5		;change to ebx
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
	mov		edx, [ebp+8]
	mov		[edx], eax
	pop		ebp
	ret		8
	
atoi ENDP

END