import 'package:flutter/material.dart';
import '../../domain/entities/camera.dart';
import '../../domain/usecases/get_cameras.dart';
import '../../domain/usecases/search_cameras.dart';

class CameraProvider extends ChangeNotifier {
  final GetCameras getCameras;
  final SearchCameras searchCameras;

  CameraProvider({
    required this.getCameras,
    required this.searchCameras,
  });

  List<Camera> _cameras = [];
  List<Camera> get cameras => _cameras;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchCameras() async {
    _isLoading = true;
    notifyListeners();
    try {
      _cameras = await getCameras();
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> search(String query) async {
    _isLoading = true;
    notifyListeners();
    try {
      if (query.isEmpty) {
        await fetchCameras();
      } else {
        _cameras = await searchCameras(query);
      }
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
