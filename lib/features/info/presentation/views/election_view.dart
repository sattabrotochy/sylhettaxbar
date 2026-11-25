import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_icons.dart';
import '../../../../core/widgets/common_widgets.dart';

/// Election screen. The backend has no election endpoint yet, so this shows
/// the design's layout with an empty-state message instead of placeholder names.
class ElectionView extends StatelessWidget {
  const ElectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    return Scaffold(
      body: Column(
        children: [
          BackHeader(title: s.election),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      color: AppColors.navy,
                      borderRadius: BorderRadius.circular(24)),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: -80,
                        right: -60,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: const BoxDecoration(
                              color: AppColors.navyDeep, shape: BoxShape.circle),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Container(
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: AppColors.gold, width: 2),
                                ),
                                child: const Icon(AppIcons.election,
                                    color: AppColors.gold),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(s.cecMessage,
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.gold)),
                                    Text(s.chiefElectionCommissioner,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                            ]),
                            const SizedBox(height: 12),
                            Text(s.electionEmpty,
                                style: const TextStyle(
                                    fontSize: 15,
                                    height: 1.55,
                                    color: AppColors.line)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SectionTitle(s.runningCommission),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(20)),
                  child: StateView.empty(
                      message: s.electionEmpty, icon: AppIcons.election),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
