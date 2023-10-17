#!/bin/bash
# Beispielaufruf
# bash ./_scripts/del_file_01.sh './_scripts/_config_0.1.3.ini'

# Das erste Argument wird in die Variable $1 gespeichert
ini_file=$1
section_del_file_01=$2

echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"
echo "CMD ausführen - START: $section_del_file_01"
echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"

echo "INFO: Argument 1: $ini_file"
echo "INFO: Argument 2: $section_del_file_01"

# Überprüfe, ob die Variable leer ist
if [ -z "$ini_file" ]; then
    echo "Fehler: Es wurde kein Config INI übergeben."
    exit 1
fi

if [ -z "$section_del_file_01" ]; then
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
echo "INFO: Auslesen der Werte aus dem Schlüssel $section_del_file_01"
cmds=$(crudini --get $ini_file $section_del_venv_folder | awk -F'=' '{ print $1 }')

for cmd in $cmds; do
    if [[ "$cmd" == cmd_del_file* ]]; then 
        cmd_value=$(crudini --get $ini_file $section_del_file_01 $cmd)
        echo "INFO: $cmd hat den Wert $cmd_value"

        basis_delet_file=$basis_folder/$cmd_value

        if [ -f $basis_delet_file ]; then
            echo "INFO: Datei zum löschen: $basis_delet_file"
            echo "INFO: rm -f $basis_delet_file"
            rm -f $basis_delet_file

        else 
            echo "Warning: Datei nicht gefunden: $basis_delet_file"
            
        fi
    fi
done

echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"
echo "CMD ausführen - ENDE: $section_del_file_01"
echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"
echo""
