import 'package:catcher/catcher.dart';
import 'package:dio/dio.dart';
import 'package:flutter_cache/flutter_cache.dart' as cache;
import 'package:fritter/utils/misc.dart';
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

class TranslationAPI {
  static final log = Logger('TranslationAPI');

  static final Dio _dio = Dio(BaseOptions(
    // TODO
    baseUrl: 'https://libretranslate.de',
  ));

  static Future<TranslationAPIResult> getSupportedLanguages() async {
    var key = 'translation.supported_languages';

    // return cacheRequest(key, () async {
    return sendRequest('/languages', 'Unable to get supported languages');
    // });
  }

  static Future<TranslationAPIResult> translate(String id, List<String> text, String sourceLanguage) async {
    var formData = {'q': text, 'source': sourceLanguage, 'target': getShortSystemLocale()};

    var key = 'translation.$sourceLanguage.$id';

    // return cacheRequest(key, () async {
    return sendRequest('/translate', 'Unable to send translation request',
        data: formData, options: Options(method: 'POST'));
    // });
  }

  static Future<TranslationAPIResult> cacheRequest(
      String key, Future<TranslationAPIResult> Function() makeRequest) async {
    var result = await cache.load(key);
    if (result != null) {
      // If we have a cached result, return it
      // TODO: Is this success always true? What if we cache an error?
      return TranslationAPIResult(success: true, body: result);
    }

    // Otherwise, make the request
    var response = await makeRequest();
    if (response.success) {
      // Cache the response if it's a successful one
      var body = await cache.write(key, response.body);

      return TranslationAPIResult(success: true, body: body);
    }

    // Otherwise, we always want to return the error without caching
    return response;
  }

  static Future<TranslationAPIResult> sendRequest(String path, String errorUnableTo,
      {Options? options, Object? data}) async {
    try {
      var response = await _dio.request(path, data: data, options: options);

      return TranslationAPIResult(success: response.statusCode == 200, body: response.data);
    } on DioError catch (e, stackTrace) {
      var response = e.response;
      if (response == null) {
        log.severe(errorUnableTo);
        Catcher.reportCheckedError(e, stackTrace);
        rethrow;
      }

      String message = '';

      switch (response.statusCode) {
        case 400:
          RegExp languageNotSupported = RegExp(r"^\w+\ is\ not\ supported$");

          var error = response.data['error'];
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

      return TranslationAPIResult(success: false, body: response.data, errorMessage: message);
    } catch (e, stackTrace) {
      log.severe('Unable to translate');
      Catcher.reportCheckedError(e, stackTrace);
      rethrow;
    }
  }
}
