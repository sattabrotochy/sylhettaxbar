import '../../../../core/utils/result.dart';
import '../../domain/entities/staff.dart';
import '../../domain/repositories/staff_repository.dart';
import '../datasources/staff_remote_data_source.dart';

class StaffRepositoryImpl implements StaffRepository {
  StaffRepositoryImpl(this._remote);
  final StaffRemoteDataSource _remote;

  @override
  Future<Result<List<Staff>>> getStaff() => guard(() async {
    final list = await _remote.getStaff();
    list.sort((a, b) => a.position.compareTo(b.position));
    return list;
  });
}
