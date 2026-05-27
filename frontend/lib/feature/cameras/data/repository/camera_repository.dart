import 'package:dio/dio.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/services/endpoints.dart';
import '../../../../core/models/camera_model.dart';

class CameraRepository {
  final ApiService apiService;

  CameraRepository(this.apiService);

  Future<List<Camera>> getCameras() async {
    final response = await apiService.get(Endpoints.getCameras);
    final List data = response.data;
    return data.map((e) => Camera.fromJson(e)).toList();
  }

  Future<CameraStats> getCameraStats() async {
    final response = await apiService.get(Endpoints.getAllCameras);
    return CameraStats.fromJson(response.data);
  }

  Future<Camera> getCameraById(int id) async {
    final response = await apiService.get('${Endpoints.getCameras}$id/');
    return Camera.fromJson(response.data);
  }

  Future<void> deleteCamera(int id) async {
    await apiService.delete('${Endpoints.getCameras}$id/');
  }

  Future<Camera> updateCamera(int id, Map<String, dynamic> data) async {
    final response = await apiService.patch('${Endpoints.getCameras}$id/', data);
    return Camera.fromJson(response.data);
  }

  Future<Camera> addCamera(Camera camera, {String? localImagePath}) async {
    if (localImagePath != null && localImagePath.isNotEmpty) {
      final map = <String, dynamic>{
        'name': camera.name,
        'location': camera.location,
        'zone': camera.zone.id,
        'status': camera.status,
        'thumbnail': await MultipartFile.fromFile(
          localImagePath,
          filename: localImagePath.split('/').last,
        ),
      };
      final formData = FormData.fromMap(map);
      final response = await apiService.postMultipart(Endpoints.addCamera, formData);
      return Camera.fromJson(response.data);
    } else {
      final response = await apiService.post(Endpoints.addCamera, camera.toJson());
      return Camera.fromJson(response.data);
    }
  }

  Future<List<Zone>> getZones() async {
    final response = await apiService.get(Endpoints.getZones);
    final List data = response.data;
    return data.map((e) => Zone.fromJson(e)).toList();
  }

  Future<Zone> addZone(String name) async {
    final response = await apiService.post(Endpoints.addZone, {'name': name});
    return Zone.fromJson(response.data);
  }
}
