import 'package:flutter/material.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';

class SplashPageDemo extends StatefulWidget {
  @override
  _SplashPageDemoState createState() => _SplashPageDemoState();
}

class _SplashPageDemoState extends State<SplashPageDemo> {
  @override
  void initState() {
    super.initState();
    hideScreen();
  }

  ///hide your splash screen
  Future<void> hideScreen() async {
    Future.delayed(Duration(milliseconds: 600), () {
      FlutterSplashScreen.hide();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.purple[200],
        appBar: AppBar(
          title: Text("启动屏Demo"),
        ),
        body: Center(
          child: Text(
            "我是内容~~~~~~~~",
            style: Theme.of(context).textTheme.display1,
          )
        )
      )
    );
  }
}
