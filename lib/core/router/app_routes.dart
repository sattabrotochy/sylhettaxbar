class AppRoutes {
  AppRoutes._();

  static const splash = '/';
  static const onboarding = '/onboarding';

  // Bottom-nav tabs
  static const home = '/home';
  static const members = '/members';
  static const notices = '/notices';
  static const more = '/more';

  // Detail and secondary screens
  static String member(String id) => '/members/$id';
  static String notice(String id) => '/notices/$id';
  static const committee = '/committee';
  static const staff = '/staff';
  static const gallery = '/gallery';
  static const verifyVakalatnama = '/verify-vakalatnama';
  static String vakalatnama(String id) =>
      Uri(path: verifyVakalatnama, queryParameters: {'id': id}).toString();
  static const about = '/about';
  static const history = '/history';
  static const constitution = '/constitution';
  static const contact = '/contact';
  static const privacy = '/privacy';
}
