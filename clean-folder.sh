#!/bin/bash
# Beispielaufruf
# bash ./_scripts/clean-folder.sh './_scripts/_config_0.1.3.ini' 'del_logs'

# Das erste Argument wird in die Variable $1 gespeichert
ini_file=$1
section=$2

echo "INFO: Argument 1: $ini_file"
echo "INFO: Argument 2: $section"

# Überprüfe, ob die Variable leer ist
if [ -z "$ini_file" ]; then
    echo "Fehler: Es wurde kein Config INI übergeben."
    exit 1
fi

if [ -z "$section" ]; then
    echo "Fehler: Es wurde kein INI-Schlüssel übergeben."
    exit 1
fi

echo "INFO: Es wird folgende INI Datei verwendet: $ini_file"

# Variablen auslesen
basis_folder=$(crudini --get "$ini_file" basis_setup_info basis_folder)
echo "INFO: Übergabe der Variable basisroot=$basis_folder"

basis_version=$(crudini --get "$ini_file" basis_setup_info basis_version)
echo "INFO: Übergabe der Variable basis_version=$basis_version"

basis_django_project_name=$(crudini --get "$ini_file" basis_setup_info basis_django_project_name)
echo "INFO: Übergabe der Variable basis_django_project_name=$basis_django_project_name"

foldername=$(crudini --get $ini_file $section cmd_value01)
echo "INFO: Übergabe der Variable foldername=$foldername"

filename=$(crudini --get $ini_file $section cmd_value02)
echo "INFO: Übergabe der Variable filename=$filename"

folderpath=$basis_folder/$basis_django_project_name/$basis_version/$basis_django_project_name/$foldername
echo "INFO: Es werden in folgendem Verzeichnis Daten gelöscht:"
echo "INFO: $folderpath"

if [ -d $folderpath ]; then
    echo "INFO: find $folderpath -type f -name $filename -print -exec rm -f {} \;"
    find $folderpath -type f -name "$filename" -print -exec rm -f {} \;
else
    echo "Warnung: $foldername Verzeichnis existiert nicht."
fi
