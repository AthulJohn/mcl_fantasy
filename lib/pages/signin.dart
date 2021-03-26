import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        body: SafeArea(
          child: Expanded(
            child: Column(
              children: [
                Image.network(
                    "https://drive.google.com/uc?export=view&id=1pkRm-_6c_3JOTD0vWOXfSB_EI8ImccJY"),
                Card(
                  child: Column(
                    children: [
                      Text('Signin'),
                      TextField(),
                      TextField(),
                    ],
                  ),
                ),
                Image.network(
                    "https://drive.google.com/uc?export=view&id=1WSDax83g2k3PC_R3-XU_YriW1F2Ulos3"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
