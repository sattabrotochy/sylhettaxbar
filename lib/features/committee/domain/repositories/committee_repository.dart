import '../../../../core/utils/result.dart';
import '../entities/committee.dart';

abstract interface class CommitteeRepository {
  Future<Result<List<Committee>>> getCommittees(CommitteeStatus status);
  Future<Result<List<CommitteeMember>>> getCommitteeMembers(String committeeId);
}
