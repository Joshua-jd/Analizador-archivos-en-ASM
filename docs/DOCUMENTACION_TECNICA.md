# Documentación técnica — Analizador de archivos binarios

## Propósito y alcance

Visor de archivos en hexadecimal y ASCII sin biblioteca de C.

## Arquitectura y organización

src/main.s implementa entrada _start, buffers buf y line, conversión hex64 y salida write_all. R12 mantiene descriptor, R13 desplazamiento y R14 cantidad del bloque. Se usan syscalls open, read, write, close y exit.

## Flujo de ejecución

Abrir archivo → leer hasta 16 bytes → convertir offset y bytes → imprimir fila → repetir → mostrar total.

## Conceptos aplicados

ABI Linux, registros, máscaras, desplazamientos, buffers y manejo de lecturas parciales.

## Ejemplo para revisar el comportamiento

printf Hola > ejemplo.bin; ./analizador ejemplo.bin. Se esperan bytes 48 6F 6C 61 y total hexadecimal 4.

## Límites y verificación

Seis casos superados en Linux; WSL no probado específicamente. No incluye búsqueda ni identificación de formatos.

Para ejecutar el proyecto consulte el [manual](MANUAL.md) y el [README](../README.md).
