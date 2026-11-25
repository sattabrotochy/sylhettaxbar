import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../features/settings/presentation/viewmodels/settings_view_model.dart';
import '../error/failures.dart';
import '../localization/app_language.dart';
import '../localization/app_strings.dart';
import '../theme/app_colors.dart';
import 'app_icons.dart';

extension AppContextX on BuildContext {
  AppStrings get strings => watch<SettingsViewModel>().strings;
  AppLanguage get lang => watch<SettingsViewModel>().language;
}

/// Rounded square icon button used in headers (back, share, bell).
class HeaderIconButton extends StatelessWidget {
  const HeaderIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.onDark = false,
    this.badge = false,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final bool onDark;
  final bool badge;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: onDark ? Colors.white.withValues(alpha: 0.08) : AppColors.background,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onPressed,
          child: SizedBox(
            width: 44,
            height: 44,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(icon,
                    size: 22, color: onDark ? Colors.white : AppColors.navy),
                if (badge)
                  const Positioned(
                    top: 10,
                    right: 11,
                    child: CircleAvatar(radius: 4, backgroundColor: AppColors.gold),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// White top bar with a back button and title (Committee, Election, ...).
class BackHeader extends StatelessWidget implements PreferredSizeWidget {
  const BackHeader({super.key, required this.title, this.bottom});

  final String title;
  final Widget? bottom;

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.line)),
      ),
      padding: EdgeInsets.fromLTRB(
          20, MediaQuery.paddingOf(context).top + 8, 20, 14),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              HeaderIconButton(
                icon: AppIcons.back,
                tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                onPressed: () => context.canPop() ? context.pop() : context.go('/home'),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(title,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.navy)),
              ),
            ],
          ),
          if (bottom != null) ...[const SizedBox(height: 14), bottom!],
        ],
      ),
    );
  }
}

/// White top bar with a large title (tab roots: Members, Notices, More).
class TitleHeader extends StatelessWidget {
  const TitleHeader({super.key, required this.title, this.trailing, this.bottom});

  final String title;
  final Widget? trailing;
  final Widget? bottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.line)),
      ),
      padding: EdgeInsets.fromLTRB(
          20, MediaQuery.paddingOf(context).top + 12, 20, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(title,
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: AppColors.navy)),
              ),
              ?trailing,
            ],
          ),
          if (bottom != null) ...[const SizedBox(height: 14), bottom!],
        ],
      ),
    );
  }
}

/// Pill used for filters and tabs.
class PillChip extends StatelessWidget {
  const PillChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      selected: selected,
      button: true,
      child: Material(
        color: selected ? AppColors.primary : AppColors.surface,
        shape: StadiumBorder(
            side: BorderSide(
                color: selected ? AppColors.primary : AppColors.line)),
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: onTap,
          child: Container(
            constraints: const BoxConstraints(minHeight: 38),
            padding: const EdgeInsets.symmetric(horizontal: 14),
            alignment: Alignment.center,
            child: Text(label,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: selected ? Colors.white : AppColors.textMuted)),
          ),
        ),
      ),
    );
  }
}

/// EN / বাংলা toggle bound to [SettingsViewModel].
class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SettingsViewModel>();
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.line),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: AppLanguage.values.map((l) {
          final on = l == vm.language;
          return Semantics(
            selected: on,
            button: true,
            child: GestureDetector(
              onTap: () => vm.setLanguage(l),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                constraints: const BoxConstraints(minHeight: 36),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: on ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(l.label,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: on ? Colors.white : AppColors.textMuted)),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// Small rounded tag ("Golden", "Notice", ...).
class TagBadge extends StatelessWidget {
  const TagBadge({
    super.key,
    required this.label,
    this.background = AppColors.gold,
    this.foreground = AppColors.navy,
    this.fontSize = 11,
  });

  final String label;
  final Color background;
  final Color foreground;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 2),
      decoration: BoxDecoration(
          color: background, borderRadius: BorderRadius.circular(999)),
      child: Text(label,
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              color: foreground,
              height: 1.4)),
    );
  }
}

