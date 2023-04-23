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

VERSION_BASE=300000000

VERSION_NUMBER=""

generate_version_number() {
  commit_number=$(git rev-list HEAD --count)

  VERSION_NUMBER="$((VERSION_BASE+commit_number))"

  if [ -e fastlane/metadata/android/en-US/changelogs/"$VERSION_NUMBER.txt" ]; then
    echo "The version $VERSION_NUMBER already exists"
    exit 1
  fi
}

generate_version_number

VERSION_NUMBER_FDROID_ABI_1="$((VERSION_NUMBER+00000000))"
VERSION_NUMBER_FDROID_ABI_2="$((VERSION_NUMBER+10000000))"
VERSION_NUMBER_FDROID_ABI_3="$((VERSION_NUMBER+20000000))"

VERSION_NAME=$1
VERSION_FLUTTER="3.7.8"

FULL_VERSION="$VERSION_NAME"+"$VERSION_NUMBER"

# Set the new version in pubspec.yaml
sed -i "s/version: .*/version: $FULL_VERSION/g" pubspec.yaml

# Rename the draft changelog with the new version number
if [ -e fastlane/metadata/android/en-US/changelogs/next.txt ]; then
  cp fastlane/metadata/android/en-US/changelogs/next.txt fastlane/metadata/android/en-US/changelogs/"$VERSION_NUMBER".txt
  cp fastlane/metadata/android/en-US/changelogs/next.txt fastlane/metadata/android/en-US/changelogs/"$VERSION_NUMBER_FDROID_ABI_1".txt
  cp fastlane/metadata/android/en-US/changelogs/next.txt fastlane/metadata/android/en-US/changelogs/"$VERSION_NUMBER_FDROID_ABI_2".txt
  cp fastlane/metadata/android/en-US/changelogs/next.txt fastlane/metadata/android/en-US/changelogs/"$VERSION_NUMBER_FDROID_ABI_3".txt
fi

# Create a new draft changelog for the next release
echo "" > fastlane/metadata/android/en-US/changelogs/next.txt

# Commit the changes
git add pubspec.yaml fastlane/metadata/android/en-US/changelogs/next.txt fastlane/metadata/android/en-US/changelogs/3*.txt
git commit -m "Tagging v$VERSION_NAME"
git tag v"$VERSION_NAME"

VERSION_COMMIT=$(git rev-parse HEAD)

echo "F-Droid metadata:"
echo ""

FDROID_METADATA=$(cat << EOF
- versionName: $VERSION_NAME
  versionCode: $VERSION_NUMBER_FDROID_ABI_1
  commit: $VERSION_COMMIT
  output: build/app/outputs/flutter-apk/app-x86_64-release.apk
  srclibs:
    - flutter@$VERSION_FLUTTER
  rm:
    - ios
    - test
  prebuild:
    # Change pub cache location so that the dart packages are scanned by the scanner
    - export PUB_CACHE=$(pwd)/.pub-cache
    - \$\$flutter\$\$/bin/flutter config --no-analytics
    - \$\$flutter\$\$/bin/flutter pub get
  build:
    - export PUB_CACHE=$(pwd)/.pub-cache
    - \$\$flutter\$\$/bin/flutter packages pub run flutter_oss_licenses:generate.dart
    - \$\$flutter\$\$/bin/flutter packages pub run intl_utils:generate
    - \$\$flutter\$\$/bin/flutter build apk --release --no-tree-shake-icons --split-per-abi
      --target-platform=android-x64 --build-number=\$\$VERCODE\$\$
  scandelete:
    - .pub-cache

- versionName: $VERSION_NAME
  versionCode: $VERSION_NUMBER_FDROID_ABI_2
  commit: $VERSION_COMMIT
  output: build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk
  srclibs:
    - flutter@$VERSION_FLUTTER
  rm:
    - ios
    - test
  prebuild:
    # Change pub cache location so that the dart packages are scanned by the scanner
    - export PUB_CACHE=$(pwd)/.pub-cache
    - \$\$flutter\$\$/bin/flutter config --no-analytics
    - \$\$flutter\$\$/bin/flutter pub get
  build:
    - export PUB_CACHE=$(pwd)/.pub-cache
    - \$\$flutter\$\$/bin/flutter packages pub run flutter_oss_licenses:generate.dart
    - \$\$flutter\$\$/bin/flutter packages pub run intl_utils:generate
    - \$\$flutter\$\$/bin/flutter build apk --release --no-tree-shake-icons --split-per-abi
      --target-platform=android-arm --build-number=\$\$VERCODE\$\$
  scandelete:
    - .pub-cache

- versionName: $VERSION_NAME
  versionCode: $VERSION_NUMBER_FDROID_ABI_3
  commit: $VERSION_COMMIT
  output: build/app/outputs/flutter-apk/app-arm64-v8a-release.apk
  srclibs:
    - flutter@$VERSION_FLUTTER
  rm:
    - ios
    - test
  prebuild:
    # Change pub cache location so that the dart packages are scanned by the scanner
    - export PUB_CACHE=$(pwd)/.pub-cache
    - \$\$flutter\$\$/bin/flutter config --no-analytics
    - \$\$flutter\$\$/bin/flutter pub get
  build:
    - export PUB_CACHE=$(pwd)/.pub-cache
    - \$\$flutter\$\$/bin/flutter packages pub run flutter_oss_licenses:generate.dart
    - \$\$flutter\$\$/bin/flutter packages pub run intl_utils:generate
    - \$\$flutter\$\$/bin/flutter build apk --release --no-tree-shake-icons --split-per-abi
      --target-platform=android-arm64 --build-number=\$\$VERCODE\$\$
  scandelete:
    - .pub-cache
EOF
)

echo "$FDROID_METADATA"

# Build the Play Store version
./build-play.sh

git push
git push --tags
