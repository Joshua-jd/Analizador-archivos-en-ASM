# Pruebas y limitaciones — Analizador de archivos binarios

## Estado registrado

Seis casos superados en Linux; WSL no probado específicamente. No incluye búsqueda ni identificación de formatos.

Consulte también el [registro anterior](REVISION.md).

## Comprobación manual sugerida (no equivale a una prueba ejecutada)

1. Preparar el entorno indicado en el README.
2. Ejecutar el programa con datos de prueba.
3. printf Hola > ejemplo.bin; ./analizador ejemplo.bin. Se esperan bytes 48 6F 6C 61 y total hexadecimal 4.
4. Registrar el resultado y cualquier diferencia.

Esta edición mejora documentación y comentarios; no certifica funciones que no se hayan probado.
