import '../../../../core/utils/result.dart';
import '../../domain/entities/notice.dart';
import '../../domain/repositories/notice_repository.dart';
import '../datasources/notice_remote_data_source.dart';

class NoticeRepositoryImpl implements NoticeRepository {
  NoticeRepositoryImpl(this._remote);
  final NoticeRemoteDataSource _remote;

  @override
  Future<Result<List<Notice>>> getNotices({int limit = 50}) => guard(() async {
    final list = await _remote.getNotices(limit);
    list.sort((a, b) {
      final da = a.date, db = b.date;
      if (da == null && db == null) return 0;
      if (da == null) return 1;
      if (db == null) return -1;
      return db.compareTo(da);
    });
    return list;
  });

  @override
  Future<Result<Notice>> getNoticeDetails(String id) =>
      guard(() => _remote.getNoticeDetails(id));
}
