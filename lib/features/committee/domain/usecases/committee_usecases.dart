import '../../../../core/utils/result.dart';
import '../entities/committee.dart';
import '../repositories/committee_repository.dart';

class GetCommittees {
  const GetCommittees(this._repository);
  final CommitteeRepository _repository;

  Future<Result<List<Committee>>> call(CommitteeStatus status) =>
      _repository.getCommittees(status);
}

class GetCommitteeMembers {
  const GetCommitteeMembers(this._repository);
  final CommitteeRepository _repository;

  Future<Result<List<CommitteeMember>>> call(String committeeId) =>
      _repository.getCommitteeMembers(committeeId);
}
