import '../../../../core/utils/result.dart';
import '../entities/staff.dart';
import '../repositories/staff_repository.dart';

class GetStaff {
  const GetStaff(this._repository);
  final StaffRepository _repository;

  Future<Result<List<Staff>>> call() => _repository.getStaff();
}
