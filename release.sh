#!/usr/bin/env sh

set -e

if [ -z "$1" ]; then
  echo "No version name was supplied"
  exit 1
fi

if git diff --quiet; then
  echo "No unstashed changes, so continuing"
else
  echo "You have unstashed or uncommitted changes. Please commit changes before running this!"
  exit 1
fi

VERSION_NUMBER=""

generate_version_number() {
  delta=$1

  VERSION_NUMBER=$(date --date="+$delta days" +%Y%m%d)

  if [ -e fastlane/metadata/android/en-US/changelogs/"$VERSION_NUMBER.txt" ]; then
    echo "The version $VERSION_NUMBER already exists, so incrementing it"
    generate_version_number $((delta + 1))
  fi
}

generate_version_number 0

VERSION_NAME=$1
VERSION_FLUTTER="2.8.1"

FULL_VERSION="$VERSION_NAME"+"$VERSION_NUMBER"

# Set the new version in pubspec.yaml
sed -i "s/version: .*/version: $FULL_VERSION/g" pubspec.yaml

# Rename the draft changelog with the new version number
if [ -e fastlane/metadata/android/en-US/changelogs/next.txt ]; then
  mv fastlane/metadata/android/en-US/changelogs/next.txt fastlane/metadata/android/en-US/changelogs/"$VERSION_NUMBER".txt
fi

# Create a new draft changelog for the next release
touch fastlane/metadata/android/en-US/changelogs/next.txt

# Commit the changes
git add pubspec.yaml fastlane/metadata/android/en-US/changelogs/next.txt fastlane/metadata/android/en-US/changelogs/"$VERSION_NUMBER".txt
git commit -m "Tagging v$VERSION_NAME"
git tag v"$VERSION_NAME"
git push
git push --tags

VERSION_COMMIT=$(git rev-parse HEAD)

echo "F-Droid metadata:"
echo ""

FDROID_METADATA=$(cat << EOF
- versionName: $VERSION_NAME
  versionCode: ${VERSION_NUMBER}0
  commit: $VERSION_COMMIT
  output: build/app/outputs/apk/release/app-x86_64-release.apk
  srclibs:
    - flutter@$VERSION_FLUTTER
  rm:
    - ios
    - test
  build:
    - \$\$flutter\$\$/bin/flutter config --no-analytics
    - \$\$flutter\$\$/bin/flutter packages pub get
    - \$\$flutter\$\$/bin/flutter packages pub run flutter_oss_licenses:generate.dart
    - \$\$flutter\$\$/bin/flutter build apk --release --no-tree-shake-icons --split-per-abi
      --target-platform=android-x64

- versionName: $VERSION_NAME
  versionCode: ${VERSION_NUMBER}1
  commit: $VERSION_COMMIT
  output: build/app/outputs/apk/release/app-armeabi-v7a-release.apk
  srclibs:
    - flutter@$VERSION_FLUTTER
  rm:
    - ios
    - test
  build:
    - \$\$flutter\$\$/bin/flutter config --no-analytics
    - \$\$flutter\$\$/bin/flutter packages pub get
    - \$\$flutter\$\$/bin/flutter packages pub run flutter_oss_licenses:generate.dart
    - \$\$flutter\$\$/bin/flutter build apk --release --no-tree-shake-icons --split-per-abi
      --target-platform=android-arm

- versionName: $VERSION_NAME
  versionCode: ${VERSION_NUMBER}2
  commit: $VERSION_COMMIT
  output: build/app/outputs/apk/release/app-arm64-v8a-release.apk
  srclibs:
    - flutter@$VERSION_FLUTTER
  rm:
    - ios
    - test
  build:
    - \$\$flutter\$\$/bin/flutter config --no-analytics
    - \$\$flutter\$\$/bin/flutter packages pub get
    - \$\$flutter\$\$/bin/flutter packages pub run flutter_oss_licenses:generate.dart
    - \$\$flutter\$\$/bin/flutter build apk --release --no-tree-shake-icons --split-per-abi
      --target-platform=android-arm64
EOF
)

echo "$FDROID_METADATA"

# Build the Play Store version
./build-play.sh
