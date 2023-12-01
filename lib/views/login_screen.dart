import 'package:flutter/material.dart';
import 'package:look_lock_app/services/auth_services.dart';
import 'package:look_lock_app/services/storage_services.dart';
import 'package:look_lock_app/views/logged/home_screen.dart';

import 'package:look_lock_app/widgets/custom_appbar.dart';
import 'package:look_lock_app/widgets/image_selector.dart';
import 'package:look_lock_app/widgets/loading_screen.dart';
import 'package:look_lock_app/widgets/page_title.dart';
import 'package:look_lock_app/widgets/styled_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _imagePath = '';
  bool showImageMessage = false;

  bool _validateImage() {
    if (_imagePath.isEmpty) {
      setState(() {
        showImageMessage = true;
      });
      return false;
    } else {
      setState(() {
        showImageMessage = false;
      });
      return true;
    }
  }

  void _onImageSelected(String imagePath) {
    setState(() {
      _imagePath = imagePath;
    });
  }

  Future<void> _handleSubmit() async {
    if (_validateImage()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const LoadingScreen(
            title: "Procesando...",
            description: "Espere mientras procesamos su información.",
          );
        },
      );

      String loginMessage = await AuthServices().signInWithPhoto(_imagePath);

      if (!mounted) return;

      if (loginMessage == 'Inicio de sesión exitoso') {
        Navigator.pop(context);

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
            (route) => false);
      } else {
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loginMessage),
            duration: const Duration(seconds: 2),
          ),
        );
      }
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
                  ImageSelector(
                    imagePath: _imagePath,
                    onTap: _onImageSelected,
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
