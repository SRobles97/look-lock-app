import 'package:flutter/material.dart';
import 'package:look_lock_app/utils/theme_helper.dart';

class MyTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final bool obscureText;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextInputAction textInputAction;
  final FormFieldValidator<String>? validator;
  final bool clearButton;
  final Function(String)? onSubmitted;

  const MyTextFormField({
    Key? key,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.focusNode,
    this.nextFocusNode,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.clearButton = false,
    this.onSubmitted,
  }) : super(key: key);

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  late bool isObscured;
  bool isFieldEmpty = true;

  @override
  void initState() {
    super.initState();
    isObscured = widget.obscureText;
    isFieldEmpty = widget.controller.text.isEmpty;
    widget.controller.addListener(_updateIsFieldEmpty);
  }

  void _updateIsFieldEmpty() {
    if (isFieldEmpty != widget.controller.text.isEmpty) {
      setState(() {
        isFieldEmpty = widget.controller.text.isEmpty;
      });
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateIsFieldEmpty);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: isObscured,
      keyboardType: widget.keyboardType,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.0),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        errorStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.red,
            ),
        labelText: widget.label,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.0),
          borderSide: const BorderSide(color: ThemeHelper.primary, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        labelStyle: Theme.of(context).textTheme.bodyLarge,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: _buildSuffixIcon(),
      ),
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: (value) {
        if (widget.nextFocusNode != null) {
          widget.nextFocusNode!.requestFocus();
        }
        if (widget.onSubmitted != null) {
          widget.onSubmitted!(value);
        }
      },
      validator: widget.validator,
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.obscureText) {
      return IconButton(
        icon: Icon(isObscured ? Icons.visibility : Icons.visibility_off,
            color: ThemeHelper.primary),
        onPressed: () => setState(() => isObscured = !isObscured),
      );
    } else if (widget.clearButton && !isFieldEmpty) {
      return IconButton(
        icon: const Icon(Icons.clear, color: ThemeHelper.primary),
        onPressed: () {
          widget.controller.clear();
          _updateIsFieldEmpty();
        },
      );
    }
    return null;
  }
}
