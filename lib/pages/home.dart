import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mcl_fantasy/classes/dataClass.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Data data;

  // @override
  // void initState() {
  //   super.initState();
  //   data = Provider.of<Data>(context);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Provider.of<Data>(context) == null
            ? Text('onnu wait cheyetto')
            : Provider.of<Data>(context).matches.keys.length == 0
                ? Text('ivide onnum illa')
                : PageView(
                    children: [
                      for (String s in Provider.of<Data>(context).matches.keys)
                        Column(
                          children: [
                            Image.network(
                                "https://drive.google.com/uc?export=view&id=1pkRm-_6c_3JOTD0vWOXfSB_EI8ImccJY"),
                            Card(
                              child: Column(
                                children: [
                                  Text(
                                      '${Provider.of<Data>(context).matches[s].team1} vs ${Provider.of<Data>(context).matches[s].team2}'),
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
