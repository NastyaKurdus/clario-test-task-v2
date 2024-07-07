import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormWithValidation extends StatefulWidget {
  final Widget child;
  final Function(Map<String, dynamic>) onSubmit;

  const FormWithValidation(
      {super.key, required this.child, required this.onSubmit});

  static FormWithValidationState? of(BuildContext context) =>
      context.findAncestorStateOfType<FormWithValidationState>();

  @override
  FormWithValidationState createState() => FormWithValidationState();
}

class FormWithValidationState extends State<FormWithValidation> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isSubmitted = false;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: _formKey,
        child: Column(
          children: <Widget>[
            widget.child,
            Padding(
              padding: const EdgeInsets.only(top: 35),
              child: Container(
                height: 48,
                width: 240,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Color.fromRGBO(112, 195, 255, 1),
                      Color.fromRGBO(75, 101, 255, 1)
                    ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                    borderRadius: BorderRadius.circular(30)),
                child: TextButton(
                  onPressed: () {
                    if (!isSubmitted) {
                      setState(() {
                        isSubmitted = true;
                      });
                    }

                    final invalidFields = _formKey.currentState!.fields.values
                        .where((f) => !f.isValid)
                        .toList();
                    if (invalidFields.isEmpty) {
                      _formKey.currentState!.save();
                      widget.onSubmit(_formKey.currentState!.value);
                    }
                  },
                  child: Text(
                    'Sign up',
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(color: Colors.white),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
