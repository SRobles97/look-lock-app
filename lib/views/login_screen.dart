import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:look_lock_app/services/storage_services.dart';
import 'package:look_lock_app/widgets/custom_appbar.dart';
import 'package:look_lock_app/widgets/page_title.dart';
import 'package:look_lock_app/widgets/styled_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  File? _image;
  String? _imagePath;
  bool showImageMessage = false;

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

  bool _validateImage() {
    if (_imagePath != null) {
      setState(() {
        showImageMessage = false;
      });
      return true;
    } else {
      setState(() {
        showImageMessage = true;
      });
      return false;
    }
  }

  void _handleSubmit() {
    if (_validateImage()) {
      // TODO: Conectar con el servicio de reconocimiento facial
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        appBarHeight: 150,
        svgHeight: 100,
        svgAssetPath: 'undraw_login_re_4vu2.svg',
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: <Widget>[
          const PageTitle(
              title: 'INICIO DE SESIÓN',
              subtitle:
                  'Para ingresar a Look Lock debes tomar una foto de tu rostro.',
              subtitle2: 'Si tu rostro es reconocido, podrás ingresar.'),
          const SizedBox(height: 30),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      _showSelectionDialog(context);
                    },
                    child: Container(
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _imagePath != null
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Visibility(
                      visible: showImageMessage,
                      child: Text(
                          'Debes tomar una foto de tu rostro para continuar.',
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: Colors.red,
                                  )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          StyledButton(onPressed: _handleSubmit, text: 'Confirmar cuenta'),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
