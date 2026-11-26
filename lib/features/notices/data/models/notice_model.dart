import '../../../../core/network/api_endpoints.dart';
import '../../../../core/utils/parse.dart';
import '../../domain/entities/notice.dart';

/// Maps a `bill_*` object from `get_notice` / `notice_details`.
///
/// `bill_type` 0 and 1 are both used for notices on the live servers.
/// Any other value is treated as news until the backend confirms the codes.
class NoticeModel {
  NoticeModel._();

  static const _noticeTypeCodes = {'', '0', '1'};

  static Notice fromJson(Map<String, dynamic> j) {
    final id = Parse.str(j['bill_id']);
    return Notice(
      id: id,
      type: _noticeTypeCodes.contains(Parse.str(j['bill_type']))
          ? NoticeType.notice
          : NoticeType.news,
      titleEn: Parse.str(j['bill_title']),
      titleBn: Parse.str(j['bill_title_bn']),
      date: Parse.date(j['bill_action_date']) ?? Parse.date(j['bill_doc']),
      endDate: Parse.date(j['bill_end_date']),
      detailsHtmlEn: Parse.str(j['bill_details']),
      detailsHtmlBn: Parse.str(j['bill_details_bn']),
      attachmentUrl: ApiEndpoints.noticeAttachment(
        id,
        Parse.str(j['bill_attachment_ext']),
      ),
    );
  }
}
