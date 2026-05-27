import 'package:flutter/material.dart';
import '../../../../core/constant/app_strings.dart';
import '../../domain/entities/notification_entity.dart';

class NotificationProvider extends ChangeNotifier {
  String _selectedTab = AppStrings.all;

  final List<String> _tabs = [
    AppStrings.all,
    AppStrings.active,
    AppStrings.resolved,
    AppStrings.falseAlarm,
  ];

  final List<NotificationEntity> _mockData = const [
    NotificationEntity(
      id: "1",
      title: "Warehouse Section B",
      date: "TODAY • 14:22",
      status: NotificationStatus.active,
      confidence: "98.4%",
      zone: "01",
    ),
    NotificationEntity(
      id: "2",
      title: "Server Room",
      date: "YESTERDAY • 09:15",
      status: NotificationStatus.resolved,
      confidence: "92.1%",
      zone: "02",
    ),
    NotificationEntity(
      id: "3",
      title: "Main Entrance",
      date: "OCT 22, 2023 • 18:45",
      status: NotificationStatus.falseAlarm,
      confidence: "85.5%",
      zone: "03",
    ),
    NotificationEntity(
      id: "4",
      title: "Loading Dock",
      date: "OCT 20, 2023 • 11:30",
      status: NotificationStatus.resolved,
      confidence: "99.2%",
      zone: "04",
    ),
    NotificationEntity(
      id: "5",
      title: "Office Hallway",
      date: "OCT 18, 2023 • 03:10",
      status: NotificationStatus.resolved,
      confidence: "94.7%",
      zone: "05",
    ),
  ];

  String get selectedTab => _selectedTab;
  List<String> get tabs => _tabs;

  List<NotificationEntity> get filteredData {
    if (_selectedTab == AppStrings.all) return _mockData;
    if (_selectedTab == AppStrings.active) {
      return _mockData
          .where((e) => e.status == NotificationStatus.active)
          .toList();
    }
    if (_selectedTab == AppStrings.resolved) {
      return _mockData
          .where((e) => e.status == NotificationStatus.resolved)
          .toList();
    }
    return _mockData
        .where((e) => e.status == NotificationStatus.falseAlarm)
        .toList();
  }

  void selectTab(String tab) {
    _selectedTab = tab;
    notifyListeners();
  }
}
