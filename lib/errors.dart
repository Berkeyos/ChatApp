import 'package:chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

// ignore: must_be_immutable
class ErrorCode extends StatelessWidget {
  ErrorCode({
    Key? key,
    required this.description,
    required this.tittle,
  }) : super(key: key);

  final String tittle;
  String description;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Alarm'),
      onPressed: () => alert(context),
    );
  }

  void alert(context) async {
    await Alert(
      context: context,
      type: AlertType.error,
      title: tittle,
      desc: description,
      buttons: [
        DialogButton(
          child: const Text(
            'Ok',
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(116, 116, 191, 1.0),
              Color.fromRGBO(52, 138, 199, 1.0)
            ],
          ),
        ),
      ],
    ).show();
  }
}
