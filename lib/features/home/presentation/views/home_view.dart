import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/presentation/base_view_model.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/widgets/app_icons.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../notices/domain/entities/notice.dart';
import '../viewmodels/home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    final s = context.strings;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: RefreshIndicator(
        onRefresh: vm.load,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const _Header(),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SectionTitle(s.quickAccess),
                  const SizedBox(height: 12),
                  const _QuickAccessGrid(),
                  const SizedBox(height: 22),
                  _ElectionBanner(onTap: () => context.push(AppRoutes.election)),
                  const SizedBox(height: 22),
                  SectionTitle(
                    s.latestNotices,
                    trailing: TextButton(
                      onPressed: () => context.go(AppRoutes.notices),
                      style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          minimumSize: const Size(44, 44)),
                      child: Text(s.seeAll,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700)),
                    ),
                  ),
                  const SizedBox(height: 4),
                  switch (vm.status) {
                    ViewStatus.initial || ViewStatus.loading =>
                      const StateView.loading(),
                    ViewStatus.error =>
                      StateView.error(failure: vm.failure, onRetry: vm.load),
                    ViewStatus.empty =>
                      StateView.empty(message: s.noNotices, icon: AppIcons.notice),
                    ViewStatus.success => Column(
                        children: [
                          for (final n in vm.latestNotices) ...[
                            _LatestNoticeTile(notice: n),
                            const SizedBox(height: 10),
                          ],
                        ],
                      ),
                  },
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.navy,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      padding: EdgeInsets.fromLTRB(
          20, MediaQuery.paddingOf(context).top + 12, 20, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.gold, width: 1.5),
                ),
                child: const Icon(AppIcons.scales, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s.sylhetDistrict,
                        style: const TextStyle(
                            fontSize: 13,
                            height: 1.2,
                            color: AppColors.textOnNavyMuted)),
                    Text(s.associationName,
                        style: const TextStyle(
                            fontSize: 19,
                            height: 1.2,
                            fontWeight: FontWeight.w800,
                            color: Colors.white)),
                  ],
                ),
              ),
              HeaderIconButton(
                icon: AppIcons.bell,
                tooltip: s.notices,
                onDark: true,
                badge: true,
                onPressed: () => context.go(AppRoutes.notices),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () => context.go(AppRoutes.members),
              child: SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(children: [
                    const Icon(AppIcons.search, color: AppColors.primary, size: 20),
                    const SizedBox(width: 10),
                    Text(s.searchByName,
                        style: const TextStyle(
                            fontSize: 15, color: AppColors.textMuted)),
                  ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickAccessGrid extends StatelessWidget {
  const _QuickAccessGrid();

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    // (icon, label, action, style) — style: 0 white, 1 blue, 2 gold
    final items = <(IconData, String, VoidCallback, int)>[
      (AppIcons.members, s.members, () => context.go(AppRoutes.members), 1),
      (AppIcons.committee, s.committee, () => context.push(AppRoutes.committee), 0),
      (AppIcons.notice, s.notices, () => context.go(AppRoutes.notices), 0),
      (AppIcons.news, s.news, () => context.go(AppRoutes.notices), 0),
      (AppIcons.election, s.election, () => context.push(AppRoutes.election), 2),
      (AppIcons.staff, s.staff, () => context.push(AppRoutes.staff), 0),
      (AppIcons.gallery, s.gallery, () => context.push(AppRoutes.gallery), 0),
      (AppIcons.phone, s.contact, () => context.push(AppRoutes.contact), 0),
    ];

    return GridView.count(
      crossAxisCount: 4,
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 14,
      crossAxisSpacing: 8,
      childAspectRatio: 0.82,
      children: [
        for (final (icon, label, onTap, style) in items)
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: switch (style) {
                      1 => AppColors.primary,
                      2 => AppColors.gold,
                      _ => AppColors.surface,
                    },
                    borderRadius: BorderRadius.circular(18),
                    border: style == 0 ? Border.all(color: AppColors.line) : null,
                  ),
                  child: Icon(icon,
                      size: 24,
                      color: switch (style) {
                        1 => Colors.white,
                        2 => AppColors.navy,
                        _ => AppColors.primary,
                      }),
                ),
                const SizedBox(height: 6),
                Text(label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text)),
              ],
            ),
          ),
      ],
    );
  }
}

class _ElectionBanner extends StatelessWidget {
  const _ElectionBanner({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    return AppCard(
      color: AppColors.primary,
      radius: 20,
      bordered: false,
      padding: const EdgeInsets.all(16),
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14)),
            child: const Icon(AppIcons.election, color: AppColors.gold, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s.electionBannerLabel,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.gold)),
                Text(s.readCecMessage,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
              ],
            ),
          ),
          const Icon(AppIcons.chevronRight, color: Colors.white),
        ],
      ),
    );
  }
}

class _LatestNoticeTile extends StatelessWidget {
  const _LatestNoticeTile({required this.notice});
  final Notice notice;

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    final l = context.lang;
    final date = DateFmt.full(notice.date, l);
    return AppCard(
      onTap: () => context.push(AppRoutes.notice(notice.id)),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
                color: AppColors.line, borderRadius: BorderRadius.circular(12)),
            child: const Icon(AppIcons.notice, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notice.title(l),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 15,
                        height: 1.35,
                        fontWeight: FontWeight.w700,
                        color: AppColors.navy)),
                Text(date.isEmpty ? s.notice : '${s.notice} · $date',
                    style: const TextStyle(
                        fontSize: 13, height: 1.35, color: AppColors.textMuted)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
