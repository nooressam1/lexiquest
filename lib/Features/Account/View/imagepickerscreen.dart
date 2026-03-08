import 'package:flutter/material.dart';
import 'package:lexiquest/Features/Account/Domain/profilepicassets.dart';

class Imagepickerscreen extends StatelessWidget {
  final Function(int) onImageSelected;

  Imagepickerscreen({required this.onImageSelected});

  @override
  Widget build(BuildContext context) {
    final images = Profilepicassets.getAllImages(); // get list of paths

    return Scaffold(
      appBar: AppBar(title: const Text('Select Character')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          final path = images[index];
          final id = index + 1; // start at 1

          return GestureDetector(
            onTap: () {
              onImageSelected(id); // return selected ID
              Navigator.pop(context);
            },
            child: Image.asset(path),
          );
        },
      ),
    );
  }
}
