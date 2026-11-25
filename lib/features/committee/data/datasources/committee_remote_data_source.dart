import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/utils/parse.dart';
import '../../domain/entities/committee.dart';
import '../models/committee_model.dart';

abstract interface class CommitteeRemoteDataSource {
  Future<List<Committee>> getCommittees(CommitteeStatus status);
  Future<List<CommitteeMember>> getCommitteeMembers(String committeeId);
}

class CommitteeRemoteDataSourceImpl implements CommitteeRemoteDataSource {
  CommitteeRemoteDataSourceImpl(this._client);
  final ApiClient _client;

  @override
  Future<List<Committee>> getCommittees(CommitteeStatus status) async {
    final json = await _client.post(ApiEndpoints.committees(status.apiValue));
    return Parse.list(json[status.responseKey])
        .map(CommitteeModel.fromJson)
        .toList();
  }

  @override
  Future<List<CommitteeMember>> getCommitteeMembers(String committeeId) async {
    final json = await _client.post(ApiEndpoints.committeeMembers(committeeId));
    return Parse.list(json['result'])
        .map(CommitteeMemberModel.fromJson)
        .toList();
  }
}
