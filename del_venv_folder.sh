#!/bin/bash
# Beispielaufruf
# bash ./_scripts/del_venv_folder.sh './_scripts/_config_0.1.3.ini'

# Das erste Argument wird in die Variable $1 gespeichert
ini_file=$1
del_venv_folder=$2
echo "INFO: Argument 1: $ini_file"

echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"
echo "CMD ausführen - START: $del_venv_folder"
echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"

# Überprüfe, ob die Variable leer ist
if [ -z "$ini_file" ]; then
    echo "Fehler: Es wurde kein Config INI übergeben."
    exit 1
fi

echo "Info: Es wird folgende INI Datei verwendet: $ini_file"

# Variablen auslesen
basis_folder=$(crudini --get "$ini_file" basis_setup_info basis_folder)
basis_version=$(crudini --get "$ini_file" basis_setup_info basis_version)
basis_django_project_name=$(crudini --get "$ini_file" basis_setup_info basis_django_project_name)

basis_venv_folder=$basis_folder/$basis_django_project_name/$basis_version/env
# basis_folder=$basis_folder/$basis_django_project_name/$basis_version

if [ -d "$basis_venv_folder" ]; then
    echo "INFO: Das Verzeichnis existiert: $basis_venv_folder"
    echo "INFO: Der Lösch-Prozess wird gestartet:"
    echo "INFO: rm -rf $basis_venv_folder"
    rm -rf $basis_venv_folder
else
    echo "Warning: Das Verzeichnis existiert nicht: $basis_venv_folder"
    echo "Warning: Der Lösch-Prozess wird gestopt!"
fi

echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"
echo "CMD ausführen - ENDE: $del_venv_folder"
echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"