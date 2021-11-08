import 'package:chat/components/rounded_button.dart';
import 'package:chat/constants.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat/errors.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ProgressHUD(
        child: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                const SizedBox(
                  height: 48.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email'),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password'),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                    buttonTitle: 'Login',
                    onPressed: () async {
                      final progress = ProgressHUD.of(context);
                      progress?.show();
                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithEmailAndPassword(
                                email: email!, password: password!);
                        Navigator.pushNamed(context, ChatScreen.id);
                        progress?.dismiss();
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          ErrorCode(
                                  tittle: 'Wrong email or password',
                                  description:
                                      'Mail address or password is wrong, try again!')
                              .alert(context);
                          progress?.dismiss();
                        } else if (e.code == 'wrong-password') {
                          ErrorCode(
                                  tittle: 'Wrong email or password',
                                  description:
                                      'Mail address or password is wrong, try again!')
                              .alert(context);
                          progress?.dismiss();
                        }
                      }
                    },
                    colour: Colors.lightBlueAccent)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
