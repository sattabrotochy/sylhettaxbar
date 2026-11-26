import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../settings/presentation/viewmodels/settings_view_model.dart';

/// A page of the association's website shown inside the app (Gallery,
/// vakalatnama verification), under the app's own header and back button.
///
/// [buildUrl] gets the app's language code (`en`/`bn`) so the website opens
/// in the same language as the app.
class WebPageView extends StatefulWidget {
  const WebPageView({super.key, required this.title, required this.buildUrl});

  final String title;
  final String Function(String langCode) buildUrl;

  @override
  State<WebPageView> createState() => _WebPageViewState();
}

class _WebPageViewState extends State<WebPageView> {
  late final WebViewController _controller;
  late final Uri _url;
  int _progress = 0;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    final lang = context.read<SettingsViewModel>().language;
    _url = Uri.parse(widget.buildUrl(lang.code));
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.background)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (p) {
            if (mounted) setState(() => _progress = p);
          },
          onPageStarted: (_) {
            if (mounted) setState(() => _failed = false);
          },
          onWebResourceError: (error) {
            // Only a failed page load counts; a broken image inside the page
            // shouldn't replace the whole page with an error.
            if ((error.isForMainFrame ?? true) && mounted) {
              setState(() => _failed = true);
            }
          },
        ),
      )
      ..loadRequest(_url);
  }

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    return Scaffold(
      body: Column(
        children: [
          BackHeader(title: widget.title),
          if (_progress < 100 && !_failed)
            LinearProgressIndicator(
              value: _progress == 0 ? null : _progress / 100,
              minHeight: 3,
              color: AppColors.primary,
              backgroundColor: AppColors.line,
            ),
          Expanded(
            child: _failed
                ? StateView.error(
                    failure: UnknownFailure(s.pageLoadFailed),
                    onRetry: () {
                      setState(() {
                        _failed = false;
                        _progress = 0;
                      });
                      _controller.loadRequest(_url);
                    },
                  )
                : WebViewWidget(controller: _controller),
          ),
        ],
      ),
    );
  }
}
