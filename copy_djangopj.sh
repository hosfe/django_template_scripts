#!/bin/bash
# Beispielaufruf
# bash ./_scripts/copy_djangopj.sh './_scripts/_config_0.1.3.ini'

# Das erste Argument wird in die Variable $1 gespeichert
ini_file=$1
section_copy_djangoproject=$2

echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"
echo "CMD ausführen - START: $section_copy_djangoproject"
echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"

echo "INFO: Argument 1: $ini_file"

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

copy_djangoproject_folder=$(crudini --get "$ini_file" $section_copy_djangoproject copy_djangoproject_folder)
copy_djangoproject_version=$(crudini --get "$ini_file" $section_copy_djangoproject copy_djangoproject_version)
copy_djangoproject_name=$(crudini --get "$ini_file" $section_copy_djangoproject copy_djangoproject_name)

 # Überprüfe, ob die Variable gleich basis_folder = copy_djangoproject_folder
if [[ "$copy_djangoproject_folder" = "$basis_folder" ]]; then
    basis_root=$basis_folder/$basis_django_project_name/$basis_version
    source_root=$copy_djangoproject_folder/$copy_djangoproject_name/$copy_djangoproject_version/
    echo "Info: Es wird ein Django Projekt im selben Verzeichnis erstellt."
    echo "Neues Root-Verzeichnis: $basis_root"
    echo "Sources Root-Verzeichnis: $source_root"
    # echo "cp -r $source_root $basis_root"


    if [ -d "$basis_root" ]; then
        echo "Das Verzeichnis existiert."
        echo "Der Copy-Prozess wird gestartet:"
        echo "cp -r $source_root $basis_root"
        cp -r $source_root $basis_root
    else
        echo "Das Ziel-Verzeichnis existiert nicht."
        echo "Ziel-Verzeichnis wird erstellt:"
        echo "mkdir $basis_root"
        mkdir $basis_root
        
        echo "Der Copy-Prozess wird gestartet:"
        echo "cp -r $source_root $basis_root"
        sleep 2
        cp -r $source_root $basis_root
    fi
else
    echo "Warning: Es wird kein Django Projekt Verzeichnis erstellt!"
    echo "Warning: Dieser Teil des Scriptes muss noch optimiert werden!"
    echo "Warning: Werte $basis_root = $source_root sind ungleich"
    exit 1
fi

echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"
echo "CMD ausführen - ENDE: $section_copy_djangoproject"
echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"