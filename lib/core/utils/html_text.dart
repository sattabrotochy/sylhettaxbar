/// Converts the simple HTML the backend stores for notices (`<p>`, `<br>`,
/// lists, entities) into readable plain text.
class HtmlText {
  HtmlText._();

  static final _blockEnd =
      RegExp(r'</(p|div|h[1-6]|li|tr|ul|ol|table)\s*>', caseSensitive: false);
  static final _br = RegExp(r'<br\s*/?>', caseSensitive: false);
  static final _li = RegExp(r'<li[^>]*>', caseSensitive: false);
  static final _tag = RegExp(r'<[^>]+>');
  static final _spaces = RegExp(r'[ \t ]+');
  static final _blankLines = RegExp(r'\n\s*\n\s*\n+');
  static final _numeric = RegExp(r'&#(x?[0-9a-fA-F]+);');

  static const _entities = {
    '&nbsp;': ' ',
    '&amp;': '&',
    '&lt;': '<',
    '&gt;': '>',
    '&quot;': '"',
    '&#39;': "'",
    '&apos;': "'",
    '&ndash;': '–',
    '&mdash;': '—',
  };

  static String toPlain(String html) {
    if (html.trim().isEmpty) return '';
    var s = html
        .replaceAll('\r', '')
        .replaceAll(_br, '\n')
        .replaceAll(_li, '• ')
        .replaceAll(_blockEnd, '\n\n')
        .replaceAll(_tag, '');
    _entities.forEach((k, v) => s = s.replaceAll(k, v));
    s = s.replaceAllMapped(_numeric, (m) {
      final raw = m[1]!;
      final code = raw.startsWith('x')
          ? int.tryParse(raw.substring(1), radix: 16)
          : int.tryParse(raw);
      return code == null ? m[0]! : String.fromCharCode(code);
    });
    return s
        .split('\n')
        .map((line) => line.replaceAll(_spaces, ' ').trim())
        .join('\n')
        .replaceAll(_blankLines, '\n\n')
        .trim();
  }
}
