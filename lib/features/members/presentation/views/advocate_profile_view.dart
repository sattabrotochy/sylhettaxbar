import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/localization/app_language.dart';
import '../../../../core/localization/app_strings.dart';
import '../../../../core/presentation/base_view_model.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/utils/launcher.dart';
import '../../../../core/widgets/app_icons.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../domain/entities/member.dart';
import '../viewmodels/member_profile_view_model.dart';

class AdvocateProfileView extends StatelessWidget {
  const AdvocateProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MemberProfileViewModel>();
    final s = context.strings;
    final member = vm.member;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: 210 + MediaQuery.paddingOf(context).top,
              color: AppColors.navy,
            ),
            Positioned(
              top: -120,
              right: -120,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                ),
              ),
            ),
            SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                    child: Row(
                      children: [
                        HeaderIconButton(
                          icon: AppIcons.back,
                          onDark: true,
                          tooltip:
                              MaterialLocalizations.of(context).backButtonTooltip,
                          onPressed: () => context.canPop()
                              ? context.pop()
                              : context.go(AppRoutes.members),
                        ),
                        Expanded(
                          child: Text(s.advocateProfile,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                        ),
                        HeaderIconButton(
                          icon: AppIcons.share,
                          onDark: true,
                          tooltip: s.share,
                          onPressed: member == null
                              ? () {}
                              : () => _share(member, s),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: switch (vm.status) {
                      ViewStatus.initial ||
                      ViewStatus.loading ||
                      ViewStatus.empty =>
                        const Center(
                            child:
                                CircularProgressIndicator(color: Colors.white)),
                      ViewStatus.error => Container(
                          margin: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24)),
                          child: StateView.error(
                              failure: vm.failure, onRetry: vm.load),
                        ),
                      ViewStatus.success => _ProfileBody(member: member!),
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _share(Member m, AppStrings s) {
    final lines = [
      m.nameEn,
      if (m.memberNo.isNotEmpty) s.memberNo(m.memberNo),
      if (m.phone.isNotEmpty) '${s.phone}: ${m.phone}',
      if (m.email.isNotEmpty) '${s.email}: ${m.email}',
      s.associationName,
    ];
    SharePlus.instance.share(ShareParams(text: lines.join('\n')));
  }
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody({required this.member});
  final Member member;

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    final l = context.lang;
    final rows = _detailRows(member, s, l);

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 64, 20, 24),
      children: [
        // Identity card with the overlapping photo.
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 0),
              padding: const EdgeInsets.fromLTRB(20, 68, 20, 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0x14001B4D),
                      blurRadius: 30,
                      offset: Offset(0, 10)),
                ],
              ),
              child: Column(
                children: [
                  Text(member.name(l),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: AppColors.navy)),
                  Text(
                    DateFmt.digits(
                        member.memberNo.isEmpty
                            ? s.advocate
                            : '${s.advocate} · ${s.memberNo(member.memberNo)}',
                        l),
                    textAlign: TextAlign.center,
                    style:
                        const TextStyle(fontSize: 15, color: AppColors.textMuted),
                  ),
                  if (member.isGolden ||
                      member.isFreedomFighter ||
                      member.isRetired) ...[
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      alignment: WrapAlignment.center,
                      children: [
                        if (member.isGolden)
                          TagBadge(label: s.goldenMember, fontSize: 13),
                        if (member.isFreedomFighter)
                          TagBadge(
                              label: s.freedomFighter,
                              background: AppColors.line,
                              foreground: AppColors.primary,
                              fontSize: 13),
                        if (member.isRetired)
                          TagBadge(
                              label: s.retired,
                              background: AppColors.background,
                              foreground: AppColors.textMuted,
                              fontSize: 13),
                      ],
                    ),
                  ],
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _ActionButton(
                          icon: AppIcons.phone,
                          label: s.call,
                          primary: true,
                          onPressed: member.phone.isEmpty
                              ? null
                              : () => Launcher.call(
                                  context, member.phone, s.couldNotOpen),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _ActionButton(
                          icon: AppIcons.email,
                          label: s.email,
                          onPressed: member.email.isEmpty
                              ? null
                              : () => Launcher.email(
                                  context, member.email, s.couldNotOpen),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: -52,
              child: Container(
                width: 104,
                height: 104,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.gold, width: 3),
                ),
                child: Avatar(
                    url: member.imageUrl.isNotEmpty
                        ? member.imageUrl
                        : member.thumbUrl,
                    size: 92),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 4),
                child: Text(s.details,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.navy)),
              ),
              for (final (icon, label, value) in rows)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: AppColors.line))),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(10)),
                        child: Icon(icon, size: 18, color: AppColors.primary),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(label,
                                style: const TextStyle(
                                    fontSize: 13,
                                    height: 1.3,
                                    color: AppColors.textMuted)),
                            SelectableText(value,
                                style: const TextStyle(
                                    fontSize: 15,
                                    height: 1.3,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.text)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  static List<(IconData, String, String)> _detailRows(
      Member m, AppStrings s, AppLanguage l) {
    String or(String v) => v.isEmpty ? s.notAvailable : v;
    return [
      (AppIcons.calendar, s.memberSince, or(DateFmt.year(m.memberSince, l))),
      (AppIcons.phone, s.phone, or(m.phone)),
      (AppIcons.email, s.email, or(m.email)),
      (AppIcons.location, s.chamber, or(m.chamber(l))),
      if (m.sanadNo.isNotEmpty) (AppIcons.badge, s.sanadNo, m.sanadNo),
      if (m.bloodGroup.isNotEmpty) (AppIcons.blood, s.bloodGroup, m.bloodGroup),
      if (m.fatherName(l).isNotEmpty)
        (AppIcons.person, s.fatherName, m.fatherName(l)),
      if (m.address(l).isNotEmpty) (AppIcons.location, s.address, m.address(l)),
    ];
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.primary = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        backgroundColor: primary ? AppColors.primary : AppColors.line,
        foregroundColor: primary ? Colors.white : AppColors.primary,
        disabledBackgroundColor: AppColors.background,
        disabledForegroundColor: AppColors.textMuted,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
