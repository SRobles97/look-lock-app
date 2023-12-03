import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:look_lock_app/services/storage_services.dart';

class ImageSelector extends StatefulWidget {
  final String imagePath;
  final Function(String) onTap;

  const ImageSelector({Key? key, required this.imagePath, required this.onTap})
      : super(key: key);

  @override
  State<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  File? _image;

  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("¿De dónde quieres tomar la imagen?",
                  style: Theme.of(context).textTheme.bodyLarge),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                        child: Text("Galería",
                            style: Theme.of(context).textTheme.bodyMedium),
                        onTap: () {
                          _pickImage(ImageSource.gallery);
                          Navigator.pop(context);
                        }),
                    const Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                        child: Text("Cámara",
                            style: Theme.of(context).textTheme.bodyMedium),
                        onTap: () {
                          _pickImage(ImageSource.camera);
                          Navigator.pop(context); // Cierra el diálogo
                        })
                  ],
                ),
              ));
        });
  }

  Future<File?> _compressImage(File imageFile) async {
    try {
      img.Image? originalImage = img.decodeImage(imageFile.readAsBytesSync());
      if (originalImage == null) return null;
      List<int> compressedImageBytes =
          img.encodeJpg(originalImage, quality: 50);

      final Directory tempDir = Directory.systemTemp;
      final String uniqueFileName =
          'temp_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String targetPath = '${tempDir.path}/$uniqueFileName';

      File tempImageFile = File(targetPath)
        ..writeAsBytesSync(compressedImageBytes);

      if (tempImageFile.lengthSync() > 1048576) {
        return null;
      }

      return tempImageFile;
    } catch (e) {
      return null;
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? selectedImage = await picker.pickImage(source: source);
      if (selectedImage == null) return;

      File imageFile = File(selectedImage.path);
      File? compressedImage = await _compressImage(imageFile);

      if (compressedImage != null) {
        final String? imageUrl =
            await StorageServices.uploadImageToGitHub(compressedImage);

        if (imageUrl != null) {
          setState(() {
            _image = compressedImage;
            widget.onTap(imageUrl);
          });
        } else {}
      }
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showSelectionDialog(context),
      child: Container(
        height: 250,
        width: 250,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: widget.imagePath.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  _image!,
                  fit: BoxFit.cover,
                ),
              )
            : Icon(
                Icons.camera_alt,
                color: Theme.of(context).colorScheme.primary,
                size: 50,
              ),
      ),
    );
  }
}
