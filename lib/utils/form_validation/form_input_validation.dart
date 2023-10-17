extension EmailValidator on String {
  String? isValidEmail(String? value) {
    bool valid = RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value!);
    if (!valid) {
      return "Please enter valid email";
    }
    return null;
  }

  String? isMemberIdValid(String? value) {
    if (value!.isEmpty) {
      return "Please enter memberID";
    }
    return null;
  }

  String? isValidName(String? value) {
    if (value!.isEmpty) {
      return "Please enter name";
    }
    return null;
  }

  String? iswordNumberValid(String? value) {
    if (value!.isEmpty) {
      return "Please enter ward number";
    }
    return null;
  }

  String? isFirtNameValid(String? value) {
    if (value!.isEmpty) {
      return "Please enter first name";
    }
    return null;
  }

  String? isLastNameValid(String? value) {
    if (value!.isEmpty) {
      return "Please enter last name";
    }
    return null;
  }

  String? isWordNumber(String? value) {
    if (value!.length < 1) {
      return "Please enter ward number";
    }
    return null;
  }

  String? isAddressValid(String? value) {
    if (value!.isEmpty) {
      return "Please enter address";
    }
    return null;
  }

  String? isPasswordValid(String? value) {
    if (value!.length <= 3) {
      return "Please enter password";
    }
    return null;
  }

  String? isPhoneValidate(String? value) {
    if (value!.length <= 9) {
      return "Please enter 10 digits number";
    }
    return null;
  }
}
