import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clario_test_task_v2/form_with_validation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

const errorColor = Color.fromRGBO(255, 128, 128, 1);
const successColor = Color.fromRGBO(39, 178, 116, 1);
const initColor = Color.fromRGBO(74, 78, 113, 1);

class Validator {
  final bool Function(String) isValid;
  final String message;
  final bool pin;
  Validator({required this.isValid, required this.message,this.pin = true});
}

class Input extends StatefulWidget {
  final bool validateOnChange;
  final String hintText;
  final List<Validator> validators;
  final String name;
  final bool canBeHidden;

  const Input(
      {super.key,
      this.validateOnChange = false,
      required this.hintText,
      required this.validators,
      this.canBeHidden = false,
      required this.name});

  @override
  InputState createState() => InputState();
}

class InputState extends State<Input> {
  final _fieldKey = GlobalKey<FormBuilderFieldState>();
  FormWithValidationState? _formState;
  Set<Validator> _errors = {};

  bool _hadFocus = false;
  bool _isTouched = false;
  bool _isVisibleField = false;
  late void Function(String?) _onChange;

  @override
  void initState() {
    super.initState();
    _formState = FormWithValidation.of(context);
    _onChange = widget.validateOnChange ? _onValidation : (value) {};
  }

  String? _onValidation(String? value) {
    setState(() {
      _errors = widget.validators
          .where((v) => !v.isValid(value!))
          .toSet();
    });
    return _errors.isEmpty ? null : '';
  }

  @override
  Widget build(BuildContext context) {
    final showError = _isTouched || _formState?.isSubmitted == true;
    final success =
        _fieldKey.currentState?.isDirty == true ? successColor : initColor;
    final error = showError ? errorColor : initColor;
    final errorsChildren = widget.validators
        .map((v) {
          bool isError = _errors.contains(v);
          return (v.pin || (isError && showError))
              ? Text(
                  v.message,
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          color: isError ? error : success, fontSize: 13)),
                )
              : null;
        })
        .whereType<Widget>()
        .toList();

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Focus(
          onFocusChange: (hasFocus) {
            if (!_isTouched) {
              setState(() {
                _isTouched = !hasFocus && _hadFocus;
                _hadFocus = hasFocus;
              });
            }
            if (!hasFocus) {
              _onValidation(_fieldKey.currentState!.value);
            }
          },
          child: FormBuilderTextField(
            key: _fieldKey,
            validator: _onValidation,
            name: widget.name,
            initialValue: '',
            onChanged: _onChange,
            obscureText: widget.canBeHidden && !_isVisibleField,
            decoration: InputDecoration(
              suffixIcon: widget.canBeHidden
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          _isVisibleField = !_isVisibleField;
                        });
                      },
                      icon: _isVisibleField
                          ? const Icon(
                              Icons.visibility,
                              size: 16,
                              color: Color.fromRGBO(111, 145, 188, 1),
                            )
                          : const Icon(
                              Icons.visibility_off,
                              size: 16,
                              color: Color.fromRGBO(111, 145, 188, 1),
                            ),
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: _errors.isEmpty
                        ? _isTouched
                            ? successColor
                            : Colors.white
                        : errorColor),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(111, 145, 188, 1))),
              hintText: widget.hintText,
              hoverColor: Colors.white,
              focusColor: Colors.white,
              fillColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            ),
          )),
      Padding(
        padding: const EdgeInsets.only(top: 10, left: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: errorsChildren),
      )
    ]);
  }
}
