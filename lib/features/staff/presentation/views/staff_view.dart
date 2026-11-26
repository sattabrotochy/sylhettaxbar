import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/presentation/base_view_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/utils/launcher.dart';
import '../../../../core/widgets/app_icons.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../domain/entities/staff.dart';
import '../viewmodels/staff_view_model.dart';

class StaffView extends StatelessWidget {
  const StaffView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<StaffViewModel>();
    final s = context.strings;

    return Scaffold(
      body: Column(
        children: [
          BackHeader(title: s.staff),
          Expanded(
            child: switch (vm.status) {
              ViewStatus.initial ||
              ViewStatus.loading => const StateView.loading(),
              ViewStatus.error => StateView.error(
                failure: vm.failure,
                onRetry: vm.load,
              ),
              ViewStatus.empty => StateView.empty(
                message: s.noStaff,
                icon: AppIcons.staff,
              ),
              ViewStatus.success => RefreshIndicator(
                onRefresh: vm.load,
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
                  itemCount: vm.staff.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (_, i) => _StaffTile(staff: vm.staff[i]),
                ),
              ),
            },
          ),
        ],
      ),
    );
  }
}

class _StaffTile extends StatelessWidget {
  const _StaffTile({required this.staff});
  final Staff staff;

  @override
  Widget build(BuildContext context) {
    final l = context.lang;
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      onTap: () => showModalBottomSheet<void>(
        context: context,
        showDragHandle: true,
        backgroundColor: Colors.white,
        isScrollControlled: true,
        builder: (_) => _StaffSheet(staff: staff),
      ),
      child: Row(
        children: [
          Avatar(url: staff.photoUrl, size: 48),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  staff.name(l),
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.35,
                    fontWeight: FontWeight.w700,
                    color: AppColors.navy,
                  ),
                ),
                Text(
                  staff.designation(l),
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.35,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          const Icon(AppIcons.chevronRight, color: AppColors.textMuted),
        ],
      ),
    );
  }
}

class _StaffSheet extends StatelessWidget {
  const _StaffSheet({required this.staff});
  final Staff staff;

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    final l = context.lang;
    final rows = [
      if (staff.mobile.isNotEmpty) (AppIcons.phone, s.mobile, staff.mobile),
      if (staff.education(l).isNotEmpty)
        (AppIcons.school, s.education, staff.education(l)),
      if (staff.joiningDate != null)
        (AppIcons.calendar, s.joined, DateFmt.full(staff.joiningDate, l)),
      if (staff.bloodGroup.isNotEmpty)
        (AppIcons.blood, s.bloodGroup, staff.bloodGroup),
      if (staff.address(l).isNotEmpty)
        (AppIcons.location, s.address, staff.address(l)),
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Avatar(url: staff.photoUrl, size: 88),
            const SizedBox(height: 10),
            Text(
              staff.name(l),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColors.navy,
              ),
            ),
            Text(
              staff.designation(l),
              style: const TextStyle(fontSize: 15, color: AppColors.textMuted),
            ),
            const SizedBox(height: 12),
            for (final (icon, label, value) in rows)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: AppColors.line)),
                ),
                child: Row(
                  children: [
                    Icon(icon, color: AppColors.primary, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textMuted,
                            ),
                          ),
                          Text(
                            value,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.text,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            if (staff.mobile.isNotEmpty) ...[
              const SizedBox(height: 8),
              FilledButton.icon(
                onPressed: () =>
                    Launcher.call(context, staff.mobile, s.couldNotOpen),
                icon: const Icon(AppIcons.phone),
                label: Text(s.call),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size.fromHeight(50),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
