#!/bin/bash

# Umgebungsvariablen für GitHub-Authentifizierung
GH_TOKEN=${GH_TOKEN:-""}

# Überprüfen, ob das Token gesetzt ist
if [ -z "$GH_TOKEN" ]; then
    echo "Bitte setzen Sie die GH_TOKEN-Umgebungsvariable."
    exit 1
fi

# Mit gh auth login authentifizieren
echo "$GH_TOKEN" | gh auth login --with-token

# Weitere Befehle hier...
# GH_TOKEN=IhrToken ./gh_auth.sh.