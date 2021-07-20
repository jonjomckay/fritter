bool findInJSONArray(List arr, String key, String value) {
  for(var item in arr) {
    if(item[key] == value) {
      return true;
    }
  }
  return false;
}