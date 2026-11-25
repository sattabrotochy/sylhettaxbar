import '../../../../core/presentation/base_view_model.dart';
import '../../domain/entities/staff.dart';
import '../../domain/usecases/get_staff.dart';

class StaffViewModel extends BaseViewModel {
  StaffViewModel(this._getStaff);

  final GetStaff _getStaff;

  List<Staff> _staff = const [];
  List<Staff> get staff => _staff;

  Future<void> load() async {
    setStatus(ViewStatus.loading);
    final result = await _getStaff();
    result.when(
      success: (list) {
        _staff = list;
        setStatus(list.isEmpty ? ViewStatus.empty : ViewStatus.success);
      },
      failure: (f) => setStatus(ViewStatus.error, failure: f),
    );
  }
}
