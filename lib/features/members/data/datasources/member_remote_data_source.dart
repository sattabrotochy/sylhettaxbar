import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/utils/parse.dart';
import '../../domain/entities/member.dart';
import '../models/member_model.dart';

abstract interface class MemberRemoteDataSource {
  Future<MembersPage> getMembers({required int page, required int limit});
  Future<Member> getMemberDetails(String id);
}

class MemberRemoteDataSourceImpl implements MemberRemoteDataSource {
  MemberRemoteDataSourceImpl(this._client);
  final ApiClient _client;

  @override
  Future<MembersPage> getMembers({
    required int page,
    required int limit,
  }) async {
    final json = await _client.post(ApiEndpoints.members(page, limit));
    final members = Parse.list(json['result'])
        .map(MemberModel.fromJson)
        .toList();
    return MembersPage(
      members: members,
      total: Parse.integer(json['total_row'], members.length),
    );
  }

  @override
  Future<Member> getMemberDetails(String id) async {
    final json = await _client.post(ApiEndpoints.memberDetails(id));
    final list = Parse.list(json['members']);
    if (list.isEmpty) throw const NotFoundException('Member not found');
    return MemberModel.fromJson(list.first);
  }
}
