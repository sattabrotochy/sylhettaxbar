import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_icons.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../settings/presentation/viewmodels/settings_view_model.dart';
import '../widgets/onboarding_illustrations.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final _controller = PageController();
  int _index = 0;

  static const _count = 3;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    await context.read<SettingsViewModel>().completeOnboarding();
    if (mounted) context.go(AppRoutes.home);
  }

  void _next() {
    if (_index == _count - 1) {
      _finish();
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    final pages = [
      (const DirectoryIllustration(), s.onb1Title, s.onb1Body),
      (const NoticesIllustration(), s.onb2Title, s.onb2Body),
      (const FormsIllustration(), s.onb3Title, s.onb3Body),
    ];
    final isLast = _index == _count - 1;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 20, 0),
              child: SizedBox(
                height: 48,
                child: Row(
                  children: [
                    const LanguageToggle(),
                    const Spacer(),
                    if (!isLast)
                      TextButton(
                        onPressed: _finish,
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          minimumSize: const Size(44, 44),
                        ),
                        child: Text(
                          s.skip,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _count,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (_, i) {
                  final (art, title, body) = pages[i];
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                          child: art,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(28, 32, 28, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '0${i + 1} / 0$_count',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.7,
                                  color: AppColors.goldText,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 30,
                                  height: 1.15,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.navy,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                body,
                                style: const TextStyle(
                                  fontSize: 17,
                                  height: 1.5,
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
              child: isLast
                  ? Column(
                      children: [
                        _Dots(index: _index, count: _count),
                        const SizedBox(height: 16),
                        _PrimaryButton(
                          label: s.getStarted,
                          onPressed: _next,
                          expand: true,
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        _Dots(index: _index, count: _count),
                        const Spacer(),
                        _PrimaryButton(
                          label: s.next,
                          onPressed: _next,
                          icon: AppIcons.arrowForward,
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.index, required this.count});
  final int index;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Step ${index + 1} of $count',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(count, (i) {
          final on = i == index;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: on ? 28 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: on ? AppColors.primary : AppColors.lineStrong,
              borderRadius: BorderRadius.circular(4),
            ),
          );
        }),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.expand = false,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary,
        minimumSize: Size(expand ? double.infinity : 0, 56),
        padding: const EdgeInsets.symmetric(horizontal: 26),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          if (icon != null) ...[const SizedBox(width: 8), Icon(icon, size: 20)],
        ],
      ),
    );
  }
}
