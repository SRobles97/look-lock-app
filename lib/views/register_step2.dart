import 'package:flutter/material.dart';
import 'package:look_lock_app/widgets/page_title.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          iconTheme: Theme.of(context).iconTheme,
        ),
        body: const Column(
          children: [
            PageTitle(
              title: 'CREACIÓN DE CUENTAS',
              subtitle:
                  'Para completar su registro en Look Lock debe subir una foto',
              subtitle2:
                  'De esta forma nuestro sistema podrá reconocerlo cuando desee ingresar',
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }
}
