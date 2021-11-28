import 'package:flutter/material.dart';

class ImagePickerWidget extends StatefulWidget {
  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: null, icon: const Icon(Icons.camera_alt), label: Text('Take photo'),);
  }
}
