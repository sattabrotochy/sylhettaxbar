import '../../../../core/utils/result.dart';
import '../entities/member.dart';
import '../repositories/member_repository.dart';

class GetMembers {
  const GetMembers(this._repository);
  final MemberRepository _repository;

  Future<Result<MembersPage>> call({required int page, required int limit}) =>
      _repository.getMembers(page: page, limit: limit);
}

class GetMemberDetails {
  const GetMemberDetails(this._repository);
  final MemberRepository _repository;

  Future<Result<Member>> call(String id) => _repository.getMemberDetails(id);
}
