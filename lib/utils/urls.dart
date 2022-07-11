import 'package:url_launcher/url_launcher_string.dart';

Future<void> openUri(String uri) async {
  await launchUrlString(uri, mode: LaunchMode.externalApplication);
}