import 'package:flutter/material.dart';

import 'package:look_lock_app/views/login_screen.dart';
import 'package:look_lock_app/views/register_screen.dart';
import 'package:look_lock_app/widgets/look_lock_logo.dart';
import 'package:look_lock_app/widgets/page_with_image_background.dart';
import 'package:look_lock_app/widgets/styled_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void login() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ));
    }

    void register() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RegisterScreen(),
          ));
    }

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: PageWithImageBackground(
          imageName: 'background',
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              const LookLockLogo(
                name: 'Logo',
                width: 300,
                shadow: true,
              ),
              const SizedBox(
                height: 100,
              ),
              StyledButton(text: 'Iniciar sesión', onPressed: login),
              const SizedBox(
                height: 10,
              ),
              StyledButton(
                  text: 'Crear cuenta',
                  onPressed: register,
                  color: Theme.of(context).colorScheme.secondary),
            ],
          ),
        ));
  }
}
