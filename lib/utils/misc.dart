import 'dart:io';

bool findInJSONArray(List arr, String key, String value) {
  for (var item in arr) {
    if (item[key] == value) {
      return true;
    }
  }
  return false;
}

bool isTranslatable(String? lang, String? text) {
  if (lang == null || lang == 'und') {
    return false;
  }

  if (lang != getShortSystemLocale()) {
    return true;
  }

  return false;
}

String getShortSystemLocale() {
  // TODO: Cache
  return Platform.localeName.split("_")[0];
}
