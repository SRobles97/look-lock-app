class ValidationHelper {
  static bool isEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  static bool isPassword(String password) {
    return RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{8,}$")
        .hasMatch(password);
  }

  static bool isUsername(String username, {int minLength = 6}) {
    String pattern = '^[a-zA-Z0-9]+( [a-zA-Z0-9]+)*\$';
    RegExp regExp = RegExp(pattern);
    String alphanumericOnly = username.replaceAll(' ', '');
    return alphanumericOnly.length >= minLength && regExp.hasMatch(username);
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'El correo electrónico es requerido';
    }
    if (!isEmail(email)) {
      return 'El correo electrónico no es válido';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'La contraseña es requerida';
    }
    if (!isPassword(password)) {
      return 'La contraseña debe contener al menos una letra \nmayúscula, una letra minúscula, un número, un carácter \nespecial y tener al menos 8 caracteres';
    }
    return null;
  }

  static String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'El nombre de usuario es requerido';
    }
    if (!isUsername(username)) {
      return 'El nombre de usuario debe tener al menos 6 caracteres \ny no debe contener espacios';
    }
    return null;
  }

  static String? validateConfirmPassword(
      String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'La confirmación de contraseña es requerida';
    }
    if (password != confirmPassword) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

  static String? validateField(String? field) {
    if (field == null || field.isEmpty) {
      return 'Este campo es obligatorio';
    }
    return null;
  }
}
