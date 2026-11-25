import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'core/di/injection.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/settings/presentation/viewmodels/settings_view_model.dart';

class SylhetTaxesBarApp extends StatefulWidget {
  const SylhetTaxesBarApp({super.key});

  @override
  State<SylhetTaxesBarApp> createState() => _SylhetTaxesBarAppState();
}

class _SylhetTaxesBarAppState extends State<SylhetTaxesBarApp> {
  late final GoRouter _router = buildRouter();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingsViewModel(sl()),
      child: MaterialApp.router(
        title: 'Sylhet Taxes Bar',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        routerConfig: _router,
      ),
    );
  }
}
