# Código x86-64 para Linux, sintaxis Intel de GNU Assembler.
# .rodata: constantes; .bss: buffers y estado; .text: instrucciones.
# ABI de syscall: RAX identifica la llamada; RDI, RSI, RDX y demás registros
# transmiten argumentos. RCX y R11 pueden cambiar tras syscall.
.intel_syntax noprefix
.global _start
.section .rodata
usage: .ascii "Uso: analizador ARCHIVO\n"
.set usage_len, .-usage
err: .ascii "Error al abrir o leer el archivo.\n"
.set err_len, .-err
hex: .ascii "0123456789ABCDEF"
summary: .ascii "Bytes totales (hex): "
.set summary_len, .-summary
.section .bss
.lcomm buf,16
.lcomm line,88
.section .text
# ABI Linux x86-64: rax = syscall; rdi,rsi,rdx = argumentos.
# Lee argc y argv desde la pila inicial; abre el archivo en modo lectura.
_start:
    cmp qword ptr [rsp],2
    jne bad_usage
    mov rdi,[rsp+16]
    xor esi,esi
    xor edx,edx
    mov eax,2
    syscall
    test rax,rax
    js bad_file
    mov r12,rax                 # descriptor
    xor r13d,r13d               # offset acumulado
# Reinicia el contador de bytes del bloque, sin perder el desplazamiento total.
read_line:
    xor r14d,r14d
# Acumula lecturas parciales hasta llenar 16 bytes; reintenta si read devuelve EINTR.
fill:
    xor eax,eax
    mov rdi,r12
    lea rsi,[rip+buf]
    add rsi,r14
    mov edx,16
    sub rdx,r14
    syscall
    cmp rax,-4                  # EINTR
    je fill
    test rax,rax
    js bad_file
    jz eof
    add r14,rax
    cmp r14,16
    jb fill
    jmp format
 eof:
    test r14,r14
    jz finish
# Construye una fila en line; RDI apunta a la siguiente posición de salida.
format:
    lea rdi,[rip+line]
    mov rax,r13
    call hex64
    mov byte ptr [rdi],' '
    inc rdi
    lea rbx,[rip+buf]
    lea r10,[rip+hex]
    xor ecx,ecx
# Divide cada byte en dos nibbles y los traduce con la tabla hex.
hex_loop:
    cmp rcx,r14
    jae pad
    movzx eax,byte ptr [rbx+rcx]
    mov edx,eax
    shr eax,4
    and edx,15
    mov al,[r10+rax]
    mov dl,[r10+rdx]
    mov [rdi],al
    mov [rdi+1],dl
    jmp advance
# Rellena columnas faltantes para conservar la alineación del bloque ASCII.
pad:
    mov word ptr [rdi],0x2020
advance:
    mov byte ptr [rdi+2],' '
    add rdi,3
    inc rcx
    cmp ecx,16
    jb hex_loop
    mov byte ptr [rdi],'|'
    inc rdi
    xor ecx,ecx
# Representa únicamente ASCII imprimible (32–126); sustituye el resto por puntos.
ascii_loop:
    mov al,[rbx+rcx]
    cmp al,32
    jb dot
    cmp al,126
    jbe store
 dot: mov al,'.'
 store: stosb
    inc rcx
    cmp rcx,r14
    jb ascii_loop
    mov al,'|'
    stosb
    mov al,10
    stosb
    lea rsi,[rip+line]
    mov rdx,rdi
    sub rdx,rsi
    call output
    add r13,r14
    cmp r14,16
    je read_line
# Cierra el descriptor y muestra el total acumulado en hexadecimal.
finish:
    mov eax,3
    mov rdi,r12
    syscall
    lea rsi,[rip+summary]
    mov edx,summary_len
    call output
    lea rdi,[rip+line]
    mov rax,r13
    call hex64
    mov byte ptr [rdi],10
    lea rsi,[rip+line]
    mov edx,17
    call output
    xor edi,edi
    jmp exit
# Convierte RAX en 16 caracteres hexadecimales; avanza RDI.
hex64:
    lea r10,[rip+hex]
    mov ecx,16
hloop:
    rol rax,4
    mov rdx,rax
    and edx,15
    mov dl,[r10+rdx]
    mov [rdi],dl
    inc rdi
    loop hloop
    ret
output:
    mov edi,1
    jmp write_all
# Informa por stderr que falta o sobra un argumento y termina con código 2.
bad_usage:
    lea rsi,[rip+usage]
    mov edx,usage_len
    mov edi,2
    call write_all
    mov edi,2
    jmp exit
# Informa un error de archivo por stderr y termina con código 1.
bad_file:
    lea rsi,[rip+err]
    mov edx,err_len
    mov edi,2
    call write_all
    mov edi,1
    jmp exit
# Escribe RSI/RDX en el descriptor RDI; gestiona escrituras parciales y EINTR.
write_all:
    mov eax,1
    syscall
    cmp rax,-4
    je write_all
    test rax,rax
    jle write_fail
    add rsi,rax
    sub rdx,rax
    jnz write_all
    ret
write_fail:
    mov edi,1
exit:
    mov eax,60
    syscall
.section .note.GNU-stack,"",@progbits
