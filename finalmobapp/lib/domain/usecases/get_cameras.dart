import '../entities/camera.dart';
import '../repositories/camera_repository.dart';

class GetCameras {
  final CameraRepository repository;

  GetCameras(this.repository);

  Future<List<Camera>> call() async {
    return await repository.getCameras();
  }
}
