ORG 0x7C00						; Diretiva pro assembler informando que inicia no endereço de 0x7c00 de RAM
BITS 16							; Trabalhando no modo real em 16 bits

start:							; Label - Convertido pelo montador por uma posição de memória (0x7c00)
	
	xor ax, ax					; Zerar registradores de segmento
	mov ds, ax
	mov es, ax
	mov ss, ax
	
							; ----- Carregar o kernel na memória ------

	mov ah, 0x0e					; Rotina de impressão de caractere na tela, posição atual cursor
	mov si, mens					; Registrador de deslocamento SI com a posição ini de mem do conteudo de 'mens'
print:	mov al, [si]					; conteudo de memória em SI
	cmp al, 0					; Compara conteudo de al com 0
	jz end						; faz um jump condicional apenas se for 0
	int 0x10					; interrupção de serviço de video da BIOS	
	inc si						; incrementa SI
	jmp print					; jump incondicional que será feito enquanto não for 0

end:	jmp end						; jump para ele mesmo (rotulo end ou $), looping infinito

mens	db "Iniciando meu primeiro bootloader em Assembly!", 13, 10, 0

times 	510 - ($ - $$) db 0				; Diretiva de compilação times que repete 510 - quantidade de bytes usados
	dw 0xAA55					; Magic number de um código bootável com os 2 bytes restantes para completar 512B

	
	; nasm -f bin bootloader.asm -o boot.bin
	; Isso força o nasm a montar um binário flat sem informações adicionais do sistema operacional. 

	; qemu-system-i386 -drive format=raw,file=boot.bin
	; Usará o emulador em sistema i386 para testar o boot.bin	
