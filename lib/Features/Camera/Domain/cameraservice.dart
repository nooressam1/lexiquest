import 'package:camera/camera.dart';

abstract class Cameraservice {
  Future<void> initCamera();
 Future<XFile?> takePhoto();
  CameraController? get controller;
}
