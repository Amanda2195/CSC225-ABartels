.386P
.model flat
extern _ExitProcess@4: near
extern _GetStdHandle@4: near
extern _WriteConsoleA@20: near
extern _ReadConsoleA@20: near

.data

num1		dword		10
num2		dword		20
num3		dword		30
num4		dword		40

.code

main PROC near
_main:

	mov		eax,		num1
	mov		edx,		num2
	mov		ebx,		num3
	mov		ecx,		num4

	xchg	eax,		ecx
	mov		num1,		eax	
	mov		num4,		ecx
	
	xchg	edx,		ebx
	mov		num2,		edx
	mov		num3,		ebx		
	;move back to memory

	push		0
	call		_ExitProcess@4

main ENDP
END