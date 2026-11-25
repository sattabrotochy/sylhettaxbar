import '../../../../core/utils/result.dart';
import '../entities/member.dart';

abstract interface class MemberRepository {
  Future<Result<MembersPage>> getMembers({required int page, required int limit});
  Future<Result<Member>> getMemberDetails(String id);
}
