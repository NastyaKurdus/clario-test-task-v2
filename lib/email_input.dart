import 'package:flutter/material.dart';
import 'package:clario_test_task_v2/input.dart';
import 'package:clario_test_task_v2/utils/validation.dart';

final _validators = [
  Validator(
      isValid: (value) => value != "",
      message: "Field is required",
      pin: false),
  Validator(
      isValid: (value) =>
          value == "" || regExpEmail.hasMatch(value),
      message: "Field doesn't look right",
      pin: false)
];

class EmailInput extends StatelessWidget {
  final String name;

  const EmailInput({super.key, this.name = "email"});

  @override
  Widget build(BuildContext context) {
    return Input(
        hintText: "Enter your email", validators: _validators, name: name);
  }
}
