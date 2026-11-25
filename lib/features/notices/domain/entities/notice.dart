import '../../../../core/localization/app_language.dart';

enum NoticeType { notice, news }

class Notice {
  const Notice({
    required this.id,
    required this.type,
    required this.titleEn,
    required this.titleBn,
    this.date,
    this.endDate,
    this.detailsHtmlEn = '',
    this.detailsHtmlBn = '',
    this.attachmentUrl = '',
  });

  final String id;
  final NoticeType type;
  final String titleEn;
  final String titleBn;
  final DateTime? date;
  final DateTime? endDate;
  final String detailsHtmlEn;
  final String detailsHtmlBn;
  final String attachmentUrl;

  String title(AppLanguage l) => l.pick(titleEn, titleBn);
  String detailsHtml(AppLanguage l) => l.pick(detailsHtmlEn, detailsHtmlBn);
  bool get hasAttachment => attachmentUrl.isNotEmpty;

  bool get isImageAttachment {
    final u = attachmentUrl.toLowerCase();
    return u.endsWith('.jpg') ||
        u.endsWith('.jpeg') ||
        u.endsWith('.png') ||
        u.endsWith('.webp') ||
        u.endsWith('.gif');
  }
}
