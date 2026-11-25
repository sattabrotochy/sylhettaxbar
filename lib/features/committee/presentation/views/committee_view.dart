import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/presentation/base_view_model.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_icons.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../domain/entities/committee.dart';
import '../viewmodels/committee_view_model.dart';

class CommitteeView extends StatelessWidget {
  const CommitteeView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CommitteeViewModel>();
    final s = context.strings;

    return Scaffold(
      body: Column(
        children: [
          BackHeader(
            title: s.committee,
            bottom: Row(
              children: [
                PillChip(
                  label: s.presentEc,
                  selected: vm.tab == CommitteeStatus.active,
                  onTap: () => vm.selectTab(CommitteeStatus.active),
                ),
                const SizedBox(width: 8),
                PillChip(
                  label: s.previousEc,
                  selected: vm.tab == CommitteeStatus.previous,
                  onTap: () => vm.selectTab(CommitteeStatus.previous),
                ),
              ],
            ),
          ),
          Expanded(
            child: switch (vm.status) {
              ViewStatus.initial || ViewStatus.loading =>
                const StateView.loading(),
              ViewStatus.error =>
                StateView.error(failure: vm.failure, onRetry: vm.load),
              ViewStatus.empty => StateView.empty(
                  message: s.noCommittee, icon: AppIcons.committee),
              ViewStatus.success => RefreshIndicator(
                  onRefresh: vm.load,
                  child: const _CommitteeBody(),
                ),
            },
          ),
        ],
      ),
    );
  }
}

class _CommitteeBody extends StatelessWidget {
  const _CommitteeBody();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CommitteeViewModel>();
    final s = context.strings;
    final selected = vm.selected;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
      children: [
        if (vm.committees.length > 1) ...[
          SizedBox(
            height: 38,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: vm.committees.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final c = vm.committees[i];
                return PillChip(
                  label: c.name,
                  selected: c.id == selected?.id,
                  onTap: () => vm.selectCommittee(c),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
        Eyebrow(selected == null
            ? s.executiveCommittee
            : '${s.executiveCommittee} · ${selected.name}'),
        const SizedBox(height: 14),
        if (vm.membersLoading)
          const StateView.loading()
        else if (!vm.hasMembers)
          StateView.empty(message: s.noCommitteeMembers, icon: AppIcons.members)
        else ...[
          if (vm.leaders.isNotEmpty) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final (i, m) in vm.leaders.indexed) ...[
                  if (i > 0) const SizedBox(width: 12),
                  Expanded(child: _LeaderCard(member: m)),
                ],
                if (vm.leaders.length == 1) ...[
                  const SizedBox(width: 12),
                  const Expanded(child: SizedBox()),
                ],
              ],
            ),
            const SizedBox(height: 14),
          ],
          if (vm.others.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  for (final (i, m) in vm.others.indexed)
                    _MemberRow(member: m, last: i == vm.others.length - 1),
                ],
              ),
            ),
        ],
      ],
    );
  }
}

void _openMember(BuildContext context, CommitteeMember m) {
  if (m.memberId.isNotEmpty) context.push(AppRoutes.member(m.memberId));
}

class _LeaderCard extends StatelessWidget {
  const _LeaderCard({required this.member});
  final CommitteeMember member;

  @override
  Widget build(BuildContext context) {
    final l = context.lang;
    return AppCard(
      color: AppColors.navy,
      bordered: false,
      radius: 20,
      padding: const EdgeInsets.all(16),
      onTap: () => _openMember(context, member),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.gold, width: 2),
            ),
            child: Avatar(
              url: member.photoUrl,
              size: 62,
              background: AppColors.primary,
              iconColor: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(member.name(l),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 15,
                  height: 1.25,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
          const SizedBox(height: 8),
          TagBadge(label: member.designation(l), fontSize: 12),
        ],
      ),
    );
  }
}

class _MemberRow extends StatelessWidget {
  const _MemberRow({required this.member, required this.last});
  final CommitteeMember member;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final l = context.lang;
    return InkWell(
      onTap: () => _openMember(context, member),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: last
              ? null
              : const Border(bottom: BorderSide(color: AppColors.line)),
        ),
        child: Row(
          children: [
            Avatar(url: member.photoUrl, size: 44),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(member.name(l),
                      style: const TextStyle(
                          fontSize: 15,
                          height: 1.3,
                          fontWeight: FontWeight.w700,
                          color: AppColors.navy)),
                  Text(member.designation(l),
                      style: const TextStyle(
                          fontSize: 13, height: 1.3, color: AppColors.textMuted)),
                ],
              ),
            ),
            const Icon(AppIcons.chevronRight, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}
