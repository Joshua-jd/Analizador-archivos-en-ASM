# Analizador de archivos binarios

> Ensamblador x86-64 · GNU Assembler · Linux

**Propósito:** Visor de archivos en hexadecimal y ASCII sin biblioteca de C.

## Funcionamiento general

Abrir archivo → leer hasta 16 bytes → convertir offset y bytes → imprimir fila → repetir → mostrar total.

## Conocimientos aplicados

ABI Linux, registros, máscaras, desplazamientos, buffers y manejo de lecturas parciales.

## Ejemplo de uso

printf Hola > ejemplo.bin; ./analizador ejemplo.bin. Se esperan bytes 48 6F 6C 61 y total hexadecimal 4.

## Descripción y alcance del proyecto

Este es un proyecto personal nuevo de programación en ensamblador. La idea es poder abrir un archivo y ver los datos que contiene de forma hexadecimal y en ASCII, sin importar si es un archivo de texto o binario.

## Qué se trabaja en este proyecto

Lectura por bloques, registros, direccionamiento, conversiones hexadecimales, llamadas al sistema Linux y control de errores.

## Requisitos

- Linux x86-64 o WSL 2 x86-64.
- GNU Binutils (`as`, `ld`) y `make`.
- Python 3 para las pruebas.

El código utiliza GNU Assembler con sintaxis Intel y llamadas al sistema de Linux; no necesita bibliotecas de C.

## Cómo utilizarlo

```bash
make
./analizador ejemplo.bin
```

Para ejecutar las pruebas:

```bash
make test
```

El [manual de uso](docs/MANUAL.md) explica el funcionamiento y la [revisión](docs/REVISION.md) detalla las pruebas y limitaciones.

## Sobre el proyecto

Desarrollo personal nuevo para ampliar el portafolio, preparado con asistencia de IA. No corresponde a una entrega universitaria anterior. Se recomienda revisar y comprender el código antes de presentarlo como experiencia propia.

## Documentación complementaria

- [Manual de usuario](docs/MANUAL.md)
- [Documentación técnica](docs/DOCUMENTACION_TECNICA.md)
- [Pruebas y limitaciones](docs/PRUEBAS.md)

**Estado de verificación:** Seis casos superados en Linux; WSL no probado específicamente. No incluye búsqueda ni identificación de formatos.
