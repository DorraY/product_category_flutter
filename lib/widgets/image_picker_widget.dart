import 'dart:io';


import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ImagePickerWidget extends StatefulWidget {
  late final CameraDescription camera;

  ImagePickerWidget(this.camera);

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  String? imagePath;

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  takePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();
      setState(() {
        imagePath = image.path;
      });

      print(image.path);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        imagePath==null ? Container() : Image.file(File(imagePath!)),
        TextButton.icon(
          onPressed: takePicture,
          icon: const Icon(Icons.camera_alt),
          label: const Text('Take photo'),
        ),
      ],
    );
  }
}
