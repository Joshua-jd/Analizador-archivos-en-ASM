# Revisión técnica

Compilado con GNU Assembler y GNU ld en Linux x86-64.

## Pruebas realizadas

Se verificaron seis casos: archivo vacío, bytes imprimibles y no imprimibles, 256 valores posibles, bloque parcial, archivo inexistente y argumentos faltantes.

## Alcance

Esta primera versión no incluye búsqueda de secuencias, identificación de formatos ni menú interactivo. No es un desensamblador.

Se utilizó GNU Assembler en lugar de NASM porque NASM no estaba disponible en el entorno de pruebas.
