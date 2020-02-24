import 'package:flutter/material.dart';
import 'package:flutter_dio/routes/application.dart';

class RoutesDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("fluro实例")),
      body: Center(
        child: InkWell(
          child: Text(
            "点击跳转",
            style: Theme.of(context).textTheme.display1,
          ),
          onTap: (){
            Application.router.navigateTo(context, "/detail?id=1111").then((result){
              print("/detail返回数据 result:$result");
            });
          },
        ),
      ),
    );
  }
}
