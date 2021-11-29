.386P

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

mov		eax,	5					;prev = 0		;*
mov		ebx,	prev								;*
mov		ecx,	current				; current = 1	;*
mov		edx,	next				; next = 0		;*
					
;mov		ebx							;for user input

mov		ecx,	1									;*

_loop:

cmp	ecx, eax							;*
jge	exit								;*
add ebx, ecx							; prev + curr
mov edx, ebx							; next = prev + curr			;*not eax
mov ebx, ecx							; update prev with curr
mov esi, edx							; update curr with next
inc	ecx									;*
jmp _loop
;Loop _loop

	push 0
	call _ExitProcess@4

main ENDP
END