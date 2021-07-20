import 'dart:convert';

import 'package:fritter/utils/misc.dart';
import 'package:http/http.dart';

class APIResult {
  final int code;
  final dynamic body;

  APIResult({ required this.code, required this.body });
}

class TranslationAPI {
  final Uri provider = new Uri(scheme: "https", host: "libretranslate.de");

  Future<APIResult> getSupportedLanguages() async {
    Response res = await get(provider.replace(path: "languages"));

    return APIResult(code: res.statusCode, body: jsonDecode(res.body));
  }

  Future<APIResult> translate(String text, String sourceLanguage) async {
    Response res = await post(provider.replace(path: "translate", queryParameters: {
      'q': text,
      'source': sourceLanguage,
      'target': getShortSystemLocale()
    }));

    return APIResult(code: res.statusCode, body: jsonDecode(res.body));
  }
}