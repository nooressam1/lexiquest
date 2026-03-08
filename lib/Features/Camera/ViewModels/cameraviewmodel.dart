import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:lexiquest/Data/Repositories/mlkittextrecognitionservice.dart';
import 'package:lexiquest/Data/Repositories/camerarepository.dart';
import 'package:permission_handler/permission_handler.dart';

class Cameraviewmodel extends ChangeNotifier {
  final Camerarepository cameraRepo;
  final MLKitTextRecognitionService textService;

  bool isLoading = true;
  bool isProcessing = false;
  bool permissionDenied = false;
  String recognizedText = "";

  Cameraviewmodel({required this.cameraRepo, required this.textService});

  Future<void> initCamera() async {
    isLoading = true;
    notifyListeners();

    // Deals with camera permission
    final status = await Permission.camera.request();
    if (!status.isGranted) {
      permissionDenied = true;
      isLoading = false;
      notifyListeners();
      return;
    }
    await cameraRepo.initCamera();

    isLoading = false;
    notifyListeners();
  }

  Future<void> takePhotoAndRecognize(String wordToFind) async {
    isProcessing = true;
    notifyListeners();

    final photo = await cameraRepo.takePhoto();

    if (photo == null) return;
    recognizedText = await textService.extractText(photo.path);
    notifyListeners();

    if (recognizedText.toLowerCase().contains(wordToFind.toLowerCase())) {
      print("The word '$wordToFind' was found!");
    } else {
      print("The word '$wordToFind' was NOT found.");
    }
    isProcessing = false;
    notifyListeners();
  }

  CameraController? get controller => cameraRepo.controller;
}
