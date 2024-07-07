import 'package:flutter/material.dart';
import 'package:clario_test_task_v2/input.dart';
import 'package:clario_test_task_v2/utils/validation.dart';

final _validators = [
  Validator(
      isValid: (value) => value != "",
      message: "Field is required.",
      pin: false),
  Validator(
      isValid: (value) =>
          value.length >= 8 && value.length <= 64 && !value.contains(" "),
      message: "8 characters or more (no spaces)"),
  Validator(isValid: strHasUpperCase, message: "At least one uppercase letter"),
  Validator(isValid: strHasDigit, message: "At least one digit")
];

class PasswordInput extends StatelessWidget {
  final String name;

  const PasswordInput({super.key, this.name = "password"});

  @override
  Widget build(BuildContext context) {
    return Input(
        hintText: "Enter your password",
        validators: _validators,
        canBeHidden: true,
        name: name,
        validateOnChange: true);
  }
}
