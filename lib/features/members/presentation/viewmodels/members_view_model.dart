import 'dart:async';

import '../../../../core/config/app_config.dart';
import '../../../../core/presentation/base_view_model.dart';
import '../../domain/entities/member.dart';
import '../../domain/usecases/get_members.dart';

enum MemberFilter { all, golden, freedomFighter, retired }

class MembersViewModel extends BaseViewModel {
  MembersViewModel(this._getMembers, {String initialQuery = ''})
    : _query = initialQuery;

  final GetMembers _getMembers;

  final List<Member> _members = [];
  int _total = 0;
  int _page = 0;
  bool _loadingMore = false;
  String _query;
  MemberFilter _filter = MemberFilter.all;

  int get total => _total;
  String get query => _query;
  MemberFilter get filter => _filter;
  bool get isLoadingMore => _loadingMore;
  bool get hasMore => _members.length < _total;

  List<Member> get visibleMembers => _members.where((m) {
    final passesFilter = switch (_filter) {
      MemberFilter.all => true,
      MemberFilter.golden => m.isGolden,
      MemberFilter.freedomFighter => m.isFreedomFighter,
      MemberFilter.retired => m.isRetired,
    };
    return passesFilter && m.matches(_query);
  }).toList();

  Future<void> load() async {
    _members.clear();
    _page = 0;
    _total = 0;
    setStatus(ViewStatus.loading);
    await _fetchNext();
  }

  Future<void> refresh() => load();

  Future<void> loadMore() async {
    if (_loadingMore || !hasMore || isLoading) return;
    _loadingMore = true;
    notifyListeners();
    await _fetchNext();
    _loadingMore = false;
    notifyListeners();
  }

  /// Searching and filtering work on loaded members, so make sure the whole
  /// directory is loaded when the user narrows the list.
  Future<void> _loadAllForSearch() async {
    while (hasMore && status != ViewStatus.error) {
      await _fetchNext();
    }
  }

  void setQuery(String value) {
    _query = value;
    notifyListeners();
    if (value.trim().isNotEmpty) unawaited(_loadAllForSearch());
  }

  void setFilter(MemberFilter value) {
    _filter = value;
    notifyListeners();
    if (value != MemberFilter.all) unawaited(_loadAllForSearch());
  }

  Future<void>? _inFlight;

  /// Concurrent callers share one request, so a page is never fetched twice.
  Future<void> _fetchNext() =>
      _inFlight ??= _doFetchNext().whenComplete(() => _inFlight = null);

  Future<void> _doFetchNext() async {
    final result = await _getMembers(
      page: _page + 1,
      limit: AppConfig.membersPageSize,
    );
    result.when(
      success: (page) {
        _page++;
        _total = page.total;
        final known = _members.map((m) => m.id).toSet();
        _members.addAll(page.members.where((m) => !known.contains(m.id)));
        // Guard against the server reporting more rows than it returns.
        if (page.members.isEmpty) _total = _members.length;
        setStatus(_members.isEmpty ? ViewStatus.empty : ViewStatus.success);
      },
      failure: (f) {
        if (_members.isEmpty) {
          setStatus(ViewStatus.error, failure: f);
        } else {
          _total = _members.length; // stop paging; keep what we have
          notifyListeners();
        }
      },
    );
  }
}
