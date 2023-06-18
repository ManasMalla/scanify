import 'dart:io';

import 'package:flutter/material.dart';

class CropScreen extends StatelessWidget {
  const CropScreen({super.key, required this.path});
  final String path;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.file(File(path)),
      ),
    );
  }
}
