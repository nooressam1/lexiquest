import 'package:camera/camera.dart';
import 'package:lexiquest/Features/Camera/Domain/cameraservice.dart';

class Camerarepository implements Cameraservice {
  CameraController? _controller;

  @override
  CameraController? get controller => _controller;

  @override
  Future<void> initCamera() async {
    final camera = await availableCameras();
    final firstCamera = camera.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    await controller!.initialize();
  }

  @override
  Future<XFile?> takePhoto() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      return null;
    }
    return await _controller!.takePicture();
  }
}
