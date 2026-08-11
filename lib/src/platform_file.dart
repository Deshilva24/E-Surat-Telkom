import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Widget buildPickedImage(XFile pickedFile) {
  final path = pickedFile.path;
  final name = pickedFile.name.toLowerCase();

  if (name.endsWith('.png') || name.endsWith('.jpg') || name.endsWith('.jpeg') || name.endsWith('.webp')) {
    final imageFile = path.startsWith('file://')
        ? File(Uri.parse(path).toFilePath())
        : File(path);

    return Image.file(
      imageFile,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }

  return Container(
    color: const Color(0xFFDCDCDC),
    alignment: Alignment.center,
    child: const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.image_not_supported, size: 80, color: Colors.grey),
        SizedBox(height: 8),
        Text('Format file tidak didukung'),
      ],
    ),
  );
}
