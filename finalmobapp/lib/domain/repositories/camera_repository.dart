import '../entities/camera.dart';

abstract class CameraRepository {
  Future<List<Camera>> getCameras();
  Future<List<Camera>> searchCameras(String query);
  Future<Camera> getCameraById(String id);
}
