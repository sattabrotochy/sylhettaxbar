import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/launcher.dart';
import '../../../../core/widgets/app_icons.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../app_info/presentation/app_info_view_model.dart';

class MoreView extends StatelessWidget {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    final version = context.watch<AppInfoViewModel>().info?.versionCode;

    void comingSoon() => ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(s.comingSoon)));

    final groups = <(String, List<(IconData, String, VoidCallback)>)>[
      (s.groupAbout, [
        (AppIcons.info, s.aboutUs, () => context.push(AppRoutes.about)),
        (AppIcons.history, s.history, comingSoon),
        (AppIcons.book, s.constitution, comingSoon),
      ]),
      (s.groupPeople, [
        (AppIcons.committee, s.committee, () => context.push(AppRoutes.committee)),
        (AppIcons.election, s.election, () => context.push(AppRoutes.election)),
        (AppIcons.staff, s.staff, () => context.push(AppRoutes.staff)),
      ]),
      (s.groupMore, [
        (AppIcons.gallery, s.gallery, () => context.push(AppRoutes.gallery)),
        (AppIcons.phone, s.contactUs, () => context.push(AppRoutes.contact)),
        (AppIcons.shield, s.privacyPolicy, () => context.push(AppRoutes.privacy)),
        (
          AppIcons.link,
          s.sylhetDistrictBar,
          () => Launcher.web(context, AppConfig.districtBarUrl, s.couldNotOpen)
        ),
      ]),
    ];

    return Column(
      children: [
        TitleHeader(title: s.more, trailing: const LanguageToggle()),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            children: [
              for (final (title, rows) in groups) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 0, 4, 6),
                  child: Eyebrow(title),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18)),
                  child: Column(
                    children: [
                      for (final (i, (icon, label, onTap)) in rows.indexed)
                        MenuRow(
                          icon: icon,
                          label: label,
                          onTap: onTap,
                          divider: i < rows.length - 1,
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
              ],
              if (version != null && version.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(s.appVersion(version),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 13, color: AppColors.textMuted)),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class MenuRow extends StatelessWidget {
  const MenuRow({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.divider = true,
  });

  final IconData? icon;
  final String label;
  final VoidCallback onTap;
  final bool divider;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 52),
        decoration: BoxDecoration(
          border: divider
              ? const Border(bottom: BorderSide(color: AppColors.line))
              : null,
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                    color: AppColors.line, borderRadius: BorderRadius.circular(10)),
                child: Icon(icon, size: 18, color: AppColors.primary),
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Text(label,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.navy)),
            ),
            const Icon(AppIcons.chevronRight, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}
