import '../../../../core/utils/result.dart';
import '../entities/notice.dart';

abstract interface class NoticeRepository {
  Future<Result<List<Notice>>> getNotices({int limit});
  Future<Result<Notice>> getNoticeDetails(String id);
}
