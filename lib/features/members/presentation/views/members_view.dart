import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/presentation/base_view_model.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/widgets/app_icons.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../domain/entities/member.dart';
import '../viewmodels/members_view_model.dart';

class MembersView extends StatefulWidget {
  const MembersView({super.key});

  @override
  State<MembersView> createState() => _MembersViewState();
}

class _MembersViewState extends State<MembersView> {
  late final TextEditingController _search =
      TextEditingController(text: context.read<MembersViewModel>().query);
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _scroll.addListener(() {
      if (_scroll.position.extentAfter < 400) {
        context.read<MembersViewModel>().loadMore();
      }
    });
  }

  @override
  void dispose() {
    _search.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MembersViewModel>();
    final s = context.strings;
    final l = context.lang;
    final members = vm.visibleMembers;

    final filters = [
      (MemberFilter.all, s.all),
      (MemberFilter.golden, s.golden),
      (MemberFilter.freedomFighter, s.freedomFighter),
      (MemberFilter.retired, s.retired),
    ];

    return Column(
      children: [
        TitleHeader(
          title: s.members,
          trailing: vm.total > 0
              ? Text(DateFmt.digits(s.advocatesCount(vm.total), l),
                  style: const TextStyle(fontSize: 14, color: AppColors.textMuted))
              : null,
          bottom: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _search,
                onChanged: vm.setQuery,
                textInputAction: TextInputAction.search,
                style: const TextStyle(fontSize: 15, color: AppColors.text),
                decoration: InputDecoration(
                  hintText: s.searchByNameOrNo,
                  hintStyle: const TextStyle(color: AppColors.textMuted),
                  prefixIcon: const Icon(AppIcons.search, color: AppColors.primary),
                  suffixIcon: vm.query.isEmpty
                      ? null
                      : IconButton(
                          tooltip: MaterialLocalizations.of(context)
                              .deleteButtonTooltip,
                          icon: const Icon(Icons.close_rounded),
                          onPressed: () {
                            _search.clear();
                            vm.setQuery('');
                          },
                        ),
                  filled: true,
                  fillColor: AppColors.background,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: AppColors.line),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: AppColors.line),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 38,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (_, i) {
                    final (f, label) = filters[i];
                    return PillChip(
                      label: label,
                      selected: vm.filter == f,
                      onTap: () => vm.setFilter(f),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: switch (vm.status) {
            ViewStatus.initial || ViewStatus.loading => const StateView.loading(),
            ViewStatus.error =>
              StateView.error(failure: vm.failure, onRetry: vm.load),
            ViewStatus.empty =>
              StateView.empty(message: s.noMembers, icon: AppIcons.members),
            ViewStatus.success => RefreshIndicator(
                onRefresh: vm.refresh,
                child: members.isEmpty && !vm.hasMore
                    ? ListView(children: [
                        StateView.empty(message: s.noMembers, icon: AppIcons.search)
                      ])
                    : ListView.separated(
                        controller: _scroll,
                        padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
                        itemCount: members.length + (vm.hasMore ? 1 : 0),
                        separatorBuilder: (_, _) => const SizedBox(height: 10),
                        itemBuilder: (_, i) => i >= members.length
                            ? const Padding(
                                padding: EdgeInsets.all(12),
                                child: Center(
                                    child: SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2.5))),
                              )
                            : MemberTile(member: members[i]),
                      ),
              ),
          },
        ),
      ],
    );
  }
}

class MemberTile extends StatelessWidget {
  const MemberTile({super.key, required this.member});
  final Member member;

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    final l = context.lang;
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      onTap: () => context.push(AppRoutes.member(member.id)),
      child: Row(
        children: [
          Avatar(url: member.thumbUrl, size: 48),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(member.name(l),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16,
                        height: 1.35,
                        fontWeight: FontWeight.w700,
                        color: AppColors.navy)),
                if (member.memberNo.isNotEmpty)
                  Text(DateFmt.digits(s.memberNo(member.memberNo), l),
                      style: const TextStyle(
                          fontSize: 13, height: 1.35, color: AppColors.textMuted)),
              ],
            ),
          ),
          if (member.isGolden) ...[
            TagBadge(label: s.golden),
            const SizedBox(width: 6),
          ] else if (member.isFreedomFighter) ...[
            TagBadge(
                label: s.freedomFighter,
                background: AppColors.line,
                foreground: AppColors.primary),
            const SizedBox(width: 6),
          ],
          const Icon(AppIcons.chevronRight, color: AppColors.textMuted),
        ],
      ),
    );
  }
}