/// Circular photo with a person-icon fallback.
class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required this.url,
    this.size = 48,
    this.background = AppColors.line,
    this.iconColor = AppColors.primary,
  });

  final String url;
  final double size;
  final Color background;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final fallback = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: background, shape: BoxShape.circle),
      child: Icon(AppIcons.person, color: iconColor, size: size * 0.48),
    );
    if (url.isEmpty) return fallback;
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: url,
        width: size,
        height: size,
        fit: BoxFit.cover,
        placeholder: (_, _) => fallback,
        errorWidget: (_, _, _) => fallback,
      ),
    );
  }
}

/// The scales-of-justice emblem in gold rings.
class Emblem extends StatelessWidget {
  const Emblem({super.key, this.size = 144, this.ringWidth = 2});

  final double size;
  final double ringWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.gold, width: ringWidth),
      ),
      alignment: Alignment.center,
      child: AppLogo(size: size - ringWidth * 2 - size * 0.06),
    );
  }
}

/// The association's round seal on a white disc.
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 44});

  static const asset = 'assets/images/logo.png';
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration:
          const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: Image.asset(asset,
          width: size,
          height: size,
          semanticLabel: 'Sylhet District Taxes Bar Association',
          cacheWidth: (size * 3).round()),
    );
  }
}

/// White rounded card.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(14),
    this.radius = 16,
    this.onTap,
    this.color = AppColors.surface,
    this.bordered = true,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final VoidCallback? onTap;
  final Color color;
  final bool bordered;

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
      side: bordered ? const BorderSide(color: AppColors.line) : BorderSide.none,
    );
    return Material(
      color: color,
      shape: shape,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

/// Section heading ("Quick access", "Latest notices").
class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key, this.trailing});
  final String text;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Semantics(
            header: true,
            child: Text(text,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.navy)),
          ),
        ),
        ?trailing,
      ],
    );
  }
}

/// Gold uppercase eyebrow label.
class Eyebrow extends StatelessWidget {
  const Eyebrow(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text.toUpperCase(),
        style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.3,
            color: AppColors.goldText));
  }
}

/// Loading / error / empty placeholder used by every list screen.
class StateView extends StatelessWidget {
  const StateView.loading({super.key})
      : _kind = _Kind.loading,
        message = null,
        failure = null,
        onRetry = null,
        icon = null;

  const StateView.empty({super.key, required String this.message, this.icon})
      : _kind = _Kind.empty,
        failure = null,
        onRetry = null;

  const StateView.error({super.key, this.failure, required this.onRetry})
      : _kind = _Kind.error,
        message = null,
        icon = null;

  final _Kind _kind;
  final String? message;
  final Failure? failure;
  final VoidCallback? onRetry;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    switch (_kind) {
      case _Kind.loading:
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: CircularProgressIndicator(),
          ),
        );
      case _Kind.empty:
        return _Message(icon: icon ?? AppIcons.info, title: message!);
      case _Kind.error:
        final isNetwork = failure is NetworkFailure;
        return _Message(
          icon: isNetwork ? Icons.wifi_off_rounded : Icons.error_outline_rounded,
          title: s.somethingWentWrong,
          subtitle: isNetwork ? s.noInternet : failure?.message,
          action: FilledButton(
            onPressed: onRetry,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              minimumSize: const Size(140, 48),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
            ),
            child: Text(s.retry),
          ),
        );
    }
  }
}

enum _Kind { loading, empty, error }

class _Message extends StatelessWidget {
  const _Message({required this.icon, required this.title, this.subtitle, this.action});
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                  color: AppColors.line, borderRadius: BorderRadius.circular(20)),
              child: Icon(icon, color: AppColors.primary, size: 30),
            ),
            const SizedBox(height: 14),
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: AppColors.navy)),
            if (subtitle != null && subtitle!.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(subtitle!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: AppColors.textMuted)),
            ],
            if (action != null) ...[const SizedBox(height: 16), action!],
          ],
        ),
      ),
    );
  }
}
