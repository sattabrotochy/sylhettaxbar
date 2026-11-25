import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_colors.dart';
import 'app_icons.dart';
import 'common_widgets.dart';

/// Bottom navigation: Home · Members · Notices · More.
///
/// Android back button on the tab screens:
/// - on another tab, back goes to Home;
/// - on Home, the first press shows a hint, and a second press within
///   [_exitWindow] asks "Are you sure?" — Yes closes the app.
class MainShell extends StatefulWidget {
  const MainShell({super.key, required this.shell});
  final StatefulNavigationShell shell;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  static const _exitWindow = Duration(seconds: 2);
  DateTime? _lastBack;
  bool _dialogOpen = false;

  Future<void> _onBack() async {
    final shell = widget.shell;
    if (shell.currentIndex != 0) {
      shell.goBranch(0);
      return;
    }
    final now = DateTime.now();
    final last = _lastBack;
    if (last == null || now.difference(last) > _exitWindow) {
      _lastBack = now;
      final s = context.strings;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(s.pressBackAgainToExit),
            duration: _exitWindow,
          ),
        );
      return;
    }
    _lastBack = null;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    if (await _confirmExit()) await SystemNavigator.pop();
  }

  Future<bool> _confirmExit() async {
    if (_dialogOpen) return false;
    _dialogOpen = true;
    final s = context.strings;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          s.exitTitle,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: AppColors.navy,
          ),
        ),
        content: Text(
          s.exitMessage,
          style: const TextStyle(fontSize: 16, color: AppColors.textMuted),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            style: TextButton.styleFrom(foregroundColor: AppColors.textMuted),
            child: Text(
              s.no,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
            child: Text(
              s.yes,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
    _dialogOpen = false;
    return ok ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final shell = widget.shell;
    final s = context.strings;
    final items = [
      (AppIcons.home, AppIcons.homeFilled, s.home),
      (AppIcons.members, AppIcons.members, s.members),
      (AppIcons.bell, AppIcons.bell, s.notices),
      (AppIcons.grid, AppIcons.grid, s.more),
    ];
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _onBack();
      },
      child: Scaffold(
        body: shell,
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            border: Border(top: BorderSide(color: AppColors.line)),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
              child: Row(
                children: List.generate(items.length, (i) {
                  final (icon, activeIcon, label) = items[i];
                  final on = i == shell.currentIndex;
                  final color = on ? AppColors.primary : AppColors.textMuted;
                  return Expanded(
                    child: Semantics(
                      selected: on,
                      button: true,
                      label: label,
                      excludeSemantics: true,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: () => shell.goBranch(
                          i,
                          initialLocation: i == shell.currentIndex,
                        ),
                        child: SizedBox(
                          height: 52,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                on ? activeIcon : icon,
                                color: color,
                                size: 24,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                label,
                                style: TextStyle(
                                  fontSize: 12,
                                  height: 1.2,
                                  color: color,
                                  fontWeight: on
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
