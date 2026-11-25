import '../localization/app_language.dart';

/// Small date formatting helpers (avoids pulling in `intl`).
class DateFmt {
  DateFmt._();

  static const _monthsEn = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  static const _monthsBn = [
    'জানু', 'ফেব্রু', 'মার্চ', 'এপ্রিল', 'মে', 'জুন',
    'জুলাই', 'আগস্ট', 'সেপ্টে', 'অক্টো', 'নভে', 'ডিসে',
  ];
  static const _bnDigits = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];

  static String digits(String s, AppLanguage l) {
    if (!l.isBangla) return s;
    return s.replaceAllMapped(RegExp(r'\d'), (m) => _bnDigits[int.parse(m[0]!)]);
  }

  static String day(DateTime d, AppLanguage l) =>
      digits(d.day.toString().padLeft(2, '0'), l);

  static String month(DateTime d, AppLanguage l) =>
      (l.isBangla ? _monthsBn : _monthsEn)[d.month - 1];

  /// e.g. "16 Nov 2026".
  static String full(DateTime? d, AppLanguage l) {
    if (d == null) return '';
    return '${day(d, l)} ${month(d, l)} ${digits(d.year.toString(), l)}';
  }

  static String year(DateTime? d, AppLanguage l) =>
      d == null ? '' : digits(d.year.toString(), l);
}
