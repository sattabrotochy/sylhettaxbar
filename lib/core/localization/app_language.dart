enum AppLanguage {
  en('en', 'EN'),
  bn('bn', 'বাংলা');

  const AppLanguage(this.code, this.label);
  final String code;
  final String label;

  bool get isBangla => this == AppLanguage.bn;

  static AppLanguage fromCode(String? code) => AppLanguage.values.firstWhere(
    (l) => l.code == code,
    orElse: () => AppLanguage.en,
  );

  /// Picks the Bangla text when available and selected, else English.
  String pick(String en, String bn) {
    if (isBangla && bn.trim().isNotEmpty) return bn;
    return en.trim().isNotEmpty ? en : bn;
  }
}
