import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_icons.dart';
import '../../../../core/widgets/common_widgets.dart';

const _shadow = [
  BoxShadow(color: Color(0x14001B4D), blurRadius: 16, offset: Offset(0, 6)),
];

class _Panel extends StatelessWidget {
  const _Panel({required this.color, required this.children, this.decor});
  final Color color;
  final List<Widget> children;
  final Widget? decor;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Container(
        height: 372,
        clipBehavior: Clip.antiAlias,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(28)),
        child: Stack(
          children: [
            ?decor,
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 28, 22, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _bar(double w, double h, Color c) => Container(
      width: w,
      height: h,
      decoration:
          BoxDecoration(color: c, borderRadius: BorderRadius.circular(h / 2)),
    );

class DirectoryIllustration extends StatelessWidget {
  const DirectoryIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    Widget row(Color avatar, double w1, double w2, Widget? trailing,
            {bool faded = false}) =>
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: faded ? Colors.white.withValues(alpha: 0.6) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: faded ? null : _shadow,
          ),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(color: avatar, shape: BoxShape.circle),
                child: faded
                    ? null
                    : const Icon(AppIcons.person, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _bar(w1, 10, faded ? AppColors.textOnNavyMuted : AppColors.navy),
                    const SizedBox(height: 7),
                    _bar(w2, 8, AppColors.lineStrong),
                  ],
                ),
              ),
              ?trailing,
            ],
          ),
        );

    return _Panel(
      color: AppColors.line,
      decor: Positioned(
        top: -60,
        right: -60,
        child: Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.lineStrong)),
        ),
      ),
      children: [
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: _shadow),
          child: Row(children: [
            const Icon(AppIcons.search, color: AppColors.primary, size: 20),
            const SizedBox(width: 10),
            Text(s.searchAdvocates,
                style: const TextStyle(fontSize: 15, color: AppColors.textMuted)),
          ]),
        ),
        const SizedBox(height: 12),
        row(AppColors.primary, 120, 84, TagBadge(label: s.goldenMember, fontSize: 12)),
        const SizedBox(height: 12),
        row(
          AppColors.navy,
          140,
          96,
          Container(
            width: 40,
            height: 40,
            decoration:
                const BoxDecoration(color: AppColors.line, shape: BoxShape.circle),
            child: const Icon(AppIcons.phone, color: AppColors.primary, size: 18),
          ),
        ),
        const SizedBox(height: 12),
        row(AppColors.textOnNavyMuted, 110, 70, null, faded: true),
      ],
    );
  }
}

class NoticesIllustration extends StatelessWidget {
  const NoticesIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    Widget card(String tag, Color tagBg, Color tagFg, double w1, double w2,
            {double indent = 0}) =>
        Container(
          margin: EdgeInsets.only(left: indent),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                TagBadge(label: tag, background: tagBg, foreground: tagFg, fontSize: 12),
                const Spacer(),
                _bar(54, 8, AppColors.lineStrong),
              ]),
              const SizedBox(height: 9),
              _bar(w1, 10, AppColors.navy),
              const SizedBox(height: 9),
              _bar(w2, 8, AppColors.lineStrong),
            ],
          ),
        );

    return _Panel(
      color: AppColors.navy,
      decor: Positioned(
        bottom: -90,
        right: -70,
        child: Container(
          width: 240,
          height: 240,
          decoration: const BoxDecoration(
              color: AppColors.navyDeep, shape: BoxShape.circle),
        ),
      ),
      children: [
        Row(children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
                color: AppColors.primary, borderRadius: BorderRadius.circular(16)),
            child: const Icon(AppIcons.bell, color: Colors.white, size: 26),
          ),
          const SizedBox(width: 12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _bar(110, 10, Colors.white),
            const SizedBox(height: 6),
            _bar(70, 8, const Color(0xFF46639E)),
          ]),
        ]),
        const SizedBox(height: 16),
        card(s.notice, AppColors.primary, Colors.white, 200, 160),
        const SizedBox(height: 12),
        card(s.election, AppColors.gold, AppColors.navy, 170, 130, indent: 18),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TagBadge(
                  label: s.news,
                  background: AppColors.line,
                  foreground: AppColors.navy,
                  fontSize: 12),
              const SizedBox(height: 9),
              _bar(180, 10, Colors.white.withValues(alpha: 0.5)),
            ],
          ),
        ),
      ],
    );
  }
}

class FormsIllustration extends StatelessWidget {
  const FormsIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    Widget doc(String label, Color bg, Color border, Color fg, double w1, double w2) =>
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: _shadow),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 52,
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(bottom: 6),
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: border, width: 1.5),
                ),
                child: Text(label,
                    style: TextStyle(
                        fontSize: 11, fontWeight: FontWeight.w800, color: fg)),
              ),
              const SizedBox(height: 10),
              FractionallySizedBox(
                  widthFactor: w1, child: _bar(double.infinity, 9, AppColors.navy)),
              const SizedBox(height: 10),
              FractionallySizedBox(
                  widthFactor: w2,
                  child: _bar(double.infinity, 8, AppColors.lineStrong)),
              const SizedBox(height: 10),
              Row(children: [
                const Icon(AppIcons.download, size: 16, color: AppColors.primary),
                const SizedBox(width: 6),
                Text(s.download,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary)),
              ]),
            ],
          ),
        );

    return _Panel(
      color: AppColors.line,
      decor: Positioned(
        top: -50,
        left: -70,
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.lineStrong)),
        ),
      ),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: doc('PDF', AppColors.background, AppColors.primary,
                    AppColors.primary, 0.9, 0.6)),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 22),
                child: doc('FORM', AppColors.goldSoft, AppColors.gold,
                    AppColors.goldText, 0.8, 0.55),
              ),
            ),
          ],
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: AppColors.navy, borderRadius: BorderRadius.circular(18)),
          child: Row(children: [
            Container(
              width: 44,
              height: 44,
              decoration:
                  const BoxDecoration(color: AppColors.gold, shape: BoxShape.circle),
              child: const Icon(AppIcons.location, color: AppColors.navy, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(s.barOffice,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                Text(s.location,
                    style: const TextStyle(
                        fontSize: 13, color: AppColors.textOnNavyMuted)),
              ]),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                  color: AppColors.primary, shape: BoxShape.circle),
              child: const Icon(AppIcons.phone, color: Colors.white, size: 18),
            ),
          ]),
        ),
      ],
    );
  }
}
