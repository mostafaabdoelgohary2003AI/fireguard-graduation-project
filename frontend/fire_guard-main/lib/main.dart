import 'package:fire_gaurd/fire_gaurd.dart';
import 'package:flutter/material.dart';

import 'package:fire_gaurd/core/services/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(const FireGaurd());
}
