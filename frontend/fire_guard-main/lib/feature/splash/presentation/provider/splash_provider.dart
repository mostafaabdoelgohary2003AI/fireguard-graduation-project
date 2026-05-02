import 'package:flutter/material.dart';

class SplashProvider extends ChangeNotifier {
  bool _isReady = false;

  bool get isReady => _isReady;

  void initialize() {
    Future.delayed(const Duration(seconds: 3), () {
      _isReady = true;
      notifyListeners();
    });
  }
}
