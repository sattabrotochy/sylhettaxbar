import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/utils/parse.dart';
import '../../domain/entities/notice.dart';
import '../models/notice_model.dart';

abstract interface class NoticeRemoteDataSource {
  Future<List<Notice>> getNotices(int limit);
  Future<Notice> getNoticeDetails(String id);
}

class NoticeRemoteDataSourceImpl implements NoticeRemoteDataSource {
  NoticeRemoteDataSourceImpl(this._client);
  final ApiClient _client;

  @override
  Future<List<Notice>> getNotices(int limit) async {
    final json = await _client.post(ApiEndpoints.notices(limit));
    return Parse.list(json['result']).map(NoticeModel.fromJson).toList();
  }

  @override
  Future<Notice> getNoticeDetails(String id) async {
    final json = await _client.post(ApiEndpoints.noticeDetails(id));
    final list = Parse.list(json['notice_details']);
    if (list.isEmpty) throw const NotFoundException('Notice not found');
    return NoticeModel.fromJson(list.first);
  }
}
