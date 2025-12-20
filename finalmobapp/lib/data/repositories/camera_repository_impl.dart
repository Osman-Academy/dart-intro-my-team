import '../../domain/entities/camera.dart';
import '../../domain/repositories/camera_repository.dart';
import '../datasources/dummy_data.dart';
import '../models/camera_model.dart';

class CameraRepositoryImpl implements CameraRepository {
  @override
  Future<List<Camera>> getCameras() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return dummyCameras.map((e) => CameraModel.fromJson(e)).toList();
  }

  @override
  Future<List<Camera>> searchCameras(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return dummyCameras
        .where((element) =>
            element['name'].toString().toLowerCase().contains(query.toLowerCase()) ||
            element['brand'].toString().toLowerCase().contains(query.toLowerCase()))
        .map((e) => CameraModel.fromJson(e))
        .toList();
  }

  @override
  Future<Camera> getCameraById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final data = dummyCameras.firstWhere((element) => element['id'] == id);
    return CameraModel.fromJson(data);
  }
}
