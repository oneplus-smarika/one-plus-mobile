// image_picker_dialog.dart
import 'package:flutter/material.dart';

class ImagePickerDialog extends StatelessWidget {
  final VoidCallback onCameraTap;
  final VoidCallback onGalleryTap;
  final VoidCallback onRemoveTap;

  const ImagePickerDialog({
    Key? key,
    required this.onCameraTap,
    required this.onGalleryTap,
    required this.onRemoveTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera),
            title: const Text('Capture Photo'),
            onTap: () {
              onCameraTap();
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Choose from Gallery'),
            onTap: () {
              onGalleryTap();
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.remove_circle_outline),
            title: const Text('Remove Image'),
            onTap: () {
              onRemoveTap();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
