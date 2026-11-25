import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/presentation/base_view_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/utils/html_text.dart';
import '../../../../core/utils/launcher.dart';
import '../../../../core/widgets/app_icons.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../domain/entities/notice.dart';
import '../viewmodels/notices_view_model.dart';

class NoticeDetailView extends StatelessWidget {
  const NoticeDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<NoticeDetailViewModel>();
    final s = context.strings;

    return Scaffold(
      body: Column(
        children: [
          BackHeader(title: s.noticeDetails),
          Expanded(
            child: switch (vm.status) {
              ViewStatus.initial ||
              ViewStatus.loading ||
              ViewStatus.empty =>
                const StateView.loading(),
              ViewStatus.error =>
                StateView.error(failure: vm.failure, onRetry: vm.load),
              ViewStatus.success => _Body(notice: vm.notice!),
            },
          ),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.notice});
  final Notice notice;

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    final l = context.lang;
    final body = HtmlText.toPlain(notice.detailsHtml(l));
    final isNews = notice.type == NoticeType.news;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 32),
      children: [
        Row(children: [
          TagBadge(
            label: isNews ? s.news : s.notice,
            background: isNews ? AppColors.line : AppColors.primary,
            foreground: isNews ? AppColors.primary : Colors.white,
            fontSize: 12,
          ),
          const SizedBox(width: 10),
          if (notice.date != null)
            Text(DateFmt.full(notice.date, l),
                style: const TextStyle(fontSize: 14, color: AppColors.textMuted)),
        ]),
        const SizedBox(height: 10),
        Text(notice.title(l),
            style: const TextStyle(
                fontSize: 24,
                height: 1.25,
                fontWeight: FontWeight.w800,
                color: AppColors.navy)),
        if (notice.endDate != null) ...[
          const SizedBox(height: 6),
          Text('${s.validUntil}: ${DateFmt.full(notice.endDate, l)}',
              style: const TextStyle(fontSize: 14, color: AppColors.goldText)),
        ],
        const SizedBox(height: 16),
        if (body.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: SelectableText(body,
                style: const TextStyle(
                    fontSize: 16, height: 1.55, color: AppColors.text)),
          ),
        if (notice.hasAttachment) ...[
          const SizedBox(height: 16),
          if (notice.isImageAttachment)
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: GestureDetector(
                onTap: () =>
                    Launcher.web(context, notice.attachmentUrl, s.couldNotOpen),
                child: CachedNetworkImage(
                  imageUrl: notice.attachmentUrl,
                  fit: BoxFit.fitWidth,
                  placeholder: (_, _) => const SizedBox(
                      height: 200, child: Center(child: CircularProgressIndicator())),
                  errorWidget: (_, _, _) => const SizedBox.shrink(),
                ),
              ),
            ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () =>
                Launcher.web(context, notice.attachmentUrl, s.couldNotOpen),
            icon: const Icon(AppIcons.download),
            label: Text(s.openAttachment),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary, width: 1.5),
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
          ),
        ],
      ],
    );
  }
}
