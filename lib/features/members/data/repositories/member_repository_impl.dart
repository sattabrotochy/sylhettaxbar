import '../../../../core/utils/result.dart';
import '../../domain/entities/member.dart';
import '../../domain/repositories/member_repository.dart';
import '../datasources/member_remote_data_source.dart';

class MemberRepositoryImpl implements MemberRepository {
  MemberRepositoryImpl(this._remote);
  final MemberRemoteDataSource _remote;

  // Details are cached so list → profile → back doesn't refetch.
  final Map<String, Member> _cache = {};

  @override
  Future<Result<MembersPage>> getMembers({
    required int page,
    required int limit,
  }) => guard(() async {
    final result = await _remote.getMembers(page: page, limit: limit);
    for (final m in result.members) {
      _cache[m.id] = m;
    }
    return result;
  });

  @override
  Future<Result<Member>> getMemberDetails(String id) async {
    final cached = _cache[id];
    if (cached != null) return Success(cached);
    return guard(() async {
      final member = await _remote.getMemberDetails(id);
      _cache[id] = member;
      return member;
    });
  }
}
