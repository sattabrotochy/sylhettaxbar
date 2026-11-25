import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../settings/presentation/viewmodels/settings_view_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bar = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  )..repeat();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1800), () {
      if (!mounted) return;
      final done = context.read<SettingsViewModel>().onboardingDone;
      context.go(done ? AppRoutes.home : AppRoutes.onboarding);
    });
  }

  @override
  void dispose() {
    _bar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.navy,
        body: Stack(
          children: [
            const Positioned(top: -140, right: -160, child: _Ring(420)),
            const Positioned(top: -80, right: -100, child: _Ring(300)),
            Positioned(
              bottom: -180,
              left: -140,
              child: Container(
                width: 380,
                height: 380,
                decoration: const BoxDecoration(
                    color: AppColors.navyDeep, shape: BoxShape.circle),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 80, 32, 40),
                child: Column(
                  children: [
                    const Spacer(),
                    const Emblem(size: 144),
                    const SizedBox(height: 28),
                    Text(s.sylhetDistrict.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2.7,
                            color: AppColors.gold)),
                    const SizedBox(height: 6),
                    Text(s.associationName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 34,
                            height: 1.1,
                            fontWeight: FontWeight.w800,
                            color: Colors.white)),
                    const SizedBox(height: 16),
                    Container(
                        width: 48,
                        height: 3,
                        decoration: BoxDecoration(
                            color: AppColors.gold,
                            borderRadius: BorderRadius.circular(2))),
                    const SizedBox(height: 16),
                    Text(s.tagline,
                        style: const TextStyle(
                            fontSize: 16, color: AppColors.textOnNavyMuted)),
                    const Spacer(flex: 2),
                    _LoadingBar(animation: _bar),
                    const SizedBox(height: 14),
                    Text(s.location,
                        style: const TextStyle(
                            fontSize: 14, color: AppColors.textOnNavyMuted)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Ring extends StatelessWidget {
  const _Ring(this.size);
  final double size;

  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
      );
}

class _LoadingBar extends StatelessWidget {
  const _LoadingBar({required this.animation});
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Loading',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: Container(
          width: 140,
          height: 4,
          color: Colors.white.withValues(alpha: 0.14),
          child: AnimatedBuilder(
            animation: animation,
            builder: (_, _) => FractionalTranslation(
              translation: Offset(-1 + animation.value * 3.5, 0),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: 0.4,
                child: Container(color: AppColors.gold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
