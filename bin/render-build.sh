#!/usr/bin/env bash
# bin/render-build.sh

# Salir si ocurre un error
set -o errexit

# Instalar dependencias
bundle install

# Aplicar migraciones para crear las tablas
rails db:migrate

# Inicializar la base de datos con los datos semilla (bases e ingredientes)
# IMPORTANTE: Descomenta esta línea SOLO la primera vez que despliegas.
# Después de la primera vez, coméntala nuevamente para no sobreescribir los datos.
rails db:seed