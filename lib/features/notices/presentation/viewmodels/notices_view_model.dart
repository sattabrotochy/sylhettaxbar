import '../../../../core/presentation/base_view_model.dart';
import '../../domain/entities/notice.dart';
import '../../domain/usecases/notice_usecases.dart';

class NoticesViewModel extends BaseViewModel {
  NoticesViewModel(this._getNotices);

  final GetNotices _getNotices;

  List<Notice> _all = const [];
  NoticeType _tab = NoticeType.notice;

  NoticeType get tab => _tab;
  List<Notice> get items => _all.where((n) => n.type == _tab).toList();

  void selectTab(NoticeType tab) {
    _tab = tab;
    notifyListeners();
  }

  Future<void> load() async {
    setStatus(ViewStatus.loading);
    final result = await _getNotices(limit: 100);
    result.when(
      success: (list) {
        _all = list;
        setStatus(list.isEmpty ? ViewStatus.empty : ViewStatus.success);
      },
      failure: (f) => setStatus(ViewStatus.error, failure: f),
    );
  }
}

class NoticeDetailViewModel extends BaseViewModel {
  NoticeDetailViewModel(this._getNoticeDetails, this.noticeId);

  final GetNoticeDetails _getNoticeDetails;
  final String noticeId;

  Notice? _notice;
  Notice? get notice => _notice;

  Future<void> load() async {
    setStatus(ViewStatus.loading);
    final result = await _getNoticeDetails(noticeId);
    result.when(
      success: (n) {
        _notice = n;
        setStatus(ViewStatus.success);
      },
      failure: (f) => setStatus(ViewStatus.error, failure: f),
    );
  }
}
