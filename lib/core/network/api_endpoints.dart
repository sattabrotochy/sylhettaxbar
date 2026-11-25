import '../config/app_config.dart';

/// Paths of the `AppController` backend, relative to [AppConfig.apiBaseUrl].
class ApiEndpoints {
  ApiEndpoints._();

  /// [page] is the 1-based "level", [limit] the page size.
  static String members(int page, int limit) => 'get_all_members/$page/$limit';
  static String memberDetails(String id) => 'member_details/$id';
  static String newMembers(String lastId) => 'get_new_members/$lastId';

  static String notices(int limit) => 'get_notice/$limit';
  static String noticeDetails(String id) => 'notice_details/$id';

  /// [status] is `active` or `previous`.
  static String committees(String status) => 'get_committee/$status';
  static String committeeMembers(String committeeId) =>
      'get_committee_member/$committeeId';

  static const String staffList = 'get_staff_data';
  static String staffDetails(String id) => 'staff_details/$id';

  static const String appInfo = 'app_info';

  // Static files.
  static String _file(String folder, String id, String ext) {
    if (ext.isEmpty) return '';
    final dotExt = ext.startsWith('.') ? ext : '.$ext';
    return '${AppConfig.siteUrl}/uploads/images/$folder/$id$dotExt';
  }

  static String memberThumb(String id, String ext) =>
      _file('member/thumb', id, ext);
  static String memberImage(String id, String ext) => _file('member', id, ext);
  static String committeeBanner(String id, String ext) =>
      _file('commitee', id, ext);
  static String staffImage(String id, String ext) =>
      _file('staff/thumb', id, ext);
  static String noticeAttachment(String id, String ext) =>
      _file('bill', id, ext);
}
