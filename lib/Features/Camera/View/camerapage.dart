import 'package:flutter/material.dart';
import 'package:lexiquest/Data/Repositories/mlkittextrecognitionservice.dart';
import 'package:lexiquest/Data/Repositories/camerarepository.dart';
import 'package:lexiquest/Features/Camera/ViewModels/cameraviewmodel.dart';
import 'camerapreviewwidget.dart';
import 'package:provider/provider.dart';

class Camerapage extends StatelessWidget {
  const Camerapage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Cameraviewmodel(
        cameraRepo: Camerarepository(),
        textService: MLKitTextRecognitionService(),
      )..initCamera(),
      child: Consumer<Cameraviewmodel>(
        builder: (context, viewModel, _) {
          if (viewModel.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (viewModel.permissionDenied || viewModel.controller == null) {
            return const Scaffold(
              body: Center(child: Text("Camera permission denied.")),
            );
          }

          return Scaffold(
            body: Stack(
              children: [
                CameraPreviewWidget(controller: viewModel.controller!),
                if (viewModel.isProcessing)
                  const Center(child: CircularProgressIndicator()),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: FloatingActionButton(
                    onPressed: () async {
                      await viewModel.takePhotoAndRecognize("hello");
                    },
                    child: const Icon(Icons.camera_alt, size: 30),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
