class LoginValidator {
  LoginValidator._();

  static String? loginValidator(String value, String? validationType) {
    final RegExp isEmail = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    switch (validationType) {
      case "email":
        {
          if (value.isEmpty) {
            return "Please enter your email";
          }
          if (!isEmail.hasMatch(value)) {
            return "Please enter a valid email";
          }
        }
      case "password":
        {
          if (value.isEmpty) {
            return "Please enter password";
          }
        }
    }
    return null;
  }
}
