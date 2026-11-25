import 'package:flutter/material.dart';

import '../../../../core/widgets/app_icons.dart';
import '../../../../core/widgets/common_widgets.dart';

/// Gallery screen. There is no gallery endpoint yet, so it shows an empty state.
class GalleryView extends StatelessWidget {
  const GalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    return Scaffold(
      body: Column(
        children: [
          BackHeader(title: s.gallery),
          Expanded(
            child: StateView.empty(message: s.galleryEmpty, icon: AppIcons.gallery),
          ),
        ],
      ),
    );
  }
}
