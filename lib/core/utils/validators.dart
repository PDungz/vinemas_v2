import 'package:form_field_validator/form_field_validator.dart';

class Validators {
  /// Email Validator
  static MultiValidator email({String? errorText, String? requiredError}) {
    return MultiValidator([
      RequiredValidator(
          errorText: requiredError ?? "This field cannot be empty"),
      EmailValidator(
          errorText: errorText ?? "Please enter a valid email address"),
    ]);
  }

  /// Password Validator
  static MultiValidator password({
    String? requiredError,
    String? minLengthError,
  }) {
    return MultiValidator([
      RequiredValidator(errorText: requiredError ?? 'Password cannot be empty'),
      MinLengthValidator(8,
          errorText:
              minLengthError ?? 'Password must be at least 8 characters long'),
    ]);
  }

  /// Phone Number Validator
  static MultiValidator phoneNumber({
    String? requiredError,
    String? lengthError,
    String? patternError,
  }) {
    return MultiValidator([
      RequiredValidator(
          errorText: requiredError ?? 'Phone number cannot be empty'),
      MinLengthValidator(10,
          errorText: lengthError ?? 'Phone number must have 10 digits'),
      MaxLengthValidator(10,
          errorText: lengthError ?? 'Phone number must have 10 digits'),
      PatternValidator(r'^[0-9]+$',
          errorText: patternError ?? 'Phone number must contain only digits'),
    ]);
  }

  /// Required Validator with Optional Field Name
  static RequiredValidator requiredWithFieldName(String fieldName) {
    return RequiredValidator(errorText: '$fieldName cannot be empty');
  }

  /// Plain Required Validator
  static RequiredValidator required({String? errorText}) {
    return RequiredValidator(
        errorText: errorText ?? 'This field cannot be empty');
  }
}
