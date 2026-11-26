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
                  const _VerifyVakalatnamaCard(),
                  const SizedBox(height: 22),
                  SectionTitle(
                    s.latestNotices,
                    trailing: TextButton(
                      onPressed: () => context.go(AppRoutes.notices),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        minimumSize: const Size(44, 44),
                      ),
                      child: Text(
                        s.seeAll,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  switch (vm.status) {
                    ViewStatus.initial ||
                    ViewStatus.loading => const StateView.loading(),
                    ViewStatus.error => StateView.error(
                      failure: vm.failure,
                      onRetry: vm.load,
                    ),
                    ViewStatus.empty => StateView.empty(
                      message: s.noNotices,
                      icon: AppIcons.notice,
                    ),
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
        20,
        MediaQuery.paddingOf(context).top + 12,
        20,
        22,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Emblem(size: 44, ringWidth: 1.5),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      s.sylhetDistrict,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.2,
                        color: AppColors.textOnNavyMuted,
                      ),
                    ),
                    Text(
                      s.associationName,
                      style: const TextStyle(
                        fontSize: 19,
                        height: 1.2,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
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
                  child: Row(
                    children: [
                      const Icon(
                        AppIcons.search,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        s.searchByName,
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
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
      (
        AppIcons.committee,
        s.committee,
        () => context.push(AppRoutes.committee),
        0,
      ),
      (AppIcons.notice, s.notices, () => context.go(AppRoutes.notices), 0),
      (AppIcons.news, s.news, () => context.go(AppRoutes.notices), 0),
      (AppIcons.staff, s.staff, () => context.push(AppRoutes.staff), 0),
      (AppIcons.gallery, s.gallery, () => context.push(AppRoutes.gallery), 0),
      (AppIcons.phone, s.contact, () => context.push(AppRoutes.contact), 0),
      (AppIcons.info, s.about, () => context.push(AppRoutes.about), 2),
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
                    border: style == 0
                        ? Border.all(color: AppColors.line)
                        : null,
                  ),
                  child: Icon(
                    icon,
                    size: 24,
                    color: switch (style) {
                      1 => Colors.white,
                      2 => AppColors.navy,
                      _ => AppColors.primary,
                    },
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// Verify a digital vakalatnama by its ID. The result comes from the
/// association's website (there is no API for it), shown in the app.
class _VerifyVakalatnamaCard extends StatefulWidget {
  const _VerifyVakalatnamaCard();

  @override
  State<_VerifyVakalatnamaCard> createState() => _VerifyVakalatnamaCardState();
}

class _VerifyVakalatnamaCardState extends State<_VerifyVakalatnamaCard> {
  final _controller = TextEditingController();
  bool _showError = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _verify() {
    final id = _controller.text.trim();
    if (id.isEmpty) {
      setState(() => _showError = true);
      return;
    }
    setState(() => _showError = false);
    FocusScope.of(context).unfocus();
    context.push(AppRoutes.vakalatnama(id));
  }

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.navy, AppColors.primary],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  AppIcons.vakalatnama,
                  color: AppColors.gold,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  s.verifyVakalatnamaTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.25,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            s.verifyVakalatnamaBody,
            style: const TextStyle(
              fontSize: 14,
              height: 1.45,
              color: AppColors.textOnNavyMuted,
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _controller,
            textInputAction: TextInputAction.search,
            onSubmitted: (_) => _verify(),
            onChanged: (_) {
              if (_showError) setState(() => _showError = false);
            },
            style: const TextStyle(fontSize: 16, color: Colors.white),
            cursorColor: AppColors.gold,
            decoration: InputDecoration(
              hintText: s.vakalatnamaId,
              hintStyle: const TextStyle(color: AppColors.textOnNavyMuted),
              errorText: _showError ? s.vakalatnamaIdRequired : null,
              errorStyle: const TextStyle(color: AppColors.gold),
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.1),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: Colors.white.withValues(alpha: 0.25),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppColors.gold, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppColors.gold),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppColors.gold, width: 1.5),
              ),
            ),
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: _verify,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.gold,
              foregroundColor: AppColors.navy,
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            child: Text(s.verifyVakalatnama),
          ),
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
              color: AppColors.line,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              AppIcons.notice,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notice.title(l),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.35,
                    fontWeight: FontWeight.w700,
                    color: AppColors.navy,
                  ),
                ),
                Text(
                  date.isEmpty ? s.notice : '${s.notice} · $date',
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.35,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
