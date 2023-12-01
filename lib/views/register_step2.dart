import 'package:flutter/material.dart';
import 'package:look_lock_app/services/auth_services.dart';
import 'package:look_lock_app/views/welcome_screen.dart';
import 'package:look_lock_app/widgets/image_selector.dart';
import 'package:look_lock_app/widgets/page_title.dart';
import 'package:look_lock_app/widgets/styled_button.dart';

class RegisterStep2 extends StatefulWidget {
  final String email;
  final String password;
  final String name;

  const RegisterStep2(
      {Key? key,
      required this.email,
      required this.password,
      required this.name})
      : super(key: key);

  @override
  State<RegisterStep2> createState() => _RegisterStep2State();
}

class _RegisterStep2State extends State<RegisterStep2> {
  String _imagePath = '';
  bool showImageMessage = false;

  void _onImageSelected(String imagePath) {
    setState(() {
      _imagePath = imagePath;
    });
  }

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

  Future<void> _handleSubmit() async {
    if (_validateImage()) {
      String signUpMessage = await AuthServices()
          .signUp(widget.email, widget.name, widget.password, _imagePath);

      if (!mounted) return;

      if (signUpMessage == 'Usuario registrado exitosamente') {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const WelcomeScreen(),
            ),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(signUpMessage),
            duration: const Duration(seconds: 1, milliseconds: 500),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          iconTheme: Theme.of(context).iconTheme,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const PageTitle(
              title: 'CREACIÓN DE CUENTAS',
              subtitle:
                  'Para completar su registro en Look Lock debe subir una foto',
              subtitle2:
                  'De esta forma nuestro sistema podrá reconocerlo cuando desee ingresar',
            ),
            const SizedBox(
              height: 30,
            ),
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
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: Colors.red,
                                )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            StyledButton(text: 'Crear cuenta', onPressed: _handleSubmit),
            const SizedBox(
              height: 30,
            ),
          ],
        ));
  }
}
