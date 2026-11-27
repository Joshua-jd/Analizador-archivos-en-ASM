# Manual de usuario — Analizador de archivos binarios

## Instalación

En Ubuntu o Debian, incluyendo WSL 2, instalar las herramientas si no están disponibles:

```bash
sudo apt update
sudo apt install binutils make python3
```

Abrir una terminal dentro de la carpeta del proyecto y ejecutar `make`.

## Uso

```bash
./analizador ejemplo.bin
```

Cada fila muestra la posición (offset) hexadecimal, hasta 16 bytes en hexadecimal y su representación ASCII. Los bytes no imprimibles se representan con un punto. Al final se muestra el total de bytes en hexadecimal. El archivo de entrada nunca se modifica.

Para generar un archivo de ejemplo, ejecutar `printf "Hola\n" > ejemplo.bin` antes de iniciar el analizador.

## Limitaciones

Esta primera versión no incluye búsqueda de secuencias, identificación de formatos ni menú interactivo. No es un desensamblador.

## Limpieza

Ejecutar `make clean` para eliminar los archivos compilados.

## Ejemplo de comprobación

printf Hola > ejemplo.bin; ./analizador ejemplo.bin. Se esperan bytes 48 6F 6C 61 y total hexadecimal 4.

Para requisitos y comandos de ejecución consulte el [README](../README.md). Para conocer los límites de las pruebas consulte [Pruebas](PRUEBAS.md).
