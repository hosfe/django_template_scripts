#!/bin/bash
# Beispielaufruf
# bash ./_scripts/_setup_script01.sh './_scripts/_config_0.1.3.ini'
# bash ./_scripts/_setup_script01.sh './_scripts/_config_0.1.4.ini'

set -e

# Das erste Argument wird in die Variable $1 gespeichert
ini_file=$1
section_setup=setup

echo ""
echo ""
echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"
echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"
echo "_setup_script01 - START: $section_setup"
echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"

echo "INFO: Argument 1: $ini_file"
echo "INFO: Argument 2: $section_setup"

# Überprüfe, ob die Variable leer ist
if [ -z "$ini_file" ]; then
    echo "Fehler: Es wurde kein Config INI übergeben."
    exit 1
fi

echo "INFO: Es wird folgende INI Datei verwendet: $ini_file"

# Schritt 1 - SETUP
echo ""
echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"
echo "Schritt 1 - Setup Infos lesen"
echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"
echo "INFO - Schritt 1: Auslesen der Werte aus dem Schlüssel $setup"
setups=$(crudini --get $ini_file $section_setup | awk -F'=' '{ print $1 }')

for setup in $setups; do
    echo "INFO: Start - for setup in setups"
    echo "$ini_file $section_setup $setup  "
    echo "DEBUG: !!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    setup_value=$(crudini --get $ini_file $section_setup $setup)
    echo "INFO: $setup hat den Wert $setup_value"

    # Schritt 2 - TASK
    echo ""
    echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"
    echo "Schritt 2 - Task Infos lesen"
    echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"
    echo "INFO - Schritt 2: Auslesen der Werte aus dem Schlüssel $setup_value"
    tasks=$(crudini --get $ini_file $setup_value | awk -F'=' '{ print $1 }')
    
    for task in $tasks; do
        task_value=$(crudini --get $ini_file $setup_value $task)
        echo "INFO - Schritt 2: task:$task hat den Wert task_value:$task_value"

        # Schritt 3 - CMD
        echo ""
        echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"
        echo "Schritt 3 - CMD Infos lesen"
        echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"
        echo "INFO - Schritt 3: Auslesen der Werte aus dem Schlüssel $task_value"
        cmds=$(crudini --get $ini_file $task_value | awk -F'=' '{ print $1 }')

        for cmd in $cmds; do
            cmd_value=$(crudini --get $ini_file $task_value $cmd)
            echo "INFO - Schritt 3: $cmd hat den Wert $cmd_value"

            if [ "$cmd" == "cmd_bool" ]; then
                echo "INFO - Schritt 3: Die Variable ist cmd_bool."
                if [ "$cmd_value" == "true" ]; then
                    echo "INFO - Schritt 3: $cmd hat den Wert $cmd_value"
                    cmd_bool="true"
                fi                
            fi

            if [ "$cmd" == "cmd_name" ]; then
                echo "INFO - Schritt 3: Die Variable ist $cmd_value == cmd_name."
                cmd_name=$cmd_value
            fi
        done

        if [ "$cmd_bool" == "true" ]; then
            echo ""
            echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"
            echo "Schritt 4 - CMD Ausführen"
            echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"
            echo "INFO - Schritt 4: Bash Befehl ist: source ./_scripts/$cmd_name $ini_file $task_value"
            start="./_scripts/$cmd_name $ini_file $task_value"
            source $start
        else
            echo "Fehler - Schritt 4: Bash Befehl ist: source ./_scripts/$cmd_name $ini_file $task_value existiert nicht"
        fi
    done
    echo "INFO: ENDE - for setup in setups"
done

echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"
echo "_setup_script01 - ENDE: $section_setup"
echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"
echo ""