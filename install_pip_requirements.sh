#!/bin/bash
# Beispielaufruf
# bash ./_scripts/install_pip_requirements.sh './_scripts/_config_0.1.3.ini'

# Das erste Argument wird in die Variable $1 gespeichert
ini_file=$1
section_install_pip_requirements=$2

echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"
echo "CMD ausführen - START: $section_install_pip_requirements"
echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"

echo "INFO: Argument 1: $ini_file"
echo "INFO: Argument 2: $section_install_pip_requirements"


# Überprüfe, ob die Variable leer ist
if [ -z "$ini_file" ]; then
    echo "Fehler: Es wurde kein Config INI übergeben."
    exit 1
fi

if [ -z "$section_install_pip_requirements" ]; then
    echo "Fehler: Es wurde kein INI-Schlüssel übergeben."
    exit 1
fi

echo "Info: Es wird folgende INI Datei verwendet: $ini_file"

# Variablen auslesen
basis_folder=$(crudini --get "$ini_file" basis_setup_info basis_folder)
basis_version=$(crudini --get "$ini_file" basis_setup_info basis_version)
basis_django_project_name=$(crudini --get "$ini_file" basis_setup_info basis_django_project_name)

basis_folder_env=$basis_folder/$basis_django_project_name/$basis_version
basis_run_folder=$basis_folder/$basis_django_project_name
basis_project_folder=$basis_folder/$basis_django_project_name/$basis_version/$basis_django_project_name

# Schritt 1 - Schlüssel auslesen
echo "INFO: Auslesen der Werte aus dem Schlüssel $section_install_pip_requirements"
cmds=$(crudini --get $ini_file $section_install_pip_requirements | awk -F'=' '{ print $1 }')

for cmd in $cmds; do
    if [[ "$cmd" == cmd_command_start_* ]]; then 
        cmd_command_start=$(crudini --get $ini_file $section_install_pip_requirements $cmd)
        echo "INFO: $cmd hat den Wert $cmd_command_start"
    fi
    if [[ "$cmd" == cmd_command_filepath_* ]]; then 
        cmd_command_filepath=$(crudini --get $ini_file $section_install_pip_requirements $cmd)
        echo "INFO: $cmd hat den Wert $cmd_command_filepath"
    fi
done

if [ -d $basis_folder_env ]; then
    echo "INFO: Befehl aus dem Verzeichnisgestartet: $basis_folder_env"
    echo "INFO: cd $basis_folder_env"
    cd $basis_folder_env
    echo "INFO: Run Command: source env/bin/activate"
    source env/bin/activate

    path_requirement=$basis_project_folder/$cmd_command_filepath
    echo "INFO: Path zum Requirememt File: $path_requirement"
    if [ -f $path_requirement ]; then
        echo "INFO: Path zum Requirememt File: $path_requirement"
        echo "INFO: run command: $cmd_command_start $path_requirement"
        $cmd_command_start $path_requirement
        echo "INFO: run command: cd $basis_run_folder"
        cd $basis_run_folder
        echo "INFO: run command: deactivate"
        deactivate

    else
        echo "WARNING: Path zum Requirememt File nicht gefunden: $path_requirement"
    fi

else 
    echo "Warning: Verzeichnis nicht gefunden: $basis_folder_env"
    
fi

echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"
echo "CMD ausführen - ENDE: $section_install_pip_requirements"
echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"
