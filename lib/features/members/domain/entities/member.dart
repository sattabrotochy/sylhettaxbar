import '../../../../core/localization/app_language.dart';

class Member {
  const Member({
    required this.id,
    required this.nameEn,
    required this.nameBn,
    required this.memberNo,
    this.sanadNo = '',
    this.enrollmentDate,
    this.joiningDate,
    this.phone = '',
    this.email = '',
    this.chamberEn = '',
    this.chamberBn = '',
    this.addressEn = '',
    this.addressBn = '',
    this.bloodGroup = '',
    this.fatherNameEn = '',
    this.fatherNameBn = '',
    this.profileInfoEn = '',
    this.profileInfoBn = '',
    this.isGolden = false,
    this.isFreedomFighter = false,
    this.isRetired = false,
    this.thumbUrl = '',
    this.imageUrl = '',
  });

  final String id;
  final String nameEn;
  final String nameBn;
  final String memberNo;
  final String sanadNo;
  final DateTime? enrollmentDate;
  final DateTime? joiningDate;
  final String phone;
  final String email;
  final String chamberEn;
  final String chamberBn;
  final String addressEn;
  final String addressBn;
  final String bloodGroup;
  final String fatherNameEn;
  final String fatherNameBn;
  final String profileInfoEn;
  final String profileInfoBn;
  final bool isGolden;
  final bool isFreedomFighter;
  final bool isRetired;
  final String thumbUrl;
  final String imageUrl;

  String name(AppLanguage l) => l.pick(nameEn, nameBn);
  String chamber(AppLanguage l) => l.pick(chamberEn, chamberBn);
  String address(AppLanguage l) => l.pick(addressEn, addressBn);
  String fatherName(AppLanguage l) => l.pick(fatherNameEn, fatherNameBn);

  DateTime? get memberSince => enrollmentDate ?? joiningDate;

  bool matches(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return true;
    return nameEn.toLowerCase().contains(q) ||
        nameBn.contains(q) ||
        memberNo.toLowerCase().contains(q) ||
        sanadNo.toLowerCase().contains(q);
  }
}

class MembersPage {
  const MembersPage({required this.members, required this.total});
  final List<Member> members;
  final int total;
}
