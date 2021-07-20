import 'dart:io';

bool findInJSONArray(List arr, String key, String value) {
  for(var item in arr) {
    if(item[key] == value) {
      return true;
    }
  }
  return false;
}

String getShortSystemLocale() {
  return Platform.localeName.split("_")[0];
}