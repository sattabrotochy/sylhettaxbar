import '../../../../core/network/api_endpoints.dart';
import '../../../../core/utils/parse.dart';
import '../../domain/entities/staff.dart';

class StaffModel {
  StaffModel._();

  static Staff fromJson(Map<String, dynamic> j) {
    final id = Parse.str(j['staff_id']);
    return Staff(
      id: id,
      nameEn: Parse.str(j['name_en']),
      nameBn: Parse.str(j['name_bn']),
      designationEn: Parse.str(j['designation_en']),
      designationBn: Parse.str(j['designation_bn']),
      educationEn: Parse.str(j['edu_en']),
      educationBn: Parse.str(j['edu_bn']),
      addressEn: Parse.str(j['address_en']),
      addressBn: Parse.str(j['address_bn']),
      bloodGroup: Parse.str(j['bg']),
      mobile: Parse.str(j['mobile']),
      joiningDate: Parse.date(j['joining']),
      photoUrl: ApiEndpoints.staffImage(id, Parse.str(j['img_ext'])),
      position: Parse.number(j['position']),
    );
  }
}
