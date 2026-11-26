import '../../../../core/network/api_endpoints.dart';
import '../../../../core/utils/parse.dart';
import '../../domain/entities/committee.dart';

class CommitteeModel {
  CommitteeModel._();

  static Committee fromJson(Map<String, dynamic> j) {
    final id = Parse.str(j['committee_id']);
    return Committee(
      id: id,
      name: Parse.str(j['committee_period_name']),
      startDate: Parse.date(j['committee_start_time']),
      bannerUrl: ApiEndpoints.committeeBanner(
        id,
        Parse.str(j['committee_img_ext']),
      ),
    );
  }
}

class CommitteeMemberModel {
  CommitteeMemberModel._();

  static CommitteeMember fromJson(Map<String, dynamic> j) {
    final memberId = Parse.str(j['member_id']);
    return CommitteeMember(
      id: Parse.str(j['committee_member_id']),
      memberId: memberId,
      nameEn: Parse.str(j['member_name']),
      nameBn: Parse.str(j['member_name_bn']),
      designationEn: Parse.str(j['member_designation']),
      designationBn: Parse.str(j['member_designation_bn']),
      priority: Parse.integer(j['member_priority'], 999),
      memberNo: Parse.str(j['member_id_no']),
      phone: Parse.str(j['member_phone']),
      photoUrl: ApiEndpoints.memberThumb(
        memberId,
        Parse.str(j['member_image_ext']),
      ),
    );
  }
}
