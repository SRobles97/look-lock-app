import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:look_lock_app/services/storage_services.dart';

class ImageSelector extends StatefulWidget {
  final String imagePath;
  final Function onTap;

  const ImageSelector({Key? key, required this.imagePath, required this.onTap})
      : super(key: key);

  @override
  State<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  String _imagePath = '';
  File? _image;

  @override
  void initState() {
    super.initState();
    _imagePath = widget.imagePath;
  }

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

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? selectedImage = await picker.pickImage(source: source);

      if (selectedImage != null) {
        final File imageFile = File(selectedImage.path);

        final String? imageUrl =
            await StorageServices.uploadImageToGitHub(imageFile);

        if (imageUrl != null) {
          if (kDebugMode) {
            print('Imagen cargada con éxito: $imageUrl');
          }
          setState(() {
            _image = imageFile;
            _imagePath = imageUrl;
          });

          widget.onTap(_imagePath);
        } else {
          if (kDebugMode) {
            print('Error al cargar la imagen.');
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al cargar la imagen: $e');
      }
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
        child: _imagePath.isNotEmpty
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
