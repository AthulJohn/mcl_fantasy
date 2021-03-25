import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          children: [
            Column(
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
            )
          ],
        ),
      ),
    );
  }
}
