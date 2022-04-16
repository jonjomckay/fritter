import 'package:http/http.dart';

class HttpException {
  final Response response;

  HttpException(this.response);

  get statusCode => response.statusCode;
  get reasonPhrase => response.reasonPhrase;
  get body => response.body;
  get uri => response.request?.url.toString();

  @override
  String toString() {
    return 'HttpException{statusCode: $statusCode, reasonPhrase: $reasonPhrase, uri: $uri, body: $body';
  }
}

class ManuallyReportedException {
  final Object? exception;

  ManuallyReportedException(this.exception);
}
