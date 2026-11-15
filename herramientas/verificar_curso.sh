#!/usr/bin/env bash
# Revisa que el curso esté sano. Lo corre GitHub en el repo de la organización y lo podés correr vos
# antes de mandar un cambio a los ejercicios, los tests o las soluciones.
#
#   bash herramientas/verificar_curso.sh
#
# Hace dos cosas:
#   1. Con los esqueletos tal como están en modulos/, cada archivo de test/ tiene que FALLAR.
#      Si uno pasa, el test no está revisando nada y hay que arreglarlo.
#   2. En una copia temporal pone soluciones/ encima de modulos/ y corre todos los tests. Tienen que PASAR.
#
# Usa el comando flutter del PATH. Si tu Flutter está en otro lado: FLUTTER=/ruta/a/flutter bash herramientas/verificar_curso.sh
set -uo pipefail

FLUTTER="${FLUTTER:-flutter}"
raiz="$(cd "$(dirname "$0")/.." && pwd)"
cd "$raiz"

problemas=0

echo "== 1. Los esqueletos tienen que fallar =="
for archivo in test/m*_test.dart; do
  salida="$("$FLUTTER" test "$archivo" 2>&1)"
  codigo=$?
  resumen="$(printf '%s\n' "$salida" | grep -Eo '\+[0-9]+( ~[0-9]+)?( -[0-9]+)?: ' | tail -n 1)"
  if [ "$codigo" -eq 0 ]; then
    echo "MAL   $archivo pasa con el esqueleto ($resumen)"
    problemas=$((problemas + 1))
  else
    echo "BIEN  $archivo falla con el esqueleto ($resumen)"
  fi
done

echo
echo "== 2. Las soluciones tienen que pasar =="
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
# Copia todo menos .git y build, sin depender de rsync.
tar --exclude=./.git --exclude=./build -cf - . | tar -xf - -C "$tmp"
cp -R soluciones/. "$tmp/modulos/"
if (cd "$tmp" && "$FLUTTER" test); then
  echo "BIEN  todas las pruebas pasan con las soluciones"
else
  echo "MAL   alguna prueba falla con las soluciones"
  problemas=$((problemas + 1))
fi

echo
if [ "$problemas" -eq 0 ]; then
  echo "Curso sano."
else
  echo "Hay $problemas problema(s). Revisá los MAL de arriba."
  exit 1
fi
