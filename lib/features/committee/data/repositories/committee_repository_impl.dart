import '../../../../core/utils/result.dart';
import '../../domain/entities/committee.dart';
import '../../domain/repositories/committee_repository.dart';
import '../datasources/committee_remote_data_source.dart';

class CommitteeRepositoryImpl implements CommitteeRepository {
  CommitteeRepositoryImpl(this._remote);
  final CommitteeRemoteDataSource _remote;

  @override
  Future<Result<List<Committee>>> getCommittees(CommitteeStatus status) =>
      guard(() async {
        final list = await _remote.getCommittees(status);
        // Newest term first.
        list.sort((a, b) {
          final da = a.startDate, db = b.startDate;
          if (da == null || db == null) return 0;
          return db.compareTo(da);
        });
        return list;
      });

  @override
  Future<Result<List<CommitteeMember>>> getCommitteeMembers(
    String committeeId,
  ) => guard(() async {
    final list = await _remote.getCommitteeMembers(committeeId);
    list.sort((a, b) => a.priority.compareTo(b.priority));
    return list;
  });
}
