import 'package:flutter/material.dart';

import '../../domain/entities/camera_entity.dart';

class CameraProvider extends ChangeNotifier {
  final List<CameraEntity> _cameras = [
    const CameraEntity(id: "1", title: "Main Entrance"),
    const CameraEntity(id: "2", title: "Warehouse B"),
    const CameraEntity(id: "3", title: "Loading Dock"),
    const CameraEntity(id: "4", title: "Server Room"),
    const CameraEntity(id: "5", title: "Office Hallway"),
    const CameraEntity(id: "6", title: "Parking Lot"),
  ];

  List<CameraEntity> get cameras => _cameras;

  int get totalCameras => 12; // Example total
  int get activeCameras => _cameras.where((c) => c.isLive).length;
}
