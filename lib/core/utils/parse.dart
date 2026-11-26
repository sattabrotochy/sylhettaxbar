/// Helpers for the loosely typed backend JSON (numbers as strings,
/// `0000-00-00` dates, `N/A` placeholders, nulls).
class Parse {
  Parse._();

  static String str(dynamic v) {
    if (v == null) return '';
    final s = v.toString().trim();
    if (s.toUpperCase() == 'N/A' || s == 'null') return '';
    return s;
  }

  static bool flag(dynamic v) => str(v) == '1';

  static int integer(dynamic v, [int fallback = 0]) =>
      int.tryParse(str(v)) ?? double.tryParse(str(v))?.toInt() ?? fallback;

  static double number(dynamic v, [double fallback = 0]) =>
      double.tryParse(str(v)) ?? fallback;

  static DateTime? date(dynamic v) {
    final s = str(v);
    if (s.isEmpty || s.startsWith('0000')) return null;
    return DateTime.tryParse(s);
  }

  static List<Map<String, dynamic>> list(dynamic v) {
    if (v is List) {
      return v
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    }
    return const [];
  }
}
