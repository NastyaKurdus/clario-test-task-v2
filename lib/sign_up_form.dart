import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clario_test_task_v2/password_input.dart';
import 'package:clario_test_task_v2/email_input.dart';
import 'package:clario_test_task_v2/form_with_validation.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage('stars.png'),
        ),
        gradient: LinearGradient(colors: [
          Color.fromRGBO(244, 249, 255, 1),
          Color.fromRGBO(224, 237, 251, 1)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent.withOpacity(0),
          body: Center(
            child: SingleChildScrollView(
                child: SizedBox(
                    width: 315,
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(bottom: 35),
                            child: Text(
                              'Sign up',
                              style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    color: Color.fromRGBO(74, 78, 113, 1)),
                                fontWeight: FontWeight.w700,
                                fontSize: 28,
                              ),
                            )),
                        FormWithValidation(
                            child: const Column(children: <Widget>[
                              EmailInput(),
                              SizedBox(
                                height: 10,
                              ),
                              PasswordInput()
                            ]),
                            onSubmit: (data) {
                              print("data - ${data}");
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    CupertinoAlertDialog(
                                        title: Text(
                                  "Sign up success",
                                  style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                        color: Color.fromRGBO(39, 178, 116, 1)),
                                    fontSize: 16,
                                  ),
                                )),
                              );
                            })
                      ],
                    ))),
          )),
    );
  }
}
