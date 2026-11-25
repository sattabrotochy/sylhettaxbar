import '../../../core/error/exceptions.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/utils/parse.dart';
import '../../../core/utils/result.dart';
import '../domain/app_info.dart';

class AppInfoRepositoryImpl implements AppInfoRepository {
  AppInfoRepositoryImpl(this._client);
  final ApiClient _client;

  @override
  Future<Result<AppInfo>> getAppInfo() => guard(() async {
        final json = await _client.post(ApiEndpoints.appInfo);
        final list = Parse.list(json['app_info']);
        if (list.isEmpty) throw const NotFoundException('No app info');
        final j = list.first;
        return AppInfo(
          name: Parse.str(j['app_name']),
          versionCode: Parse.str(j['app_version_code']),
        );
      });
}
