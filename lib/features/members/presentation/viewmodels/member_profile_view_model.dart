import '../../../../core/presentation/base_view_model.dart';
import '../../domain/entities/member.dart';
import '../../domain/usecases/get_members.dart';

class MemberProfileViewModel extends BaseViewModel {
  MemberProfileViewModel(this._getMemberDetails, this.memberId);

  final GetMemberDetails _getMemberDetails;
  final String memberId;

  Member? _member;
  Member? get member => _member;

  Future<void> load() async {
    setStatus(ViewStatus.loading);
    final result = await _getMemberDetails(memberId);
    result.when(
      success: (m) {
        _member = m;
        setStatus(ViewStatus.success);
      },
      failure: (f) => setStatus(ViewStatus.error, failure: f),
    );
  }
}
