#!/usr/bin/env sh

set -e

fvm flutter packages pub run intl_utils:generate
fvm flutter build appbundle --dart-define=app.flavor=play --release --no-tree-shake-icons