import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../features/app_info/presentation/app_info_view_model.dart';
import '../../features/committee/presentation/viewmodels/committee_view_model.dart';
import '../../features/committee/presentation/views/committee_view.dart';
import '../../features/home/presentation/viewmodels/home_view_model.dart';
import '../../features/home/presentation/views/home_view.dart';
import '../../features/info/presentation/views/about_view.dart';
import '../../features/info/presentation/views/contact_view.dart';
import '../../features/info/presentation/views/web_page_view.dart';
import '../config/app_config.dart';
import '../../features/info/presentation/views/more_view.dart';
import '../../features/info/presentation/views/privacy_view.dart';
import '../../features/info/presentation/views/text_page_view.dart';
import '../widgets/app_icons.dart';
import '../widgets/common_widgets.dart';
import '../../features/members/presentation/viewmodels/member_profile_view_model.dart';
import '../../features/members/presentation/viewmodels/members_view_model.dart';
import '../../features/members/presentation/views/advocate_profile_view.dart';
import '../../features/members/presentation/views/members_view.dart';
import '../../features/notices/presentation/viewmodels/notices_view_model.dart';
import '../../features/notices/presentation/views/notice_detail_view.dart';
import '../../features/notices/presentation/views/notices_view.dart';
import '../../features/onboarding/presentation/views/onboarding_view.dart';
import '../../features/onboarding/presentation/views/splash_view.dart';
import '../../features/staff/presentation/viewmodels/staff_view_model.dart';
import '../../features/staff/presentation/views/staff_view.dart';
import '../di/injection.dart';
import '../widgets/main_shell.dart';
import 'app_routes.dart';

/// Wraps a screen in its own view model, which loads once on creation.
Widget _withVm<T extends ChangeNotifier>(
  T Function() create,
  Widget child, {
  required Future<void> Function(T vm) load,
}) {
  return ChangeNotifierProvider<T>(
    create: (_) {
      final vm = create();
      load(vm);
      return vm;
    },
    child: child,
  );
}

GoRouter buildRouter() {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(path: AppRoutes.splash, builder: (_, _) => const SplashView()),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (_, _) => const OnboardingView(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (_, _, shell) => MainShell(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (_, _) => _withVm(
                  () => HomeViewModel(sl()),
                  const HomeView(),
                  load: (vm) => vm.load(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.members,
                builder: (_, state) => _withVm(
                  () => MembersViewModel(
                    sl(),
                    initialQuery: state.uri.queryParameters['q'] ?? '',
                  ),
                  const MembersView(),
                  load: (vm) => vm.load(),
                ),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (_, state) => _withVm(
                      () => MemberProfileViewModel(
                        sl(),
                        state.pathParameters['id']!,
                      ),
                      const AdvocateProfileView(),
                      load: (vm) => vm.load(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.notices,
                builder: (_, _) => _withVm(
                  () => NoticesViewModel(sl()),
                  const NoticesView(),
                  load: (vm) => vm.load(),
                ),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (_, state) => _withVm(
                      () => NoticeDetailViewModel(
                        sl(),
                        state.pathParameters['id']!,
                      ),
                      const NoticeDetailView(),
                      load: (vm) => vm.load(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.more,
                builder: (_, _) => _withVm(
                  () => AppInfoViewModel(sl()),
                  const MoreView(),
                  load: (vm) => vm.load(),
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.committee,
        builder: (_, _) => _withVm(
          () => CommitteeViewModel(sl(), sl()),
          const CommitteeView(),
          load: (vm) => vm.load(),
        ),
      ),
      GoRoute(
        path: AppRoutes.staff,
        builder: (_, _) => _withVm(
          () => StaffViewModel(sl()),
          const StaffView(),
          load: (vm) => vm.load(),
        ),
      ),
      GoRoute(
        path: AppRoutes.gallery,
        builder: (context, _) => WebPageView(
          title: context.strings.gallery,
          buildUrl: AppConfig.galleryUrl,
        ),
      ),
      GoRoute(
        path: AppRoutes.verifyVakalatnama,
        builder: (context, state) {
          final id = state.uri.queryParameters['id'] ?? '';
          return WebPageView(
            title: context.strings.vakalatnamaVerification,
            buildUrl: (lang) => AppConfig.vakalatnamaVerifyUrl(lang, id),
          );
        },
      ),
      GoRoute(path: AppRoutes.about, builder: (_, _) => const AboutView()),
      GoRoute(
        path: AppRoutes.history,
        builder: (context, _) {
          final s = context.strings;
          return TextPageView(
            title: s.history,
            heading: s.historyHeading,
            icon: AppIcons.history,
            paragraphs: s.historyBody,
            note: s.historyNote,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.constitution,
        builder: (context, _) {
          final s = context.strings;
          return TextPageView(
            title: s.constitution,
            heading: s.constitutionHeading,
            icon: AppIcons.book,
            paragraphs: s.constitutionBody,
          );
        },
      ),
      GoRoute(path: AppRoutes.contact, builder: (_, _) => const ContactView()),
      GoRoute(path: AppRoutes.privacy, builder: (_, _) => const PrivacyView()),
    ],
  );
}
