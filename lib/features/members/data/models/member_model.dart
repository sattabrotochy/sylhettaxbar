import '../../../../core/network/api_endpoints.dart';
import '../../../../core/utils/parse.dart';
import '../../domain/entities/member.dart';

/// Maps a member JSON object from `get_all_members` / `member_details`.
class MemberModel {
  MemberModel._();

  static Member fromJson(Map<String, dynamic> j) {
    final id = Parse.str(j['member_id']);
    final ext = Parse.str(j['member_image_ext']);
    final phoneVisible = Parse.str(j['member_phone_status']) != '0';
    final emailVisible = Parse.str(j['member_email_status']) != '0';

    return Member(
      id: id,
      nameEn: Parse.str(j['member_name']),
      nameBn: Parse.str(j['member_name_bn']),
      memberNo: Parse.str(j['member_id_no']),
      sanadNo: Parse.str(j['member_sanad']),
      enrollmentDate: Parse.date(j['member_enrollment']),
      joiningDate: Parse.date(j['member_joining']),
      phone: phoneVisible ? Parse.str(j['member_phone']) : '',
      email: emailVisible ? Parse.str(j['member_email']) : '',
      chamberEn: Parse.str(j['member_chamber']),
      chamberBn: Parse.str(j['member_chamber_bn']),
      addressEn: Parse.str(j['member_pre_add']),
      addressBn: Parse.str(j['member_pre_add_bn']),
      bloodGroup: Parse.str(j['member_blood_group']),
      fatherNameEn: Parse.str(j['member_father_name']),
      fatherNameBn: Parse.str(j['member_father_name_bn']),
      profileInfoEn: Parse.str(j['member_pro_info']),
      profileInfoBn: Parse.str(j['member_pro_info_bn']),
      isGolden: Parse.flag(j['member_golden_status']),
      isFreedomFighter: Parse.flag(j['member_freedom_fighter']),
      isRetired: Parse.flag(j['member_retired']),
      thumbUrl: ApiEndpoints.memberThumb(id, ext),
      imageUrl: ApiEndpoints.memberImage(id, ext),
    );
  }
}
