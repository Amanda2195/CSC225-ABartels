.386P
.model flat
extern _ExitProcess@4: near
extern _GetStdHandle@4: near
extern _WriteConsoleA@20: near
extern _ReadConsoleA@20: near
.data

msg		byte	"Hello World!", 10

handle		dword       ?
written		dword		?

.code
main PROC near
_main:
	
	push	offset msg
	call	PrintLine
	
	
	push 0
	call	_ExitProcess@4

main ENDP


; Write an assembly program that calls a function called PrintLine which in turn
; calls WriteConsole. PrintLine will take one argument: the address of a string in
; memory and prints it to the console/stdout. It should return the number of bytes
; written.

PrintLine PROC near

_PrintLine: 

	; PrintLine(string s, 10)

	push		ebp							; caller's ebp base pointer so we need to call it and save it before we return it by pushing it onto stack 
	mov	ebp,	esp							; we have to set up our own stack pointer, now that ebp is free to use
	mov ecx,	[ebp+8]						; takes you to top of stack where your first argument is
											; putting offset msg into ecx
	mov ebx, ecx							; need to store ecx address into ebx bc were using it in the loop
											;ecx points to start of message, substitute ebx so we can change ecx
_loop:
	mov	 al, [ecx]							; load contents of ecx into al, h from hello world comes through first time
	add  ecx, 1								; incrememnt ecx to point to next character
	cmp  al, 10								; compare what we loaded to new line character
	jne  _loop								; if equal, bit gets set in register, if not equal we go back and loop again
	sub  ecx, ebx							;ecx is incrementing addresses until we find a new line character, at which point ecx-ebx (end-beginning 
											;address = length of string)

	push -11								; passes argument to function, -11 is argument. functions sees -11 and knows you want stdout
	call _GetStdHandle@4					;	make call to get handle on stdout
	mov handle, eax							; write handle to a location in memory where it is saved. return value always comes to eax bc youll need it

	; WriteConsole(handle, &msg[0], 13, &written, 0)
	push	0							; reserved argument, always needed
	push	offset written				; stores number of bytes it wrote, pass a memory address to this
	push	ecx							; the number of bytes youre asking it to write
	push	ebx							; address of where the message is
	push	handle						; handle of the output from GetStdHandle
	call	_WriteConsoleA@20			; call function

	pop    ebp							; restores callers ebp at this point
	ret		4							; callee neeeds to destroy stack so it takes argument off stack
	PrintLine ENDP
	END

;line 1 and 2 of paragraph 1, line 1 of paragraph 2
; pass address of string
; 0 at end of byte string in memory
; put a new line at the end
; 10 for newline, read all characters until you see newline
; in project specify what number characters