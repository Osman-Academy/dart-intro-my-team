import '../entities/camera.dart';
import '../repositories/camera_repository.dart';

class SearchCameras {
  final CameraRepository repository;

  SearchCameras(this.repository);

  Future<List<Camera>> call(String query) async {
    return await repository.searchCameras(query);
  }
}
