import 'package:flutter/material.dart';
import 'package:pushup_bro/ui/view/home.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: const Key('MainApp'),
      title: 'Pushup Bro',
      theme: ThemeData(
        fontFamily: 'NDS12',
        primarySwatch: Colors.blue,
      ),
      home: const Home(
        title: 'Flutter Demo Home Page',
        key: Key('Home'),
      ),
    );
  }
}
