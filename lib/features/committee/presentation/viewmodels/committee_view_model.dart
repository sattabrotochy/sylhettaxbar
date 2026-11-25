import '../../../../core/presentation/base_view_model.dart';
import '../../domain/entities/committee.dart';
import '../../domain/usecases/committee_usecases.dart';

class CommitteeViewModel extends BaseViewModel {
  CommitteeViewModel(this._getCommittees, this._getCommitteeMembers);

  final GetCommittees _getCommittees;
  final GetCommitteeMembers _getCommitteeMembers;

  CommitteeStatus _tab = CommitteeStatus.active;
  List<Committee> _committees = const [];
  Committee? _selected;
  List<CommitteeMember> _members = const [];
  bool _membersLoading = false;

  CommitteeStatus get tab => _tab;
  List<Committee> get committees => _committees;
  Committee? get selected => _selected;
  bool get membersLoading => _membersLoading;

  List<CommitteeMember> get leaders =>
      _members.where((m) => m.isLeader).take(2).toList();
  List<CommitteeMember> get others {
    final lead = leaders.toSet();
    return _members.where((m) => !lead.contains(m)).toList();
  }

  bool get hasMembers => _members.isNotEmpty;

  Future<void> load() => _loadTab(_tab);

  Future<void> selectTab(CommitteeStatus tab) async {
    if (tab == _tab && status != ViewStatus.error) return;
    _tab = tab;
    await _loadTab(tab);
  }

  Future<void> _loadTab(CommitteeStatus tab) async {
    _committees = const [];
    _selected = null;
    _members = const [];
    setStatus(ViewStatus.loading);
    final result = await _getCommittees(tab);
    if (tab != _tab) return; // user switched tabs meanwhile
    await result.when(
      success: (list) async {
        _committees = list;
        if (list.isEmpty) {
          setStatus(ViewStatus.empty);
          return;
        }
        setStatus(ViewStatus.success);
        await selectCommittee(list.first);
      },
      failure: (f) async => setStatus(ViewStatus.error, failure: f),
    );
  }

  Future<void> selectCommittee(Committee committee) async {
    _selected = committee;
    _members = const [];
    _membersLoading = true;
    notifyListeners();
    final result = await _getCommitteeMembers(committee.id);
    if (_selected?.id != committee.id) return;
    result.when(
      success: (list) => _members = list,
      failure: (_) => _members = const [],
    );
    _membersLoading = false;
    notifyListeners();
  }
}
