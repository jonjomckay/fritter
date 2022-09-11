#!/usr/bin/env sh

flutter packages pub run intl_utils:generate
flutter build appbundle --dart-define=app.flavor=play --release --no-tree-shake-icons