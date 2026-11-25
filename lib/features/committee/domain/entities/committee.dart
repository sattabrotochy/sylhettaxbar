import '../../../../core/localization/app_language.dart';

enum CommitteeStatus {
  active('active', 'present'),
  previous('previous', 'previous');

  const CommitteeStatus(this.apiValue, this.responseKey);
  final String apiValue;
  final String responseKey;
}

class Committee {
  const Committee({
    required this.id,
    required this.name,
    this.startDate,
    this.bannerUrl = '',
  });

  final String id;
  final String name;
  final DateTime? startDate;
  final String bannerUrl;
}

class CommitteeMember {
  const CommitteeMember({
    required this.id,
    required this.memberId,
    required this.nameEn,
    required this.nameBn,
    required this.designationEn,
    required this.designationBn,
    required this.priority,
    this.memberNo = '',
    this.phone = '',
    this.photoUrl = '',
  });

  final String id;
  final String memberId;
  final String nameEn;
  final String nameBn;
  final String designationEn;
  final String designationBn;
  final int priority;
  final String memberNo;
  final String phone;
  final String photoUrl;

  String name(AppLanguage l) => l.pick(nameEn, nameBn);
  String designation(AppLanguage l) => l.pick(designationEn, designationBn);

  bool get isLeader {
    final d = designationEn.toLowerCase();
    return d == 'president' ||
        d.contains('general secretary') ||
        d.contains('gen. secretary');
  }
}
