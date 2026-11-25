import 'package:flutter/foundation.dart';

import '../error/failures.dart';

enum ViewStatus { initial, loading, success, empty, error }

/// Common loading / error handling for view models.
abstract class BaseViewModel extends ChangeNotifier {
  ViewStatus _status = ViewStatus.initial;
  Failure? _failure;
  bool _disposed = false;

  ViewStatus get status => _status;
  Failure? get failure => _failure;
  bool get isLoading => _status == ViewStatus.loading;
  bool get hasError => _status == ViewStatus.error;

  @protected
  void setStatus(ViewStatus status, {Failure? failure}) {
    _status = status;
    _failure = failure;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (!_disposed) super.notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
