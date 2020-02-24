import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  final id;

  const UserScreen({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("fluro实践"),
        ),
        body: Center(
          child: Text(
            "id:${id??-1}",
            style: Theme.of(context).textTheme.display1,
          ),
        ),
      ),
    );
  }
}
