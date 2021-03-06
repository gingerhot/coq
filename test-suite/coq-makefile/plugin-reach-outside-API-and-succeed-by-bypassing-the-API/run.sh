#!/usr/bin/env bash

set -e

cat > _CoqProject <<EOT
-bypass-API
-I src/

./src/test_plugin.mllib
./src/test.ml4
./src/test.mli
EOT

mkdir -p src

cat > src/test_plugin.mllib <<EOT
Test
EOT

touch src/test.mli

cat > src/test.ml4 <<EOT
DECLARE PLUGIN "test"

let _ = Pre_env.empty_env
EOT

${COQBIN}coq_makefile -f _CoqProject -o Makefile
cat Makefile.conf

make VERBOSE=1
