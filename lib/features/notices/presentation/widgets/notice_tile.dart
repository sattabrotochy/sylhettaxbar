import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/widgets/app_icons.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../domain/entities/notice.dart';

/// Notice card with a date block, as on the Notices & News screen.
class NoticeTile extends StatelessWidget {
  const NoticeTile({super.key, required this.notice});
  final Notice notice;

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    final l = context.lang;
    final isNews = notice.type == NoticeType.news;
    final d = notice.date;

    return AppCard(
      radius: 18,
      onTap: () => context.push(AppRoutes.notice(notice.id)),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 54,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                  color: AppColors.line, borderRadius: BorderRadius.circular(12)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: d == null
                    ? const [Icon(AppIcons.notice, color: AppColors.navy)]
                    : [
                        Text(DateFmt.day(d, l),
                            style: const TextStyle(
                                fontSize: 18,
                                height: 1.1,
                                fontWeight: FontWeight.w800,
                                color: AppColors.navy)),
                        Text(DateFmt.month(d, l),
                            style: const TextStyle(
                                fontSize: 12,
                                height: 1.1,
                                fontWeight: FontWeight.w600,
                                color: AppColors.navy)),
                      ],
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TagBadge(
                    label: isNews ? s.news : s.notice,
                    background: isNews ? AppColors.line : AppColors.primary,
                    foreground: isNews ? AppColors.primary : Colors.white,
                  ),
                  const SizedBox(height: 4),
                  Text(notice.title(l),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 15,
                          height: 1.3,
                          fontWeight: FontWeight.w700,
                          color: AppColors.navy)),
                  if (notice.hasAttachment) ...[
                    const SizedBox(height: 4),
                    Row(children: [
                      const Icon(AppIcons.attachment,
                          size: 16, color: AppColors.primary),
                      const SizedBox(width: 5),
                      Text(s.pdfAttached,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary)),
                    ]),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
