import 'package:flutter/material.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/launcher.dart';
import '../../../../core/widgets/app_icons.dart';
import '../../../../core/widgets/common_widgets.dart';

class PrivacyView extends StatefulWidget {
  const PrivacyView({super.key});

  @override
  State<PrivacyView> createState() => _PrivacyViewState();
}

class _PrivacyViewState extends State<PrivacyView> {
  int _open = 0;

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    final sections = s.privacySections;

    return Scaffold(
      body: Column(
        children: [
          BackHeader(title: s.privacyPolicy),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: AppColors.navy,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12)),
                      child: const Icon(AppIcons.shield, color: AppColors.gold),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(s.privacyHeader,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)),
                    ),
                  ]),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      for (final (i, (title, body)) in sections.indexed)
                        Container(
                          decoration: BoxDecoration(
                            border: i < sections.length - 1
                                ? const Border(
                                    bottom: BorderSide(color: AppColors.line))
                                : null,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Semantics(
                                expanded: _open == i,
                                button: true,
                                child: InkWell(
                                  onTap: () =>
                                      setState(() => _open = _open == i ? -1 : i),
                                  child: SizedBox(
                                    height: 52,
                                    child: Row(children: [
                                      Container(
                                        width: 26,
                                        height: 26,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: AppColors.line,
                                            borderRadius: BorderRadius.circular(8)),
                                        child: Text('${i + 1}',
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w800,
                                                color: AppColors.primary)),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(title,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.navy)),
                                      ),
                                      AnimatedRotation(
                                        turns: _open == i ? 0.5 : 0,
                                        duration: const Duration(milliseconds: 180),
                                        child: const Icon(AppIcons.chevronDown,
                                            color: AppColors.textMuted),
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                              if (_open == i)
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(36, 0, 0, 14),
                                  child: Text(body,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          height: 1.55,
                                          color: AppColors.textMuted)),
                                ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(s.privacyQuestions,
                        style: const TextStyle(
                            fontSize: 13, color: AppColors.textMuted)),
                    InkWell(
                      onTap: () => Launcher.email(
                          context, AppConfig.officeEmail, s.couldNotOpen),
                      child: const Text(AppConfig.officeEmail,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
