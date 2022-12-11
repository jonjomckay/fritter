import 'dart:convert';

import 'package:flutter_cache/flutter_cache.dart' as cache;
import 'package:fritter/utils/iterables.dart';
import 'package:fritter/utils/misc.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

Future<bool> isLanguageSupportedForTranslation(String lang) async {
  // TODO: Cache this response, per host, for x amount of time
  var res = await TranslationAPI.getSupportedLanguages();
  if (res.success) {
    return findInJSONArray(res.body, 'code', getShortSystemLocale());
  }

  throw res;
}

class TranslationAPIResult {
  final bool success;
  final dynamic body;
  final String? errorMessage;

  TranslationAPIResult({required this.success, required this.body, this.errorMessage});
}

// TODO
class TranslationAPI {
  static final log = Logger('TranslationAPI');

  static Future<TranslationAPIResult> getSupportedLanguages() async {
    var key = 'translation.supported_languages';

    return cacheRequest(key, () async {
      var response = await http.get(Uri.https('libretranslate.de', '/languages'));
      return await parseResponse(response, 'Unable to get supported languages');
    });
  }

  static Future<TranslationAPIResult> translate(String id, List<String> text, String sourceLanguage) async {
    var hasTextOrNot = text.map((e) => e.isNotEmpty ? true : false).toList();

    var formData = {
      // We need to strip out any empty parts, as the API barfs on them sometimes
      'q': text.where((e) => e.isNotEmpty).toList(),
      'source': sourceLanguage,
      'target': getShortSystemLocale(),
      'format': 'text'
    };

    var key = 'translation.$sourceLanguage.$id';

    var res = await cacheRequest(key, () async {
      var response = await http.post(Uri.https('libretranslate.de', '/translate'), body: jsonEncode(formData), headers: {
        'Content-Type': 'application/json'
      });

      return await parseResponse(response, 'Unable to send translation request');
    });

    if (res.success) {
      // We need to rehydrate the empty text parts that we stripped out earlier
      var translatedTexts = List.from(res.body['translatedText']);

      var translatedIndex = 0;
      var result = hasTextOrNot
          .mapWithIndex((hasText, i) => hasText ? translatedTexts[translatedIndex++] : text[i])
          .toList();

      return TranslationAPIResult(success: res.success, body: {
        'translatedText': result
      });
    }

    return res;
  }

  static Future<TranslationAPIResult> cacheRequest(
      String key, Future<TranslationAPIResult> Function() makeRequest) async {
    var result = await cache.load(key);
    if (result != null) {
      // If we have a cached result, return it
      // TODO: Is this success always true? What if we cache an error?
      return TranslationAPIResult(success: true, body: jsonDecode(result));
    }

    // Otherwise, make the request
    var response = await makeRequest();
    if (response.success) {
      // Cache the response if it's a successful one
      var body = await cache.write(key, jsonEncode(response.body));

      return TranslationAPIResult(success: true, body: response.body);
    }

    // Otherwise, we always want to return the error without caching
    return response;
  }

  static Future<TranslationAPIResult> parseResponse(http.Response response, String errorUnableTo) async {
    var body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return TranslationAPIResult(success: true, body: body);
    }

    String message = '';

    switch (response.statusCode) {
      case 400:
        RegExp languageNotSupported = RegExp(r"^\w+\ is\ not\ supported$");

        var error = body['error'];
        if (languageNotSupported.hasMatch(error)) {
          message = 'Language $error';
        } else {
          message = error;
        }
        break;
      case 403:
        message = 'Error: Banned from translation API';
        break;
      case 429:
        message = 'Error: Sending too many frequent translation requests';
        break;
      case 500:
        message = 'Error: The translation API failed to translate the tweet';
        break;
    }

    return TranslationAPIResult(success: false, body: body, errorMessage: message);
  }
}
