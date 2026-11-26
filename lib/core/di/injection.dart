import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/app_info/data/app_info_repository_impl.dart';
import '../../features/app_info/domain/app_info.dart';
import '../../features/committee/data/datasources/committee_remote_data_source.dart';
import '../../features/committee/data/repositories/committee_repository_impl.dart';
import '../../features/committee/domain/repositories/committee_repository.dart';
import '../../features/committee/domain/usecases/committee_usecases.dart';
import '../../features/members/data/datasources/member_remote_data_source.dart';
import '../../features/members/data/repositories/member_repository_impl.dart';
import '../../features/members/domain/repositories/member_repository.dart';
import '../../features/members/domain/usecases/get_members.dart';
import '../../features/notices/data/datasources/notice_remote_data_source.dart';
import '../../features/notices/data/repositories/notice_repository_impl.dart';
import '../../features/notices/domain/repositories/notice_repository.dart';
import '../../features/notices/domain/usecases/notice_usecases.dart';
import '../../features/settings/data/datasources/settings_local_data_source.dart';
import '../../features/settings/data/repositories/settings_repository_impl.dart';
import '../../features/settings/domain/repositories/settings_repository.dart';
import '../../features/staff/data/datasources/staff_remote_data_source.dart';
import '../../features/staff/data/repositories/staff_repository_impl.dart';
import '../../features/staff/domain/repositories/staff_repository.dart';
import '../../features/staff/domain/usecases/get_staff.dart';
import '../network/api_client.dart';

final sl = GetIt.instance;

/// Registers data sources, repositories and use cases.
/// View models are created per screen with `ChangeNotifierProvider`.
Future<void> configureDependencies() async {
  // External
  final prefs = await SharedPreferences.getInstance();
  sl
    ..registerSingleton<SharedPreferences>(prefs)
    ..registerLazySingleton<ApiClient>(ApiClient.new)
    // Settings
    ..registerLazySingleton<SettingsLocalDataSource>(
      () => SettingsLocalDataSourceImpl(sl()),
    )
    ..registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(sl()),
    )
    // Members
    ..registerLazySingleton<MemberRemoteDataSource>(
      () => MemberRemoteDataSourceImpl(sl()),
    )
    ..registerLazySingleton<MemberRepository>(() => MemberRepositoryImpl(sl()))
    ..registerFactory(() => GetMembers(sl()))
    ..registerFactory(() => GetMemberDetails(sl()))
    // Notices
    ..registerLazySingleton<NoticeRemoteDataSource>(
      () => NoticeRemoteDataSourceImpl(sl()),
    )
    ..registerLazySingleton<NoticeRepository>(() => NoticeRepositoryImpl(sl()))
    ..registerFactory(() => GetNotices(sl()))
    ..registerFactory(() => GetNoticeDetails(sl()))
    // Committee
    ..registerLazySingleton<CommitteeRemoteDataSource>(
      () => CommitteeRemoteDataSourceImpl(sl()),
    )
    ..registerLazySingleton<CommitteeRepository>(
      () => CommitteeRepositoryImpl(sl()),
    )
    ..registerFactory(() => GetCommittees(sl()))
    ..registerFactory(() => GetCommitteeMembers(sl()))
    // Staff
    ..registerLazySingleton<StaffRemoteDataSource>(
      () => StaffRemoteDataSourceImpl(sl()),
    )
    ..registerLazySingleton<StaffRepository>(() => StaffRepositoryImpl(sl()))
    ..registerFactory(() => GetStaff(sl()))
    // App info
    ..registerLazySingleton<AppInfoRepository>(
      () => AppInfoRepositoryImpl(sl()),
    )
    ..registerFactory(() => GetAppInfo(sl()));
}
