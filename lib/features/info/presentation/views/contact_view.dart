import 'package:flutter/material.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/launcher.dart';
import '../../../../core/widgets/app_icons.dart';
import '../../../../core/widgets/common_widgets.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    final rows = [
      (AppIcons.location, s.address, AppConfig.officeAddress,
          () => Launcher.maps(context, AppConfig.officeMapsQuery, s.couldNotOpen)),
      (AppIcons.phone, s.phone, AppConfig.officePhoneDisplay,
          () => Launcher.call(context, AppConfig.officePhone, s.couldNotOpen)),
      (AppIcons.email, s.email, AppConfig.officeEmail,
          () => Launcher.email(context, AppConfig.officeEmail, s.couldNotOpen)),
    ];

    return Scaffold(
      body: Column(
        children: [
          BackHeader(title: s.contactUs),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
              children: [
                const _MapCard(),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      for (final (i, (icon, label, value, onTap)) in rows.indexed)
                        InkWell(
                          onTap: onTap,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              border: i < rows.length - 1
                                  ? const Border(
                                      bottom: BorderSide(color: AppColors.line))
                                  : null,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: AppColors.line,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Icon(icon,
                                      size: 20, color: AppColors.primary),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(label,
                                          style: const TextStyle(
                                              fontSize: 13,
                                              color: AppColors.textMuted)),
                                      Text(value,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              height: 1.35,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.navy)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: () => Launcher.call(
                            context, AppConfig.officePhone, s.couldNotOpen),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          minimumSize: const Size.fromHeight(52),
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                        ),
                        child: Text(s.callOffice),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Launcher.maps(
                            context, AppConfig.officeMapsQuery, s.couldNotOpen),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          backgroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(52),
                          side: const BorderSide(
                              color: AppColors.primary, width: 1.5),
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                        ),
                        child: Text(s.directions),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Stylised map card from the design; tapping opens Google Maps.
class _MapCard extends StatelessWidget {
  const _MapCard();

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    return Semantics(
      button: true,
      label: s.directions,
      child: GestureDetector(
        onTap: () =>
            Launcher.maps(context, AppConfig.officeMapsQuery, s.couldNotOpen),
        child: Container(
          height: 190,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              color: AppColors.line, borderRadius: BorderRadius.circular(24)),
          child: Stack(
            children: [
              Positioned(
                left: -20,
                right: -20,
                top: 70,
                child: Transform.rotate(
                    angle: -0.14,
                    child: Container(height: 14, color: Colors.white)),
              ),
              Positioned(
                top: -20,
                bottom: -20,
                left: 210,
                child: Transform.rotate(
                    angle: 0.17, child: Container(width: 12, color: Colors.white)),
              ),
              Positioned(
                left: 40,
                top: 110,
                child: Container(
                    width: 90,
                    height: 50,
                    decoration: BoxDecoration(
                        color: AppColors.tile,
                        borderRadius: BorderRadius.circular(10))),
              ),
              Positioned(
                left: 250,
                top: 20,
                child: Container(
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                        color: AppColors.tile,
                        borderRadius: BorderRadius.circular(10))),
              ),
              const Positioned(
                left: 156,
                top: 46,
                child: Icon(Icons.location_on_rounded,
                    size: 64, color: AppColors.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
