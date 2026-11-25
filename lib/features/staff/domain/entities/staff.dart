import '../../../../core/localization/app_language.dart';

class Staff {
  const Staff({
    required this.id,
    required this.nameEn,
    required this.nameBn,
    required this.designationEn,
    required this.designationBn,
    this.educationEn = '',
    this.educationBn = '',
    this.addressEn = '',
    this.addressBn = '',
    this.bloodGroup = '',
    this.mobile = '',
    this.joiningDate,
    this.photoUrl = '',
    this.position = 0,
  });

  final String id;
  final String nameEn;
  final String nameBn;
  final String designationEn;
  final String designationBn;
  final String educationEn;
  final String educationBn;
  final String addressEn;
  final String addressBn;
  final String bloodGroup;
  final String mobile;
  final DateTime? joiningDate;
  final String photoUrl;
  final double position;

  String name(AppLanguage l) => l.pick(nameEn, nameBn);
  String designation(AppLanguage l) => l.pick(designationEn, designationBn);
  String education(AppLanguage l) => l.pick(educationEn, educationBn);
  String address(AppLanguage l) => l.pick(addressEn, addressBn);
}
