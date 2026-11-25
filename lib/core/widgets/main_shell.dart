import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_colors.dart';
import 'app_icons.dart';
import 'common_widgets.dart';

/// Bottom navigation: Home · Members · Notices · More.
class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.shell});
  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    final items = [
      (AppIcons.home, AppIcons.homeFilled, s.home),
      (AppIcons.members, AppIcons.members, s.members),
      (AppIcons.bell, AppIcons.bell, s.notices),
      (AppIcons.grid, AppIcons.grid, s.more),
    ];
    return Scaffold(
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
                      onTap: () =>
                          shell.goBranch(i, initialLocation: i == shell.currentIndex),
                      child: SizedBox(
                        height: 52,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(on ? activeIcon : icon, color: color, size: 24),
                            const SizedBox(height: 2),
                            Text(label,
                                style: TextStyle(
                                    fontSize: 12,
                                    height: 1.2,
                                    color: color,
                                    fontWeight:
                                        on ? FontWeight.w700 : FontWeight.w500)),
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
    );
  }
}
