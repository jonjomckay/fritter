import 'dart:developer';

import 'package:ffcache/ffcache.dart';

extension CacheHelper<T> on FFCache {
  Future<String> getOrCreateAsJSON(String key, Duration expiry, Future<String> Function() create) async {
    var exists = await has(key);
    if (exists) {
      log('Loading $key from the cache');

      return await getJSON(key);
    }

    log('Loading $key from the source');

    var result = await create();

    await setJSONWithTimeout(key, result, expiry);

    return result;
  }
}