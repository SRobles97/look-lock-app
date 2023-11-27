import 'package:flutter/material.dart';
import 'package:look_lock_app/widgets/look_lock_logo.dart';
import 'package:look_lock_app/widgets/page_with_image_background.dart';
import 'package:look_lock_app/widgets/styled_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  void _login() {}

  void _register() {}

  @override
  Widget build(BuildContext context) {
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
              StyledButton(text: 'Iniciar sesión', onPressed: _login),
              const SizedBox(
                height: 10,
              ),
              StyledButton(
                  text: 'Crear cuenta',
                  onPressed: _register,
                  color: Theme.of(context).colorScheme.secondary),
            ],
          ),
        ));
  }
}
