import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens phone, email, maps and web links; shows a snackbar on failure.
class Launcher {
  Launcher._();

  static Future<void> call(
    BuildContext context,
    String phone,
    String errorText,
  ) => _open(
    context,
    Uri(scheme: 'tel', path: phone.replaceAll(' ', '')),
    errorText,
  );

  static Future<void> email(
    BuildContext context,
    String email,
    String errorText,
  ) => _open(context, Uri(scheme: 'mailto', path: email), errorText);

  static Future<void> maps(
    BuildContext context,
    String query,
    String errorText,
  ) => _open(
    context,
    Uri.https('www.google.com', '/maps/search/', {'api': '1', 'query': query}),
    errorText,
  );

  static Future<void> web(BuildContext context, String url, String errorText) =>
      _open(context, Uri.parse(url), errorText);

  static Future<void> _open(
    BuildContext context,
    Uri uri,
    String errorText,
  ) async {
    final messenger = ScaffoldMessenger.maybeOf(context);
    try {
      final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!ok) messenger?.showSnackBar(SnackBar(content: Text(errorText)));
    } catch (_) {
      messenger?.showSnackBar(SnackBar(content: Text(errorText)));
    }
  }
}
