#!/bin/bash

cd ../..

# Verzeichnisname als Argument übergeben
DIR=".git"

# Dateiname als Argument übergeben
FILE="README.md"

# Überprüfen, ob der Verzeichnisname gegeben wurde
if [ -z "$DIR" ]; then
    echo "Bitte geben Sie den Verzeichnisnamen an."
    exit 1
fi

# Überprüfen, ob das Verzeichnis existiert
if [ -d "$DIR" ]; then
    # Verzeichnis löschen
    rm -r "$DIR"
    echo "Verzeichnis $DIR wurde gelöscht."
else
    echo "Verzeichnis $DIR existiert nicht."
fi


if [ -z "$FILE" ]; then
    echo "Bitte geben Sie den Dateinamen an."
    exit 1
fi

# Überprüfen, ob die Datei existiert
if [ -f "$FILE" ]; then
    # Datei löschen
    rm "$FILE"
    echo "Datei $FILE wurde gelöscht."
else
    echo "Datei $FILE existiert nicht."
fi