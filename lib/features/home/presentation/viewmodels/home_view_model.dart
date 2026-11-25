import '../../../../core/presentation/base_view_model.dart';
import '../../../notices/domain/entities/notice.dart';
import '../../../notices/domain/usecases/notice_usecases.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel(this._getNotices);

  final GetNotices _getNotices;

  static const latestCount = 3;

  List<Notice> _latest = const [];
  List<Notice> get latestNotices => _latest;

  Future<void> load() async {
    setStatus(ViewStatus.loading);
    final result = await _getNotices(limit: 10);
    result.when(
      success: (list) {
        _latest = list.take(latestCount).toList();
        setStatus(_latest.isEmpty ? ViewStatus.empty : ViewStatus.success);
      },
      failure: (f) => setStatus(ViewStatus.error, failure: f),
    );
  }
}
