import '../../../../core/utils/result.dart';
import '../entities/staff.dart';

abstract interface class StaffRepository {
  Future<Result<List<Staff>>> getStaff();
}
