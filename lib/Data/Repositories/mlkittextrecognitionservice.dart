import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:lexiquest/Features/Camera/Domain/texttecognitionservice.dart';

class MLKitTextRecognitionService implements TextRecognitionService {
  @override
  Future<String> extractText(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);

    final recognizers = [
      TextRecognizer(script: TextRecognitionScript.latin),
      TextRecognizer(script: TextRecognitionScript.korean),
      TextRecognizer(script: TextRecognitionScript.japanese),
      TextRecognizer(script: TextRecognitionScript.chinese),
    ];

    String finalText = "";
    for (var recognizer in recognizers) {
      final result = await recognizer.processImage(inputImage);
      finalText += "${result.text.trim()}\n";
      await recognizer.close();
    }

    return finalText.trim();
  }
}
