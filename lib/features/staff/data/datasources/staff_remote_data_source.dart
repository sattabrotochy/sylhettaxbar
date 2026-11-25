import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/utils/parse.dart';
import '../../domain/entities/staff.dart';
import '../models/staff_model.dart';

abstract interface class StaffRemoteDataSource {
  Future<List<Staff>> getStaff();
}

class StaffRemoteDataSourceImpl implements StaffRemoteDataSource {
  StaffRemoteDataSourceImpl(this._client);
  final ApiClient _client;

  @override
  Future<List<Staff>> getStaff() async {
    final json = await _client.post(ApiEndpoints.staffList);
    // `staff_members` is a list, or `false` when there is nothing.
    return Parse.list(json['staff_members']).map(StaffModel.fromJson).toList();
  }
}
