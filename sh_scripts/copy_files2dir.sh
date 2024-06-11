#!/bin/bash

# Definir el nombre de la carpeta temporal
TEMP_FOLDER="temp_folder"

# Crear la carpeta temporal si no existe
if [ ! -d "$TEMP_FOLDER" ]; then
  mkdir "$TEMP_FOLDER"
  echo "Created directory: $TEMP_FOLDER"
else
  echo "Directory already exists: $TEMP_FOLDER"
fi

# Leer la lista de archivos y copiarlos a la carpeta temporal
while IFS= read -r file; do
  if [ -f "$file" ]; then
    cp "$file" "$TEMP_FOLDER"
    echo "Copied $file to $TEMP_FOLDER"
  else
    echo "File does not exist: $file"
  fi
done < file_list.txt

