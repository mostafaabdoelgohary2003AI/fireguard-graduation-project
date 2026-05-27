import 'package:flutter/material.dart';
import 'package:fire_gaurd/core/models/camera_model.dart';
import '../../data/repository/camera_repository.dart';

class CameraProvider extends ChangeNotifier {
  final CameraRepository cameraRepository;

  CameraProvider({required this.cameraRepository});

  List<Camera> _cameras = [];
  List<Zone> _zones = [];
  Camera? _selectedCamera;
  CameraStats? _stats;
  bool _isLoading = false;
  bool _isDeleting = false;
  bool _isUpdating = false;
  String? _error;

  List<Camera> get cameras => _cameras;
  List<Zone> get zones => _zones;
  Camera? get selectedCamera => _selectedCamera;
  CameraStats? get stats => _stats;
  bool get isLoading => _isLoading;
  bool get isDeleting => _isDeleting;
  bool get isUpdating => _isUpdating;
  String? get error => _error;

  int get totalCameras => _cameras.length;
  int get activeCameras => _cameras.where((c) => c.status == 'online').length;

  Future<void> updateCamera(int id, Map<String, dynamic> data) async {
    _isUpdating = true;
    _error = null;
    notifyListeners();

    try {
      _selectedCamera = await cameraRepository.updateCamera(id, data);
      await fetchCameras(); // Refresh the main list
    } catch (e) {
      _error = e.toString();
    } finally {
      _isUpdating = false;
      notifyListeners();
    }
  }

  Future<void> deleteCamera(int id) async {
    _isDeleting = true;
    _error = null;
    notifyListeners();

    try {
      await cameraRepository.deleteCamera(id);
      await fetchCameras(); // Refresh the list
    } catch (e) {
      _error = e.toString();
    } finally {
      _isDeleting = false;
      notifyListeners();
    }
  }

  Future<void> fetchCameraById(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _selectedCamera = await cameraRepository.getCameraById(id);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchZones() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _zones = await cameraRepository.getZones();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCameras() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _cameras = await cameraRepository.getCameras();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCameraStats() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _stats = await cameraRepository.getCameraStats();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addCamera(Camera camera, {String? localImagePath}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final newCamera = await cameraRepository.addCamera(camera, localImagePath: localImagePath);
      _cameras.add(newCamera);
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Zone> addZone(String name) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final newZone = await cameraRepository.addZone(name);
      _zones.add(newZone);
      return newZone;
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
