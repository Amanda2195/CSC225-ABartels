.386P
;FIBONACCI PROJECT 2, use LOOP loop

.model flat

extern _ExitProcess@4: near
extern _GetStdHandle@4: near
extern _WriteConsoleA@20: near
extern _ReadConsoleA@20: near

.data

prev		dword		1		;*
current		dword		1		;*
next		dword		0		;*

msg			byte		"Enter which number in the sequence you want to see: "

.code

main PROC near
_main:

;expect to find n in eax when you start the program, at end result should be in eax

mov		eax,	6					;prev = 0		;*
mov		ebx,	prev								;*
mov		edi,	current				; current = 1	;*
mov		edx,	next				; next = 0		;*
					
;mov		ebx							;for user input

mov	esi,	3									;*
cmp	eax,	2
je	_exit2
cmp	eax,	1
je	_exit2
cmp	eax, 0
je	_exit0

sub		eax,	3
mov		ecx,	eax

_loop:

add ebx, edi							; prev + curr
mov edx, ebx							; next = prev + curr			;*not eax
mov ebx, edi							; update prev with curr
mov edi, edx							; update curr with next
;inc	esi									;*
LOOP _loop
;Loop _loop

_exit:
mov eax, edx
	push 0
	call _ExitProcess@4
_exit0:
mov	edx,	0
jmp	_exit
_exit2:
mov	edx,	1
jmp	_exit

main ENDP
END