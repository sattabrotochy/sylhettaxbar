import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_icons.dart';
import '../../../../core/widgets/common_widgets.dart';

/// A simple content page (History, Constitution): a heading card followed by
/// paragraphs and an optional highlighted note. The text is the website's
/// copy, kept in [AppStrings] so it follows the app language.
class TextPageView extends StatelessWidget {
  const TextPageView({
    super.key,
    required this.title,
    required this.heading,
    required this.icon,
    required this.paragraphs,
    this.note,
  });

  final String title;
  final String heading;
  final IconData icon;
  final List<String> paragraphs;
  final String? note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BackHeader(title: title),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 32),
              children: [
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.navy,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(icon, color: AppColors.gold, size: 24),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          heading,
                          style: const TextStyle(
                            fontSize: 18,
                            height: 1.3,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final (i, p) in paragraphs.indexed) ...[
                        if (i > 0) const SizedBox(height: 14),
                        SelectableText(
                          p,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.6,
                            color: AppColors.text,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (note != null) ...[
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.goldSoft,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.gold.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          AppIcons.info,
                          color: AppColors.goldText,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            note!,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.5,
                              color: AppColors.goldText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
