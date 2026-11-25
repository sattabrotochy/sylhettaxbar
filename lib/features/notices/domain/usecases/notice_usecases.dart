import '../../../../core/utils/result.dart';
import '../entities/notice.dart';
import '../repositories/notice_repository.dart';

class GetNotices {
  const GetNotices(this._repository);
  final NoticeRepository _repository;

  Future<Result<List<Notice>>> call({int limit = 50}) =>
      _repository.getNotices(limit: limit);
}

class GetNoticeDetails {
  const GetNoticeDetails(this._repository);
  final NoticeRepository _repository;

  Future<Result<Notice>> call(String id) => _repository.getNoticeDetails(id);
}
