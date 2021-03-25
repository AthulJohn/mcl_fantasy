import 'package:flutter/material.dart';
import 'package:mcl_fantasy/auth/sign.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Image.network(
                "https://drive.google.com/uc?export=view&id=1pkRm-_6c_3JOTD0vWOXfSB_EI8ImccJY"),
            Card(
              child: Column(
                children: [
                  TextButton(
                    child: Text('Signin'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color>((_) {
                        return Colors.red;
                      }),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                          (_) {
                        return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15));
                      }),
                    ),
                    onPressed: () {
                      AuthService().signInWithGoogle();
                    },
                  ),
                  Text('Please sign in using your MACE mail id.'),
                ],
              ),
            ),
            Image.network(
                "https://drive.google.com/uc?export=view&id=1WSDax83g2k3PC_R3-XU_YriW1F2Ulos3"),
          ],
        ),
      ),
    );
  }
}
