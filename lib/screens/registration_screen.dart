import 'package:chat/components/rounded_button.dart';
import 'package:chat/constants.dart';
import 'package:chat/errors.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  const RegistrationScreen({Key? key}) : super(key: key);
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
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
                        hintText: 'Enter your email')),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  obscureText: true, //şifreyi görünmez yapıyor
                  textAlign: TextAlign.center,
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
                    buttonTitle: 'Register',
                    onPressed: () async {
                      final progress = ProgressHUD.of(context);
                      progress?.show();
                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .createUserWithEmailAndPassword(
                                email: email!, password: password!);
                        Navigator.pushNamed(context, ChatScreen.id);
                        progress!.dismiss();
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          ErrorCode(
                            tittle: 'Password',
                            description: 'Password is to weak.',
                          ).alert(context);
                          progress!.dismiss();
                        } else if (e.code == 'email-already-in-use') {
                          ErrorCode(
                            description: 'Email in use',
                            tittle: 'Email already in use.',
                          ).alert(context);
                          progress!.dismiss();
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    colour: Colors.blueAccent)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
