import 'package:flutter_test/flutter_test.dart';
import 'package:sylhettaxesbar/core/localization/app_language.dart';
import 'package:sylhettaxesbar/core/network/api_endpoints.dart';
import 'package:sylhettaxesbar/core/utils/parse.dart';
import 'package:sylhettaxesbar/features/members/data/models/member_model.dart';
import 'package:sylhettaxesbar/features/notices/data/models/notice_model.dart';
import 'package:sylhettaxesbar/features/notices/domain/entities/notice.dart';

void main() {
  group('Parse', () {
    test('treats empty dates and N/A as missing', () {
      expect(Parse.date('0000-00-00'), isNull);
      expect(Parse.date('2026-11-09'), DateTime(2026, 11, 9));
      expect(Parse.str('   N/A'), '');
      expect(Parse.list(false), isEmpty);
    });
  });

  group('MemberModel', () {
    test('maps API fields and builds image URLs', () {
      final m = MemberModel.fromJson({
        'member_id': '2',
        'member_name': 'Abu Muhammad Asad',
        'member_name_bn': '   N/A',
        'member_id_no': '1002',
        'member_image_ext': '.png',
        'member_phone': '01712129822',
        'member_phone_status': '1',
        'member_email': 'x@y.com',
        'member_email_status': '0',
        'member_golden_status': '1',
        'member_enrollment': '0000-00-00',
      });
      expect(m.name(AppLanguage.bn), 'Abu Muhammad Asad'); // falls back to EN
      expect(m.thumbUrl, endsWith('/uploads/images/member/thumb/2.png'));
      expect(m.phone, '01712129822');
      expect(m.email, ''); // hidden by email_status 0
      expect(m.isGolden, isTrue);
      expect(m.memberSince, isNull);
      expect(m.matches('1002'), isTrue);
    });

    test('no image extension means no URL', () {
      expect(ApiEndpoints.memberThumb('1', ''), '');
    });
  });

  group('NoticeModel', () {
    test('maps a notice with attachment', () {
      final n = NoticeModel.fromJson({
        'bill_id': '54',
        'bill_type': '0',
        'bill_title': 'Notice',
        'bill_title_bn': 'নোটিশ',
        'bill_action_date': '2026-07-23',
        'bill_attachment_ext': '.jpeg',
      });
      expect(n.type, NoticeType.notice);
      expect(n.title(AppLanguage.bn), 'নোটিশ');
      expect(n.attachmentUrl, endsWith('/uploads/images/bill/54.jpeg'));
      expect(n.isImageAttachment, isTrue);
    });
  });
}
