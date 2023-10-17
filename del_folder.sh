#!/bin/bash
# Beispielaufruf
# bash ./_scripts/del_venv_folder.sh './_scripts/_config_0.1.3.ini'

# Das erste Argument wird in die Variable $1 gespeichert
ini_file=$1
section_del_folder=$2

echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"
echo "CMD ausführen - START: $section_del_folder"
echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"

echo "INFO: Argument 1: $ini_file"
echo "INFO: Argument 2: $section_del_folder"

# Überprüfe, ob die Variable leer ist
if [ -z "$ini_file" ]; then
    echo "Fehler: Es wurde kein Config INI übergeben."
    exit 1
fi

if [ -z "$section_del_folder" ]; then
    echo "Fehler: Es wurde kein INI-Schlüssel übergeben."
    exit 1
fi

echo "Info: Es wird folgende INI Datei verwendet: $ini_file"

# Variablen auslesen
basis_folder=$(crudini --get "$ini_file" basis_setup_info basis_folder)
basis_version=$(crudini --get "$ini_file" basis_setup_info basis_version)
basis_django_project_name=$(crudini --get "$ini_file" basis_setup_info basis_django_project_name)

basis_folder=$basis_folder/$basis_django_project_name/$basis_version/$basis_django_project_name

# Schritt 1 - Alle Files zu löschenden Files auslesen
echo "INFO: Auslesen der Werte aus dem Schlüssel $section_del_folder"
cmds=$(crudini --get $ini_file $section_del_folder | awk -F'=' '{ print $1 }')

for cmd in $cmds; do
    if [[ "$cmd" == cmd_del_folder* ]]; then 
        cmd_value=$(crudini --get $ini_file $section_del_folder $cmd)
        echo "INFO: $cmd hat den Wert $cmd_value"

        basis_folder_delet_folder=$basis_folder/$cmd_value

        if [ -d $basis_folder_delet_folder ]; then
            echo "INFO: Verzeichnis zum löschen: $basis_folder_delet_folder"
            echo "INFO: rm -rf $basis_folder_delet_folder"
            rm -rf $basis_folder_delet_folder

        else 
            echo "Warning: Verzeichnis nicht gefunden: $basis_folder_delet_folder"
            
        fi
    fi
done

echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"
echo "CMD ausführen - ENDE: $section_del_folder"
echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"