#!/bin/bash
# Realizar configuraciones adicionales si es necesario


rake db:migrate
rake db:seed
# Iniciar la aplicación principal
exec "$@"