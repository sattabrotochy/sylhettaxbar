/// App-wide configuration.
///
/// Values can be overridden at build time, for example:
/// `flutter run --dart-define=API_BASE_URL=https://... --dart-define=API_KEY=...`
class AppConfig {
  AppConfig._();

  static const String siteUrl = String.fromEnvironment(
    'SITE_URL',
    defaultValue: 'https://www.sylhettaxbar.com',
  );

  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: '$siteUrl/AppController/',
  );

  /// Secret code the backend expects in every POST body as `key`.
  static const String apiKey = String.fromEnvironment(
    'API_KEY',
    defaultValue: 'ITLAB2011',
  );

  static const Duration connectTimeout = Duration(seconds: 20);
  static const Duration receiveTimeout = Duration(seconds: 30);

  static const int membersPageSize = 20;

  // Office contact details (from the API sheet and design).
  static const String officePhone = '+880821712303';
  static const String officePhoneDisplay = '+880 821 712303';
  static const String officeEmail = 'syltaxbar@gmail.com';
  static const String officeAddress =
      '131, MR Tower, Burhan Uddin Road, Mendibagh, Sylhet–3100, Bangladesh';
  static const String officeMapsQuery =
      'MR Tower, Burhan Uddin Road, Mendibagh, Sylhet';

  /// Photo gallery page on the website, shown in an in-app web view.
  static String galleryUrl(String langCode) =>
      '$siteUrl/home/picture/$langCode';

  /// Website page that verifies a digital vakalatnama by its ID.
  static String vakalatnamaVerifyUrl(String langCode, String id) =>
      '$siteUrl/verify/v/$langCode/${Uri.encodeComponent(id)}';

  static const String districtBarUrl = 'https://www.sylhetbar.com.bd/';
}
