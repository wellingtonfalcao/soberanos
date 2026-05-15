ORG 0x7C00					; Diretiva de compilação informando que inicia no endereço de 0x7c00 de RAM
BITS 16						; Trabalhando no modo real em 16 bits

start:						; Label - Convertido pelo montador por uma posição de memória (0x7c00)
	
	xor ax, ax				; Zerar registradores de segmento
	mov ds, ax
	mov es, ax
	mov ss, ax
						; Carregar o kernel na memória
	mov ah, 0x0e				; Rotina de impressão de caractere na tela, posição atual cursos
	mov al, 'O'				; Caractere a ser impresso
	int 0x10 				; Interrupção da BIOS de video
	mov al, 'K'				
	int 0x10
	mov al, '!'
	int 0x10
	mov al, 13				; Move cursor para baixo (código decimal)
	int 0x10
	mov al, 10				; Retorna o cursor
	int 0x10
	jmp $					; jump para ele mesmo, looping infinito, para nao ler a sequencia de zeros
times 	510 - ($ - $$) db 0			; Diretiva de compilação times que repete 510 - quantidade de bytes usados
	dw 0xAA55				; Magic number de um código bootável com os 2 bytes restantes para completar 512B

	
	; executar o comando: nasm -f bin bootloader.asm -o boot.bin
	; Isso força o nasm a montar um binário flat sem informações adicionais do sistema operacional. 

	; depois, o comando: qemu-system-i386 -drive format=raw,file=boot.bin
	; Usará o emulador em sistema i386 para testar o boot.bin	
