class FormValidator {
  static String? nameValidator(String? name) {
    if (name == null || name.isEmpty) {
      return 'Enter your name';
    }
    return null;
  }

  static String? collageNameValidator(String? name) {
    if (name == null || name.isEmpty) {
      return 'Enter your collage name';
    }
    return null;
  }

  static String? addressValidator(String? address) {
    if (address == null || address.isEmpty) {
      return 'Enter address';
    }
    return null;
  }

  static String? educationValidator(String? edu) {
    if (edu == null || edu.isEmpty) {
      return 'Enter your education level';
    }
    return null;
  }
}
