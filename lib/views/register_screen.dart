import 'package:flutter/material.dart';
import 'package:look_lock_app/utils/validation_helper.dart';
import 'package:look_lock_app/views/register_step2.dart';
import 'package:look_lock_app/widgets/custom_appbar.dart';
import 'package:look_lock_app/widgets/my_textformfield.dart';
import 'package:look_lock_app/widgets/page_title.dart';
import 'package:look_lock_app/widgets/styled_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  void onCompleted() {
    if (formKey.currentState!.validate()) {
      String email = emailController.text;
      String password = passwordController.text;
      String name = usernameController.text;

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                RegisterStep2(email: email, password: password, name: name),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        svgAssetPath: 'undraw_sign_up_n6im.svg',
        appBarHeight: 100,
        svgHeight: 80,
      ),
      body: Column(
        children: <Widget>[
          const PageTitle(
              title: 'CREACIÓN DE CUENTAS',
              subtitle: 'Ingrese sus datos para crear una cuenta nueva.',
              subtitle2: 'Si ya tiene una cuenta, puede iniciar sesión.'),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      MyTextFormField(
                          controller: emailController,
                          focusNode: emailFocusNode,
                          nextFocusNode: usernameFocusNode,
                          keyboardType: TextInputType.emailAddress,
                          label: 'Ingrese correo electrónico',
                          validator: (value) {
                            return ValidationHelper.validateEmail(value);
                          }),
                      const SizedBox(height: 10),
                      MyTextFormField(
                          controller: usernameController,
                          focusNode: usernameFocusNode,
                          nextFocusNode: passwordFocusNode,
                          keyboardType: TextInputType.text,
                          label: 'Ingrese nombre de usuario',
                          validator: (value) {
                            return ValidationHelper.validateUsername(value);
                          }),
                      const SizedBox(height: 10),
                      MyTextFormField(
                          controller: passwordController,
                          focusNode: passwordFocusNode,
                          nextFocusNode: confirmPasswordFocusNode,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          label: 'Ingrese contraseña',
                          validator: (value) {
                            return ValidationHelper.validatePassword(value);
                          }),
                      const SizedBox(height: 10),
                      MyTextFormField(
                          controller: confirmPasswordController,
                          focusNode: confirmPasswordFocusNode,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          label: 'Confirme contraseña',
                          validator: (value) {
                            return ValidationHelper.validateConfirmPassword(
                                passwordController.text, value);
                          }),
                      const SizedBox(height: 20),
                      StyledButton(text: 'Siguiente', onPressed: onCompleted)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
