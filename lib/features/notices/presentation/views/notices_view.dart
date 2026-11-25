import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/presentation/base_view_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_icons.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../domain/entities/notice.dart';
import '../viewmodels/notices_view_model.dart';
import '../widgets/notice_tile.dart';

class NoticesView extends StatelessWidget {
  const NoticesView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<NoticesViewModel>();
    final s = context.strings;
    final items = vm.items;
    final emptyText = vm.tab == NoticeType.news ? s.noNews : s.noNotices;

    return Column(
      children: [
        TitleHeader(
          title: s.noticesAndNews,
          bottom: _SegmentedTabs(
            labels: [s.notices, s.news],
            selected: vm.tab.index,
            onSelect: (i) => vm.selectTab(NoticeType.values[i]),
          ),
        ),
        Expanded(
          child: switch (vm.status) {
            ViewStatus.initial || ViewStatus.loading => const StateView.loading(),
            ViewStatus.error =>
              StateView.error(failure: vm.failure, onRetry: vm.load),
            _ => RefreshIndicator(
                onRefresh: vm.load,
                child: items.isEmpty
                    ? ListView(children: [
                        StateView.empty(message: emptyText, icon: AppIcons.notice)
                      ])
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                        itemCount: items.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 10),
                        itemBuilder: (_, i) => NoticeTile(notice: items[i]),
                      ),
              ),
          },
        ),
      ],
    );
  }
}

class _SegmentedTabs extends StatelessWidget {
  const _SegmentedTabs({
    required this.labels,
    required this.selected,
    required this.onSelect,
  });

  final List<String> labels;
  final int selected;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.line),
      ),
      child: Row(
        children: List.generate(labels.length, (i) {
          final on = i == selected;
          return Expanded(
            child: Semantics(
              selected: on,
              button: true,
              child: Material(
                color: on ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => onSelect(i),
                  child: SizedBox(
                    height: 40,
                    child: Center(
                      child: Text(labels[i],
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: on ? Colors.white : AppColors.textMuted)),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
